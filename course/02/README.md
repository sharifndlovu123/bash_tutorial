# Chapter 02: Variables, PATH, Permissions

## Common built-in variables

| Variable | Meaning |
|----------|---------|
| `$PATH` | Directories searched for commands |
| `$PWD` | Current directory |
| `$USER` | Current user (or use `whoami`) |
| `$SHELL` | Your login shell |
| `$HOSTNAME` | Machine name |
| `$MACHTYPE` | Machine type |
| `$HOME` | Home directory |

## Creating variables

There must be **no spaces** around `=`.

```bash
foo="hello"
name="john"

fullname='john      helldiver'
echo $fullname      # john helldiver  (spaces collapsed: unquoted!)
echo "$fullname"    # john      helldiver  (quote your variables)

# store the output of a command
thing=$(uname -a)
echo "$thing"

# remove a variable
unset foo
```

Quoting rules: double quotes expand variables, single quotes do not, and no quotes lets the shell split on whitespace.

```bash
env                 # all exported (environment) variables
export NAME=value   # make a variable visible to child processes
printenv HOME
```

## PATH

`PATH` holds the directories bash searches for commands, separated by colons. A neat way to read it:

```bash
echo "$PATH" | tr : '\n'     # tr translates ':' into newlines
```

To add a directory (for example, your own scripts) for this session:

```bash
export PATH="$HOME/bin:$PATH"
```

## Script names

Scripts do not need a `.sh` extension. Bash (and the `file` command) identifies a script from its content, not its name:

```bash
file script.sh     # Bourne-Again shell script, ASCII text executable
```

Dropping the extension is common for commands you want to run like programs, and an extension can limit how a file is used later (you cannot change the language without renaming it).

## Permissions and the shebang

A file must be executable before it can be run as `./script`:

```bash
chmod +x script       # add execute permission
ls -l script          # -rwxr-xr-x
./script              # run it
```

Running `bash script` is different from `./script`: with `bash script` the file only needs to be *readable*, and you choose the interpreter. With `./script` the kernel reads the **shebang** on the first line to pick one:

```bash
#!/bin/bash
# or, more portable:
#!/usr/bin/env bash
```

Some scripts work without a shebang, but only when you launch them from inside bash (`echo $SHELL` shows what you are running).

Numeric modes:

| Mode | Meaning |
|------|---------|
| `chmod 755 f` | owner `rwx`, group and others `r-x` |
| `chmod 644 f` | owner `rw-`, group and others `r--` |
| `chmod u+x f` | add execute for the owner only |

Tab completion of a script name requires the file to be on your `PATH` or executable.

## Vim crash course

The practice files live in [`vim_crash/`](vim_crash/). The key ideas:

- **Normal mode** is for navigation and commands (press `Esc`).
- **Insert mode** is for typing text (press `i`).

| Key | Action |
|-----|--------|
| `h` `j` `k` `l` (or arrows) | left, down, up, right |
| `i` | insert before the cursor |
| `o` / `O` | open a new line below / above |
| `dd` | delete (cut) the line |
| `yy` | yank (copy) the line |
| `p` | paste |
| `u` | undo (`Ctrl-r` redo) |
| `.` | repeat the last change |
| `:w` | write (save) |
| `:q` | quit (`:q!` quit without saving) |
| `:wq` | save and quit |
| `/text` | search |

Start it with `vim file.txt`.
