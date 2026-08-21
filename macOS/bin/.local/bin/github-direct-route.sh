#!/bin/bash
set -u

if [ "$EUID" -ne 0 ]; then
  echo "Must run as root" >&2
  exit 1
fi

# 1. Clean up all prior /32 host routes we might have added.
# Anything with the H flag that isn't loopback is fair game if this script
# is the only thing adding host routes on your box.
echo "[$(date)] Cleaning up prior host routes..."
cleaned=0
while read -r ip; do
  route -n delete -host "$ip" >/dev/null 2>&1 && cleaned=$((cleaned + 1))
done < <(netstat -rn -f inet | awk '$3 ~ /H/ && $1 ~ /^[0-9]+\./ && $1 !~ /^(127|169\.254)/ { print $1 }')
echo "[$(date)] Cleaned $cleaned host route(s)"

# 2. Only re-add routes if the VPN is actually up.
if ! ifconfig | grep -qE '^(utun|ppp)[0-9]+:.*(UP|RUNNING)'; then
  echo "[$(date)] No VPN interface up — leaving routing table alone"
  exit 0
fi

DEFAULT_GATEWAY=$(netstat -nr -f inet \
  | awk '$1=="default" && $6 !~ /^(utun|ppp|ipsec)/ { print $2; exit }')
[ -z "$DEFAULT_GATEWAY" ] && { echo "No non-VPN gateway" >&2; exit 1; }
echo "[$(date)] Using gateway: $DEFAULT_GATEWAY"

DOMAINS=(
  github.com api.github.com codeload.github.com ssh.github.com
  objects.githubusercontent.com raw.githubusercontent.com
  github.githubassets.com avatars.githubusercontent.com
  camo.githubusercontent.com
)

for d in "${DOMAINS[@]}"; do
  ips=$(dig +short +time=2 +tries=1 @1.1.1.1 "$d" A | grep -E '^[0-9]+\.')
  if [ -z "$ips" ]; then
    echo "[$(date)] No IPs resolved for $d" >&2
    continue
  fi
  for ip in $ips; do
    if out=$(route -n add -host "$ip" "$DEFAULT_GATEWAY" 2>&1); then
      echo "[$(date)] Added $ip -> $DEFAULT_GATEWAY ($d)"
    else
      echo "[$(date)] Skip $ip ($d): $out" >&2
    fi
  done
done
