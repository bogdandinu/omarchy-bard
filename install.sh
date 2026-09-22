#!/usr/bin/env bash
# Installs the Bard for the current user and turns on the timer.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="$HOME/.local/share/omarchy-bard"
units="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"

mkdir -p "$dest" "$units"
cp -r "$src/bard" "$src/lang" "$src/assets" "$src/skill" "$dest/"
chmod +x "$dest/bard"
cp "$src/systemd/omarchy-bard.service" "$src/systemd/omarchy-bard.timer" "$units/"

# The agent skill, linked the way Omarchy links its own: wherever an agent already looks.
for skills in "$HOME/.claude/skills" "$HOME/.agents/skills"; do
  [[ -d "$skills" ]] && ln -sfn "$dest/skill" "$skills/omarchy-bard"
done

systemctl --user daemon-reload
systemctl --user enable --now omarchy-bard.timer

echo "The Bard is installed. A first visit, right now:"
"$dest/bard"
systemctl --user list-timers omarchy-bard.timer --no-pager
