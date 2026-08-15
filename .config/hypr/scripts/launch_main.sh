#!/bin/bash

# Check if a session named "main" already exists
if ! tmux has-session -t main 2>/dev/null; then
    # Create a detached session named "main" and name the first window "home"
    tmux new-session -d -s main -n "home"
    
    # Create window 2 for your Proxmox server SSH
    tmux new-window -t main:2 -n "server" "ssh omniscientlab"
    
    # Create window 3 for file exploration
    tmux new-window -t main:3 -n "files"
    
    # Set the focus back to window 1 so you start on your scratchpad
    tmux select-window -t main:1
fi

# Launch Ghostty and attach it to the session
ghostty -e tmux attach-session -t main
