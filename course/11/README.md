# Chapter 11: printf, Dates, mapfile and Regex

## printf

`printf` formats output. The format string comes first and each argument fills the next specifier. Prefer it over `echo` for anything non-trivial.

```bash
printf '%s\n' "$s"              # %s string
printf '%5s|%-5s|\n' ab cd      # width 5: right-aligned, then left-aligned
printf '<%*s>\n' 10 hello       # width from an argument
printf '%d\n' 42                # integer
printf '<%05d>\n' 10            # zero padded: <00010>
printf '%x %o\n' 255 8          # hex, octal
printf '%.2f\n' 3.14159         # 2 decimals
printf '%q\n' 'foo$bar'         # shell-escaped, safe to reuse
printf '%b\n' '\x0a'            # interpret backslash escapes
printf -v var 'hello %s' dave   # store the result in a variable, no subshell
```

Gotchas:

- A leading `0` means octal: `printf '%d' 010` is 8, and `08` is an error.
- If there are more arguments than specifiers, the format is reused for each (this is why `printf '%s\n' "${arr[@]}"` prints one per line).
- `%d` only accepts numbers.

More: `help printf`, `man 3 printf`.

## Dates

```bash
date +'%m/%d/%Y %H:%M:%S'       # external command; format codes in man strftime
printf '%(%Y-%m-%d)T\n' -1      # builtin, no process spawned
```

`%(fmt)T` takes a timestamp as its argument:

| Value | Meaning |
|-------|---------|
| `-1` | now |
| `-2` | when the shell started |
| `0` and up | seconds since the Unix epoch (1 Jan 1970) |

When mixed with other specifiers, give the date argument explicitly: `printf '%(%F)T name=%s\n' -1 dave`.

```bash
date +%s              # epoch seconds
echo $SECONDS         # seconds the shell has run
echo $EPOCHSECONDS    # epoch seconds (bash 5)
echo $EPOCHREALTIME   # with microseconds
```

## Reading files into arrays: mapfile

`mapfile` and `readarray` are the same builtin.

| Script | Approach |
|--------|----------|
| `00-while-read` | the manual loop |
| `01-mapfile` | `mapfile arr < file` keeps the trailing newlines |
| `02-mapfile-trim` | `-t` strips them |
| `03-mapfile-limit` | `-n 2` reads at most 2 lines |
| `04-mapfile-callback` | `-C func -c N` calls `func` every N lines |

The callback is invoked as `func INDEX LINE`. Note that `mapfile` loads the whole file into memory, which is dangerous for huge files; use a `while read` loop to stream.

## Regex

`[[ string =~ regex ]]` uses POSIX extended regex. Store the pattern in a variable and **leave it unquoted**.

```bash
re='^(d|j).*$'
if [[ $input =~ $re ]]; then
    echo "${BASH_REMATCH[0]}"   # whole match
    echo "${BASH_REMATCH[1]}"   # first capture group
fi
```

| Syntax | Meaning |
|--------|---------|
| `^` `$` | start / end |
| `.` | any character |
| `*` `+` `?` | 0+, 1+, 0 or 1 |
| `{4}` | exactly 4 |
| `[0-9]` | one digit |
| `( )` | capture group |
| `\|` | or |

`regex/reg` extracts a name and a date from file names like `fun family party - 2022-10-31.jpg`. `regex/fine` does the same with `cut`, which works but spawns many processes and is slower.
