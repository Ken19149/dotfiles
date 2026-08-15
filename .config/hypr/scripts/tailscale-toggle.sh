#!/bin/bash
if ip route show table 52 2>/dev/null | grep -q 'default dev tailscale0'; then
    tailscale up --exit-node=
else
    tailscale up --exit-node=100.76.89.123
fi
