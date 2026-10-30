# Is a TTY?

Programs behave differently when output goes to a terminal versus a pipe or file.

```bash
ls            # columns, in a terminal
ls | cat      # one per line, because stdout is a pipe
```

Save as `check-terminal` and `chmod +x` it:

```bash
#!/usr/bin/env bash
if [[ -t 1 ]]; then
  echo stdout is a terminal
else
  echo stdout is NOT a terminal
fi
```

```bash
./check-terminal
./check-terminal | cat
./check-terminal | less
```

`ls --color` uses the same idea:

| Option | Meaning |
|--------|---------|
| `auto` | colour only if stdout is a terminal |
| `always` | force colour |
| `never` | no colour |

```bash
ls --color=auto
ls --color=always | cat -v    # shows the escape codes
ls --color=never
```
