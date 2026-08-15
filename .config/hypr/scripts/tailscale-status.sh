#!/bin/bash
# Check if traffic is routed through the exit node
if ip route show table 52 2>/dev/null | grep -q 'default dev tailscale0'; then
    # Active state: Show Japan Flag
    echo '{"text": "🇯🇵", "tooltip": "Tokyo Exit Node: ACTIVE (Click to disconnect)", "class": "active"}'
else
    # Inactive state: Show Airplane Icon
    echo '{"text": "✈", "tooltip": "Tokyo Exit Node: INACTIVE (Click to connect)", "class": "inactive"}'
fi
