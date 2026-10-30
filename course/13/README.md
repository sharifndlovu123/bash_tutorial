# Chapter 13: Named Pipes and Signals

- [`named-pipes/`](named-pipes/readme.md): `mkfifo`, blocking reads and writes, and a multi-client example
- [`trap-signals/`](trap-signals/readme.md): `trap`, exit handlers, debug traps and job control

Quick reference:

```bash
mkfifo pipe              # create a named pipe (not stored in git)
trap 'cleanup' EXIT      # run a handler when the script exits
trap -l                  # list all signals
kill -USR1 <pid>         # send a signal
jobs; fg; bg             # job control
```
