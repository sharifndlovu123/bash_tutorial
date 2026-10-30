# Aliases with Arguments

Aliases are plain text substitution. They **cannot take arguments**: `$1` inside an alias refers to the *shell's* positional parameters, not what you type after the alias.

```bash
alias mkdc='mkdir $1 && cd $1'     # looks right, does not work
alias foo='echo $1 $2'

foo                    # prints nothing
foo hello world        # prints "hello world" as arguments to echo, but $1 $2 are empty

set -- a b c           # set the shell's own positional parameters
foo hello world        # now prints: a b hello world
```

Use a **function** instead:

```bash
mkdc() {
    mkdir -p -- "$1" && cd -- "$1"
}
```

Put it in `~/.bashrc`. Quoting `"$1"` and using `--` makes it safe for names with spaces or leading dashes.

Rule of thumb: alias for shortening a fixed command (`alias ll='ls -lah'`), function when you need arguments or logic.
