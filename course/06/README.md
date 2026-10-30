# Chapter 06: Arguments, Debugging, Pipe Status and Timing

## Debugging scripts

```bash
bash -x script         # trace: print every command as it runs
bash -n script         # syntax check only, nothing is executed
bash -u script         # error on undefined variables
shellcheck script      # static analysis (install it, it is excellent)
```

After `bash -n`, `echo $?` should print `0`. Do not chain the flags (`-un`); run them separately.

Inside a script you can trace just one region and customise the prefix:

```bash
PS4='[debug]: '    # prefix for trace lines (default is '+ ')
set -x             # tracing on
full_name="$first $last"
set +x             # tracing off
```

Undefined-variable checks only see variables unset in the script. A value passed in the environment (`foo=haha ./script`) counts as defined. Remove one with `unset name`.

### Strict mode

Many scripts start with:

```bash
set -euo pipefail
```

- `-e` exit on the first failing command
- `-u` treat unset variables as errors
- `-o pipefail` a pipeline fails if any part fails

It helps, but has edge cases (for example `(( ))` returning 1 for a zero result). Read about it before relying on it.

## Pipe status

The exit code of a pipeline is that of its **last** command:

```bash
cat /this-doesnt-exist | tr , :
echo $?                       # 0, even though cat failed
```

`PIPESTATUS` holds the status of every stage, but only until the next command runs:

```bash
cat /this-doesnt-exist | tr , :
echo "${PIPESTATUS[@]}"       # 1 0

(exit 3) | (exit 2) | (exit 1) | (exit 0)
echo "${PIPESTATUS[@]}"       # 3 2 1 0
```

`set -o pipefail` makes `$?` report the last non-zero status instead.

## time

```bash
time echo hi
```

- **real**: wall-clock time you waited
- **user**: time spent running your program's own code
- **sys**: time spent in the kernel on its behalf

Run `htop` to see this live (green = user time, red = system time). `time` is a shell keyword; `type -a time` shows the separate `/usr/bin/time` program as well (`/usr/bin/time -v cmd` also reports memory use).

## Arguments

```bash
./script one two
$1 $2     # individual arguments
$@        # all of them, quoted separately as "$@"
$#        # count
```

`bash-args` shows a script reading `$1` and `$2` with tracing enabled.
