# Chapter 12: Special Strings and `test` vs `[` vs `[[`

## Special characters in strings

`echo` and plain quotes do not interpret `\n` or `\t`. Two ways to get them:

```bash
echo -e 'hello\nworld'          # -e makes echo expand escapes
msg=$'hello\nworld'             # $'...' expands escapes in the string itself
tab=$'\t'
echo $'foo\vbar'                # vertical tab
echo $'foo\b\b\bbar' | xxd      # backspace: the bytes are still there
```

`$'...'` is best because it works anywhere, including variables.

## `test`, `[` and `[[`

| Form | What it is |
|------|------------|
| `test -f file` | builtin (and `/usr/bin/test`) |
| `[ -f file ]` | builtin, same as `test` (and `/usr/bin/[`) |
| `[[ -f file ]]` | **keyword**: bash parses it specially, so it is safer |

```bash
help test; help '['; help '[['
which '['
```

`[[ ]]` can do everything the others do, plus:

- No word splitting or glob expansion on unquoted variables.
- Pattern matching: `[[ $f == *.jpg ]]`
- Regex: `[[ $f =~ ^a.*z$ ]]`
- `&&` and `||` inside: `[[ -f a && -f b ]]`

Quote variables anyway; it is a good habit and needed with `[`.

It is not POSIX, so for `sh` scripts use `[ ]`.

### Patterns (`03` to `05`)

```bash
[[ $f == *.jpg ]]       # pattern match
[ $f == *.jpg ]         # WRONG: the glob expands to filenames
[[ $f == '*.jpg' ]]     # quoted: matches the literal text *.jpg
```

### Numbers (`06` to `08`)

`>` and `<` inside `[[ ]]` compare **strings**, so `10 > 9` is false (`"1"` sorts before `"9"`).

```bash
[[ $b -gt $a ]]   # numeric operators: -eq -ne -lt -le -gt -ge
(( b > a ))       # arithmetic: simplest and best for numbers
```

Run the numbered scripts in `test-vs-brackets/` in order.
