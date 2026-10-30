# Chapter 09: Globbing

Run the examples from this folder (they use `files/` and `empty/`).

## Basic patterns

The shell expands a glob **before** the command runs.

```bash
echo files/*            # becomes: echo files/bar.jpg files/bar.txt ...
ls -1 files/*.txt
ls -1 files/bar.*
ls -1 files/ba?.*       # ? = exactly one character
ls -1 files/ba[abcrz].* # [..] = one of these characters
ls -1 files/ba[a-z].*   # a range
ls -1 files/ba[!r].*    # NOT these characters
```

`*` matches zero or more characters, `?` exactly one. They never match a leading `.` or cross a `/`.

## Options (`shopt`)

List them with `shopt`, turn on with `shopt -s name`, off with `shopt -u name`.

| Option | Effect |
|--------|--------|
| `nullglob` | A glob with no matches becomes nothing (default: stays as the literal text) |
| `dotglob` | `*` also matches hidden files |
| `globstar` | `**` matches recursively, like `find` |
| `extglob` | Extended patterns (below) |
| `nocaseglob` | Case-insensitive matching |

Example of the default behaviour:

```bash
printf '<%s>\n' empty/*      # <empty/*>   no match, left as is
shopt -s nullglob
printf '<%s>\n' empty/*      # <>          now it vanishes
```

`nullglob` has a trap: `ls empty/*` becomes plain `ls`, which lists the current directory. Use it with arrays (`arr=(empty/*)`) and loops, not bare commands.

Do not combine `dotglob` with `empty/* empty/.*`: the hidden file would match twice.

## Extended globbing

Needs `shopt -s extglob`.

| Pattern | Regex equivalent | Meaning |
|---------|------------------|---------|
| `?(a\|b)` | `(a\|b)?` | zero or one |
| `*(a\|b)` | `(a\|b)*` | zero or more |
| `+(a\|b)` | `(a\|b)+` | one or more |
| `@(a\|b)` | `(a\|b)` | exactly one |
| `!(a\|b)` | | anything except |

```bash
ls -1 files/!(*.txt)         # everything but text files
ls -1 files/+(foo|bar).txt   # foo.txt, bar.txt, foofoo.txt, barbar.txt
ls -1 files/@(foo|ba?).txt
```

If `!` triggers "event not found" errors in an interactive shell, disable history expansion with `set +H` (back on with `set -H`).
