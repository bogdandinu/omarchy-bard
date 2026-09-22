#!/usr/bin/env bash
# Removes the Bard. Your own lines in ~/.config/omarchy-bard are left alone.
set -euo pipefail

units="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

systemctl --user disable --now omarchy-bard.timer 2>/dev/null || true
rm -f "$units/omarchy-bard.service" "$units/omarchy-bard.timer"
rm -rf "$units/omarchy-bard.timer.d"
rm -f "$HOME/.claude/skills/omarchy-bard" "$HOME/.agents/skills/omarchy-bard"
rm -rf "$HOME/.local/share/omarchy-bard"
systemctl --user daemon-reload

echo "The Bard has left the inn."
