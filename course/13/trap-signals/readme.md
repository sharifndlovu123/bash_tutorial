# Trap Signals

`trap` runs a handler when the shell receives a signal or hits a special event.

```bash
help trap
trap -l          # list every signal
trap -p          # show current traps
```

Signals are delivered by the OS; bash lets you respond to them.

| Signal | Trigger |
|--------|---------|
| `SIGINT` (2) | `Ctrl-C`, interrupt |
| `SIGTERM` (15) | default signal sent by `kill` |
| `SIGTSTP` | `Ctrl-Z`, suspend |
| `SIGWINCH` | terminal was resized |
| `SIGUSR1` / `SIGUSR2` | free for your own use (`kill -USR1 <pid>`) |
| `SIGINFO` | BSD/macOS only (`Ctrl-T`); not on Linux |
| `SIGKILL` (9) | cannot be trapped |

Bash also has pseudo-signals: `EXIT` (the shell is about to exit), `ERR` (a command failed), `DEBUG` (before every command) and `RETURN`.

## Examples in this folder

| File | Shows |
|------|-------|
| `00-simple-exit` | `trap cleanup EXIT` runs the handler when the script ends |
| `01-exit-code` | the handler still runs on `exit 1`, and the code is kept |
| `02-exit-override` | calling `exit 2` inside the handler replaces the exit code |
| `03-trap-debug` | `trap f DEBUG` prints each command first (like `bash -x`) |
| `04-trap-info` | a custom signal handler on a running loop |

The typical use of `EXIT` is cleanup:

```bash
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
```

## Job control

```bash
Ctrl-Z      # suspend the foreground job
bg          # resume it in the background
fg          # bring it back
jobs        # list jobs
kill %1     # signal job 1 (SIGTERM by default); %% is the most recent job
kill -USR1 <pid>
```
