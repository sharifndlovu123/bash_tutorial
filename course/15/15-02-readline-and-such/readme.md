# Readline Shortcuts

Bash's line editor (readline) uses Emacs-style keys by default.

## Moving

| Key | Action |
|-----|--------|
| `Ctrl-a` / `Ctrl-e` | start / end of line |
| `Ctrl-f` / `Ctrl-b` | forward / back one character |
| `Alt-f` / `Alt-b` | forward / back one word |

## Editing

| Key | Action |
|-----|--------|
| `Ctrl-w` | delete one word back |
| `Alt-d` | delete one word forward |
| `Ctrl-u` | delete from the cursor to the start of the line |
| `Ctrl-k` | delete from the cursor to the end of the line |
| `Ctrl-y` | paste what you just deleted |
| `Ctrl-t` / `Alt-t` | swap characters / words |
| `Ctrl-_` | undo |

## History and screen

| Key | Action |
|-----|--------|
| `Ctrl-r` | reverse search history (repeat to go further back) |
| `Ctrl-p` / `Ctrl-n` | previous / next command |
| `Alt-.` | insert the last argument of the previous command |
| `Ctrl-l` | clear the screen |
| `Ctrl-c` | cancel the current command |
| `Ctrl-d` | end of input / exit the shell |

```bash
history            # list commands
history | grep ssh
!!                 # the last command
!$                 # the last argument of the last command
```

Customise keys in `~/.inputrc`. See `man readline`.
