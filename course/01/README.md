# Chapter 01: The Terminal and First Commands

## Terminal vs. shell

The terminal works as a **REPL**: Read, Evaluate, Print, Loop.

- The **terminal** is the program (the window) that you type into.
- The terminal starts an instance of a **shell** (here, `bash`).
- The shell waits for commands, runs them, prints the result and waits again.

"Directory" (terminal) and "folder" (GUI) mean the same thing.

## Everyday navigation and files

| Command | What it does |
|---------|--------------|
| `pwd` | Print the current directory |
| `ls`, `ls -la` | List files (`-l` long format, `-a` include hidden files) |
| `cd dir`, `cd ..`, `cd -`, `cd` | Enter a directory, go up, go back to the previous one, go home |
| `mkdir -p a/b/c` | Create a directory (and any missing parents) |
| `touch file` | Create an empty file (or update its timestamp) |
| `cp src dest`, `cp -r dir dest` | Copy a file / a directory |
| `mv src dest` | Move **or rename** |
| `rm file`, `rm -r dir` | Delete (there is no recycle bin) |
| `cat file` | Print a file |
| `head -n 5 file`, `tail -n 5 file`, `tail -f file` | First lines, last lines, follow a growing file |
| `wc -l file` | Count lines (`-w` words, `-c` bytes) |
| `file name` | Tell what type of file something is |

```bash
file file.txt
file *.txt
file /bin/rm
```

### Renaming

`mv` is also the rename command:

```bash
touch lesson1.txt lesson2.txt lesson31.txt
mv lesson31.txt lesson3.txt
```

## Redirection

```bash
cat file.txt

echo test > file.txt     # > overwrites
echo test >> file.txt    # >> appends
```

Every program has three standard streams: `stdin` (0), `stdout` (1) and `stderr` (2). See [chapter 07](../07/README.md) for redirecting them individually.

## Pipelines

A pipe (`|`) feeds the output of one command into the next:

```bash
cat file.txt | grep dave | grep -i ly
```

## grep

```bash
grep search_term file
grep dave /usr/file/example

grep '^dave' file        # lines that start with dave
grep 'dave$' file        # lines that end with dave

grep -A1 "search" file   # also show 1 line After the match
grep -B1 "search" file   # also show 1 line Before the match
grep -C1 "search" file   # Context: before and after

grep -i dave file        # case insensitive
grep -o '^d.' file       # print only the part that matches
grep -v dave file        # invert: lines that do NOT match
grep -n dave file        # show line numbers
grep -c dave file        # count matching lines
grep -r dave dir/        # search recursively
grep -E 'dave|joe' file  # extended regex
```

## Getting help

```bash
man less        # manual page for less
man man         # the manual for man itself
```

Sections 1-3 are universal; the rest are OS specific:

1. General commands
2. System calls
3. Library functions

If you do not get the page you want, name the section: `man 3 printf` gives the C library `printf`, while `man printf` gives the command.

Some commands are **shell builtins**, not programs, so they have no man page:

```bash
help history     # builtin: use help
help help        # the help page for help
compgen -b       # list every builtin in bash
```

To find out what a name actually is:

```bash
type history     # shell builtin
type ls          # may be an alias
type -a echo     # show everything with that name, top to bottom
which ls         # path of the program (builtins and aliases will not show)
```

Some commands exist as both builtin and program (for example `echo`). `type -a echo` shows both; `help echo` documents the builtin and `man echo` the program.

## Paging through long output

```bash
less file.txt
more file.txt
```

| Key | Action |
|-----|--------|
| `q` | quit |
| `j` / `k` (or arrow keys) | down / up |
| `/term` | search forward |
| `n` / `N` | next / previous match |

## Aliases

```bash
alias rm='rm -i'   # make `rm` always ask first
alias              # list aliases
unalias rm         # remove one
```

Aliases only last for the current shell. Put them in `~/.bashrc` to keep them (see [chapter 15](../15/15-01-customize-bashrc/readme.md)).

## Other useful commands

```bash
history            # previous commands
!!                 # repeat the last command
sudo !!            # ...as root
clear              # clear the screen (or ctrl-l)
echo $?            # exit code of the last command
```
