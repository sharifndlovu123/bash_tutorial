# Chapter 08: Parameter Expansion

## Case

```bash
s='dave eddy'
echo "${s^}"       # Dave eddy      first letter upper
echo "${s^^}"      # DAVE EDDY      all upper
echo "${s^^d}"     # Dave eDDy      only d's
echo "${s^^[da]}"  # DAvE EDDy      d's and a's
echo "${t,,}"      # all lower   (t="DAVE EDDY")
echo "${t,}"       # first letter lower
```

## Length

```bash
echo "${#s}"       # number of characters
```

## Replace

```bash
path='/home/dave/foo.txt'
echo "${path/o/a}"     # first match only
echo "${path//o/a}"    # every match
echo "${path//[af]/a}" # patterns work
```

## Trim from the start (`#`) or end (`%`)

`#` removes from the **left**, `%` from the **right**. One symbol is the shortest match, two is the longest.

```bash
echo "${path#*/}"      # home/dave/foo.txt   shortest from the left
echo "${path##*/}"     # foo.txt             longest from the left (like basename)
echo "${path%/*}"      # /home/dave          shortest from the right (like dirname)
echo "${path%%.*}"     # /home/dave/foo
```

Also available as commands: `dirname "$path"`, `basename "$path"`.

## Substrings

```bash
name="dave eddy"
echo "${name:1}"       # ave eddy      from offset
echo "${name:3:5}"     # e edd         offset:length
echo "${name: -3}"     # ddy           negative offset needs a SPACE (or parentheses)
echo "${name:-1}"      # NOT a substring: it means "default value 1"
```

Loop over characters:

```bash
for (( i = 0; i < ${#s}; i++ )); do echo "${s:i:1}"; done
```

## Defaults and required values

| Syntax | Meaning |
|--------|---------|
| `${v:-default}` | use `default` if `v` is unset or empty |
| `${v-default}` | use `default` only if `v` is unset |
| `${v:=default}` | same as `:-` but also assigns it |
| `${v:?message}` | exit with an error if `v` is unset or empty |
| `${v:+alt}` | use `alt` only if `v` is set and non-empty |

```bash
name=${1:-$USER}
surname=${2?'You must supply a surname'}
```

## Parameter transformation

```bash
echo "${s@U}"   # uppercase
echo "${s@Q}"   # quoted so it can be reused as input
echo "${s@A}"   # as an assignment statement
echo "${s@a}"   # attribute flags
```

## Arrays

Expansions apply to every element:

```bash
arr=(food bar baz)
printf '%s\n' "${arr[@]}"        # all
printf '%s\n' "${arr[@]:1}"      # from index 1
printf '%s\n' "${arr[@]:0:2}"    # first two
printf '%s\n' "${arr[@]//a/0}"   # replace in every element
printf '%s\n' "${arr[@]%z}"      # trim from the end
printf '%s\n' "${arr[@]#b}"      # trim from the start
(IFS=_; echo "${arr[*]}")        # join with _
```

Quote `"${arr[@]}"` in real scripts; the demo script leaves it unquoted to keep it short.
