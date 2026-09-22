---
name: omarchy-bard
description: >
  Use when the user wants to change the Bard (omarchy-bard): the notifications that remind them a few
  times a day to unclench the jaw, drop the shoulders and type gently. Triggers: Bard, omarchy-bard,
  "the bard reminder", change when the Bard comes, add or edit Bard messages or titles, Bard language,
  pause or stop the Bard, test the Bard.
---

# omarchy-bard

The Bard is a desktop notification (no sound), sent by a systemd user timer. Each visit picks one
random title and one random message.

## Where things live

| What | Path | Edit? |
|---|---|---|
| Script, bundled texts, icon | `~/.local/share/omarchy-bard/` | **No.** Overwritten by `install.sh`. |
| Units | `~/.config/systemd/user/omarchy-bard.{service,timer}` | **No.** Overwritten by `install.sh`. |
| Schedule override | `~/.config/systemd/user/omarchy-bard.timer.d/*.conf` | Yes |
| Language | `~/.config/omarchy-bard/bard.conf` (`BARD_LANG=en`, `ro`, …) | Yes |
| The user's own texts | `~/.config/omarchy-bard/lang/<lang>/{titles,messages}.txt` | Yes |

All user changes go in `~/.config`. Never edit the installed copy.

## Change when the Bard comes

Write a drop-in, then reload. The empty `OnCalendar=` clears the defaults (Mon–Fri 10:30, 12:00, 13:30,
15:00, 16:30) before adding the new times.

```ini
# ~/.config/systemd/user/omarchy-bard.timer.d/schedule.conf
[Timer]
OnCalendar=
OnCalendar=Mon..Fri *-*-* 11:00:00
OnCalendar=Mon..Fri *-*-* 14:00:00
```

```sh
systemctl --user daemon-reload && systemctl --user restart omarchy-bard.timer
systemctl --user list-timers omarchy-bard.timer   # confirm the next visit
```

Do not add `Persistent=true`: missed visits would all arrive at once after boot.

## Change the texts

A user file **replaces** the bundled one for that language (it does not add to it). To add a line,
copy the bundled file first, then edit the copy:

```sh
mkdir -p ~/.config/omarchy-bard/lang/en
cp ~/.local/share/omarchy-bard/lang/en/messages.txt ~/.config/omarchy-bard/lang/en/
```

Rules: one message per line, `#` starts a comment, blank lines are ignored. Keep each message to about
three lines of the notification (roughly 130 characters); the Omarchy toast cuts the rest. The Bard
speaks in the first person, warm and a little playful, like a support character in an RPG: a healer and
mentor, never a drill sergeant.

A new language is a new folder with both files, `titles.txt` and `messages.txt`.

## Test, pause, remove

```sh
systemctl --user start omarchy-bard.service           # a visit right now
systemctl --user stop omarchy-bard.timer              # pause until next login
systemctl --user disable --now omarchy-bard.timer     # pause for good
```

To remove it completely, run `uninstall.sh` from the cloned repo. It keeps `~/.config/omarchy-bard`.
