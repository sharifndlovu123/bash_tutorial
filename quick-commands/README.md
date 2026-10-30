# Quick commands

Small tricks that are easy to forget. For a broader reference see the [cheatsheet](../CHEATSHEET.md).

| File | Trick |
|------|-------|
| [`check-syntax.sh`](check-syntax.sh) | Check a script's syntax without running it, and read exit codes |
| [`empty-loop-bodies.sh`](empty-loop-bodies.sh) | Use `:` where Python would use `pass` |
| [`yes-into-pipe.md`](yes-into-pipe.md) | Auto-answer prompts with `yes` |

More one-liners:

```bash
!!                      # re-run the last command
sudo !!                 # ...with sudo
cd -                    # go back to the previous directory
command -v git          # is a command available?
mkdir -p a/b/c          # create nested directories
cp file{,.bak}          # quick backup
echo "$PATH" | tr : '\n'
ls -t | head -1         # most recently modified file
history | grep keyword
```
