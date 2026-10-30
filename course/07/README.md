# Chapter 07: Functions, Output vs. Return, and Sourcing

## Return values vs. output

A function gives you two different things:

- **Output**, written to stdout (and stderr), captured with `$(...)`.
- **A return code**, an integer from 0 to 255 (8 bits), available in `$?`.

```bash
my-func () {
    echo this goes to stdout >&1
    echo this goes to stderr >&2
    return 0
}

var=$(my-func)    # captures stdout only; stderr still shows on the terminal
code=$?
```

### Redirection cheat sheet

| Syntax | Effect |
|--------|--------|
| `>file`, `1>file` | stdout to file |
| `2>file` | stderr to file |
| `>/dev/null` | throw stdout away |
| `2>/dev/null` | throw stderr away |
| `2>&1` | send stderr to wherever stdout currently goes |
| `>/dev/null 2>&1` | discard both (`&>/dev/null` is a shorthand) |
| `2>&1 >/dev/null` | stderr goes to the *old* stdout, stdout is discarded |

**Order matters.** Redirections are processed left to right: `>/dev/null 2>&1` silences everything, but `2>&1 >/dev/null` only silences stdout.

## Sourcing code

`source file` (or `. file`) runs a file in the **current** shell, so its functions and variables become available. Use it to build a library:

```bash
source ./lib/greetings || exit 1
. ./lib/greetings || exit 1       # same thing
source -p "$libdirs" greetings    # bash 5.2+: search a PATH-style list
```

A library can also be run directly, for quick tests, like Python's `if __name__ == "__main__"`:

```bash
if ! (return 2>/dev/null); then
    # run directly, not sourced
    greet dave
fi
```

`return` only works inside a function or a sourced file, so if it succeeds inside the subshell the file is being sourced.

## `{ }` vs `( )` function bodies

```bash
greet () {  ...  }    # runs in the current shell: variables leak out
greet () (  ...  )    # runs in a subshell: variables stay inside
```

In `curly-vs-parens`, `greet dave` overwrites `name` in the caller. Fixes:

1. declare variables with `local`
2. define the function with `( )`
3. call it in a subshell: `( greet dave )`

## Reading files by field

`recap` reads `/etc/passwd` into an associative array:

```bash
while IFS=: read -r name pass uid gid gecos home shell; do
    [[ $name == '#'* ]] && continue      # skip comments
    shells[$name]=$shell
done < /etc/passwd
```
