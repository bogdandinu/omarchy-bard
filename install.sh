#!/usr/bin/env bash
# Installs the Bard for the current user and turns on the timer.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="$HOME/.local/share/omarchy-bard"
units="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

mkdir -p "$dest" "$units"
cp -r "$src/bard" "$src/lang" "$src/assets" "$dest/"
chmod +x "$dest/bard"
cp "$src/systemd/omarchy-bard.service" "$src/systemd/omarchy-bard.timer" "$units/"

systemctl --user daemon-reload
systemctl --user enable --now omarchy-bard.timer

echo "The Bard is installed. A first song, right now:"
"$dest/bard"
systemctl --user list-timers omarchy-bard.timer --no-pager
