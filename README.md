# omarchy-bard

A support character for [Omarchy](https://omarchy.org). A few times a day the Bard drops by with a
notification (silent, no sound) and reminds you to unclench your jaw, drop your shoulders and type gently: no anger, no
hurry, with intent.

![The Bard](assets/screenshot.png)

I made it for myself: incipient arthritis in my fingers, severe bruxism, and a habit of typing like I'm
hitting war drums. Maybe it helps you too.

## Install

```sh
git clone https://github.com/bogdandinu/omarchy-bard.git
cd omarchy-bard
./install.sh
```

It copies itself to `~/.local/share/omarchy-bard`, installs a systemd user timer and shows you a first visit
right away. It needs nothing beyond what Omarchy already has (`notify-send`, systemd).

## When the Bard comes

Monday to Friday at 10:30, 12:00, 13:30, 15:00 and 16:30. A missed visit (machine off or asleep) is not
made up later. To change the schedule:

```sh
systemctl --user edit omarchy-bard.timer
```

```ini
[Timer]
OnCalendar=
OnCalendar=Mon..Fri *-*-* 11:00:00
OnCalendar=Mon..Fri *-*-* 14:00:00
```

The empty `OnCalendar=` clears the default times before adding yours.

The notification stays on screen until you dismiss it. That's on purpose: you take the Bard's advice
consciously, you don't let it fade away.

## Language

English and Romanian are included. The Bard follows your system locale, falling back to English. To pick
one explicitly:

```sh
mkdir -p ~/.config/omarchy-bard
echo 'BARD_LANG=ro' > ~/.config/omarchy-bard/bard.conf
```

## Your own lines

Put a `messages.txt` or `titles.txt` in `~/.config/omarchy-bard/lang/<lang>/` and it replaces the bundled
one. One line per message, `#` for comments. Keep each message to about three lines, since the Omarchy
toast cuts the rest. A new language is just a new folder.

## Try it now

```sh
systemctl --user start omarchy-bard.service
```

## Ask your agent

The Bard ships with an agent skill, [`skill/SKILL.md`](skill/SKILL.md), the same way Omarchy ships its own.
`install.sh` links it into `~/.claude/skills/` and `~/.agents/skills/` when those folders exist, so you can
just ask Claude Code, Codex or any agent that reads skills:

> Make the Bard come only at 11 and 14.
> Add a message about drinking water, in the Bard's voice.
> Teach the Bard French.

The skill tells the agent where your settings live and to leave the installed copy alone.

## Uninstall

```sh
./uninstall.sh
```

Your own lines in `~/.config/omarchy-bard` are left alone.

## Why no settings panel

Because the Bard is done. It works as it is: free, no warranty, take it or leave it.

## License

MIT. The pixel-art lute (`assets/bard-lute.svg`) is part of it.
