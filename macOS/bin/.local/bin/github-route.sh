#!/bin/bash

# Get the default gateway (excluding VPN interfaces like utun)
get_gateway() {
  # Method 1: Get gateway from default route, excluding VPN interfaces
  netstat -nr | grep default | grep -v utun | grep -v ppp | awk '{print $2}' | head -1
}

# Get active network interface
get_interface() {
  route -n get default | grep interface | awk '{print $2}'
}

# Get gateway for specific interface
get_interface_gateway() {
  local iface=$(get_interface)
  # Filter for non-VPN interface (en0 for ethernet, en1/en0 for WiFi)
  if [[ $iface == en* ]]; then
    netstat -nr | grep default | grep $iface | awk '{print $2}' | head -1
  else
    echo ""
  fi
}

# Get the proper gateway
GATEWAY=$(get_interface_gateway)

# Fallback to general method if interface method fails
if [ -z "$GATEWAY" ]; then
  GATEWAY=$(get_gateway)
fi

if [ -z "$GATEWAY" ]; then
  echo "Could not detect gateway"
  exit 1
fi

echo "Using gateway: $GATEWAY"

# GitHub IP ranges (update as needed)
GITHUB_IPS=(
  "140.82.121.3"
  "140.82.121.4"
)

# Add routes
for IP in "${GITHUB_IPS[@]}"; do
  echo "Adding route for $IP via $GATEWAY"
  sudo route -n delete $IP 2>/dev/null # Remove if exists
  sudo route -n add $IP $GATEWAY
done

route -n get github.com
