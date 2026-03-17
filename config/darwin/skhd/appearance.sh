#!/bin/sh
set -eu

if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null || true)" = "Dark" ]; then
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to false'
else
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
fi

if command -v tmux >/dev/null 2>&1; then
  tmux start-server >/dev/null 2>&1 || true
  tmux source-file "$HOME/.config/tmux/tmux.conf" >/dev/null 2>&1 || true
fi
