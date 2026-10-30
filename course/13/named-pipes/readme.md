# Named Pipes

A named pipe (FIFO) is a special file that connects one process that writes to another that reads. Nothing is stored on disk.

```bash
mkfifo pipe          # create it (it is not tracked in git, so create it yourself)
```

## Blocking behaviour

Open two terminals (or split a tmux pane):

```bash
# A                     # B
cat pipe                echo hi > pipe
```

`cat pipe` hangs until something is written. Reversed, `echo hi > pipe` hangs until something reads. Opening either end **blocks** until the other end is opened.

## Examples

| File | Shows |
|------|-------|
| `00-basic-reader` | read lines from the pipe, then exit |
| `01-forever-read` | wrap the reader in `while true` so it keeps reading |
| `02-client-writer` | a writer that sends a message every 3 seconds |
| `03-all-in-one` | one script: reader plus three background clients |

Run several writers against one reader:

```bash
./01-forever-read &
./02-client-writer foo &
./02-client-writer bar &
./02-client-writer baz &
```

`03-all-in-one` opens the pipe once for reading **and** writing with `exec {fd}<>pipe`, and then uses that file descriptor, which avoids the reader exiting every time a writer closes. Clean up with `kill $(jobs -p)` and `rm pipe`.
