# Chapter 04: Arithmetic, Arrays, Substitution and Subshells

| Script | Topic |
|--------|-------|
| `arithmetic_expression` | `(( ))` and `$(( ))` |
| `indexed_array` | Indexed arrays |
| `associative_arrays` | Key/value arrays (bash 4+) |
| `command_substitution` | `$(...)` vs backticks |
| `process_substitution` | `<(...)`, here-strings, pipes and subshells |
| `ifs_variable` | The `IFS` variable |
| `shift` | Handling arguments with `shift` and `case` |
| `subshell` | Subshells and variable scope |

## Arithmetic

`(( ... ))` evaluates math without `$`; `$(( ... ))` also returns the result. See `help let` for every operator.

```bash
thing=$(( 2 + 5 ))
echo $(( 9 ** 2 ))        # power: 81
(( i++ ))                 # increment
(( i *= 5 ))              # compound assignment
(( i >>= 1 ))             # shift right (<<= shifts left)
(( max = a > b ? a : b )) # ternary
declare -i n              # variable is always treated as an integer
```

Things to remember:

- Inside `(( ))` variables need no `$`.
- A non-numeric string evaluates to `0`.
- `(( expr ))` has exit status **1 when the result is 0**, which can trip `set -e`.
- Leading zeros mean octal (`08` is an error). Force base 10 with `$(( 10#$f ))`.
- Bash does integer math only. For decimals use `bc` or `awk`: `echo "scale=2; 10/3" | bc`.

## Indexed arrays

```bash
array=(bar foo baz "this is a test")
array[4]=extra

echo "${array[0]}"        # first element
echo "${array[-1]}"       # last element
echo "${array[@]}"        # all elements, each a separate word  (use this to loop)
echo "${array[*]}"        # all elements joined into ONE string (uses IFS)
echo "${#array[@]}"       # number of elements
echo "${#array[1]}"       # length of one element
echo "${!array[@]}"       # the indices

for item in "${array[@]}"; do echo "$item"; done

copy=("${array[@]}")      # copy
copy+=(buddy guy joe)     # append
unset 'array[1]'          # remove one element
declare -p copy           # pretty print the array with its attributes
```

Always quote `"${array[@]}"`; unquoted it re-splits elements on spaces.

## Associative arrays

Key/value pairs. They must be declared with `declare -A` and need bash 4 or newer (macOS ships bash 3.2).

```bash
declare -A arr
arr[foo]=1
arr[bar]=2

echo "${arr[foo]}"
echo "${!arr[@]}"        # keys
echo "${arr[@]}"         # values
echo "${#arr[@]}"        # count

for key in "${!arr[@]}"; do
    echo "$key => ${arr[$key]}"
done

[[ -v arr[foo] ]] && echo "foo is set"
```

## Command substitution

Run a command and use its output:

```bash
user=$(whoami)
echo $(echo $(whoami))       # nests cleanly
```

Avoid backticks (`` `whoami` ``). They are harder to read and nesting needs escaping (`` `echo \`whoami\`` ``). `$(...)` runs in a **subshell**, so variable changes inside do not survive.

## Process substitution

`<(command)` is replaced by a path to a file descriptor (such as `/dev/fd/63`) that holds the command's output. This lets commands that expect a **file** read from a **command**.

```bash
echo <(uname)             # /dev/fd/63
cat <(uname)
diff <(sort a.txt) <(sort b.txt)
```

It solves a classic problem: the right side of a pipe runs in a subshell, so counters are lost.

```bash
i=0
grep d words | while read -r w; do ((i++)); done
echo "$i"                 # 0! the loop ran in a subshell

i=0
while read -r w; do ((i++)); done < <(grep d words)
echo "$i"                 # correct
```

Other ways to feed a loop:

- `done < file`: read from a file.
- `done <<< "$var"`: a **here-string**, feeds a variable to stdin.
- `for w in $words` splits on whitespace; `for w in "$words"` is one item.

Trade-off: with `< <(cmd)`, the exit status of `cmd` is not available to the script.

## IFS

`IFS` (Internal Field Separator) controls how bash splits words. Its default is space, tab and newline. `"${array[*]}"` joins elements using the **first character** of `IFS`.

```bash
array=(foo bar baz)
IFS=,
echo "${array[*]}"        # foo,bar,baz
```

Change it inside a subshell `( IFS=,; ... )` or with `local IFS` in a function so it does not leak. Common use:

```bash
while IFS=: read -r user _ uid _; do echo "$user $uid"; done < /etc/passwd
```

## shift

`shift` drops `$1` and moves every other argument down by one. It is useful for peeling off a sub-command:

```bash
cmd=$1
shift
case "$cmd" in
    indexed)     process-indexed "$@" ;;
    associative) process-associative "$@" ;;
    *) echo "unknown cmd: $cmd" >&2; exit 1 ;;   # >&2 sends the message to stderr
esac
```

`for item; do` is shorthand for `for item in "$@"; do`.

> **Never execute raw user input as a command.** The `commands` branch in the `shift` script runs whatever it is given. It is a demo of the risk, not a pattern to copy.

## Subshells

A subshell is a child copy of the shell, so changes to variables inside it are lost:

```bash
i=5
f() { i=6; echo hello; }

thing=$(f)    # runs in a subshell: i is still 5
f             # runs in this shell: i is now 6
( cd /tmp; )  # cd only affects the subshell
```

Bash 5.3 adds `thing=${ f; }`, which captures output *without* a subshell. Running in the main shell is also faster.
