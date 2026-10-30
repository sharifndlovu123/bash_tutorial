# Chapter 03: Writing Your First Scripts

The scripts are in [`finally-scripting/`](finally-scripting/). Make them executable first: `chmod +x finally-scripting/*/*`.

| Folder | Topic |
|--------|-------|
| `init/` | Hello world, a variable, a simple `for` loop |
| `input/` | Positional arguments, `read`, looping over `"$@"` |
| `input_output/` | Reading from stdin with `read` and `while read` |
| `for_loops/` | `for` over lists, brace ranges and C-style loops |
| `functions/` | Functions, `local`, return codes |
| `conditionals/` | `if`, `while`, `until` |

## Arguments and input

```bash
$1 $2 ...   # positional arguments
$@          # all arguments (use "$@" so each stays separate)
$#          # number of arguments
$0          # script name
```

```bash
read -p 'Enter your name: ' name     # prompt and read one line
read -r foo                          # -r: do not treat backslashes as escapes
while read -r line; do ...; done     # read every line of stdin
```

`-n "$1"` tests whether a value is non-empty, so a script can use its argument or fall back to asking:

```bash
if [[ -n $1 ]]; then
    name=$1
else
    read -p 'Enter your name: ' name
fi
```

Help for the test operators: `help test`, `help '['`, `help '[['`.

## Loops

```bash
for thing in foo bar baz; do echo "$thing"; done

for thing in "$@"; do echo "$thing"; done

for thing in {a..f}; do echo "$thing"; done    # brace range

max=5
for thing in {1..$max}; do ...                 # DOES NOT WORK: braces expand before variables
for (( i = 0; i < max; i++ )); do ...          # use a C-style loop instead
```

`(( ))` is for arithmetic. See [chapter 04](../04/README.md).

## Functions

```bash
greet() {
    local name=$1        # local keeps it from leaking out of the function
    echo "hello $name"
    return 0             # exit status: 0 success, non-zero failure
}

greet dave
var=$(greet dave)        # capture what the function prints
echo "$?"                # status of the last command
```

Without `local`, variables are global and a function can overwrite your script's variables. More in [chapter 07](../07/README.md).

## Conditionals

```bash
if [[ $a == $b ]]; then ...; fi
if [[ $c != $d ]]; then ...; fi
if [[ -f file.txt ]]; then ...; fi      # file exists and is a regular file

while [[ -f file.txt ]]; do sleep 1; done   # loop while true
until [[ -f file.txt ]]; do sleep 1; done   # loop until true (the opposite)
```

`if` really tests the **exit status of a command**, so brackets are not required:

```bash
if echo hi; then echo "true"; else echo "false"; fi
true;  echo $?   # 0
false; echo $?   # 1
```

`[ -f file ]` and `test -f file` also work, but prefer `[[ ]]` (see [chapter 12](../12/test-vs-brackets/readme.md)).

Common file tests: `-e` exists, `-f` regular file, `-d` directory, `-r`/`-w`/`-x` readable/writable/executable, `-s` non-empty, `-L` symlink.

String tests: `-z` empty, `-n` non-empty, `==`, `!=`. Number tests: `-eq -ne -lt -le -gt -ge`.

## `case`

```bash
case "$1" in
    start) echo starting ;;
    stop)  echo stopping ;;
    *)     echo "usage: $0 start|stop" >&2; exit 1 ;;
esac
```
