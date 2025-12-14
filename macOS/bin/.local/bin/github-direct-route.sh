#!/bin/bash

# Get gateway excluding VPN tunnel interfaces
DEFAULT_GATEWAY=$(/usr/sbin/netstat -nr | grep default | grep -v utun | grep -v ppp | awk '{ print $2 }' | head -1)

if [ -z "$DEFAULT_GATEWAY" ]; then
  echo "[$(date)] Could not find default gateway, exiting"
  exit 1
fi

echo "[$(date)] Using gateway: $DEFAULT_GATEWAY"

# GitHub domains
DOMAINS="github.com"

# Add routes for each GitHub IP
for domain in $DOMAINS; do
  for ip in $(dig +short "$domain" A | grep -E '^[0-9]+\.'); do
    /sbin/route -n add -host "$ip" "$DEFAULT_GATEWAY" 2>/dev/null &&
      echo "[$(date)] Added route: $ip -> $DEFAULT_GATEWAY" ||
      echo "[$(date)] Route exists: $ip"
  done
done
