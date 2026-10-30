# Chapter 10: Brace Expansion

Brace expansion generates **strings**. It does not look at the filesystem, and it happens before variable expansion.

```bash
echo {hello,world,test}               # hello world test
echo "{hello,world,test}"             # quotes disable it
echo "$filename."{pdf,txt,jpg}        # my-file.pdf my-file.txt my-file.jpg
arr=(/etc/{foo,bar}/{1,2,3}.txt)      # all 6 combinations
```

## Ranges

```bash
echo {1..20}
echo {a..f}
echo {0..100..5}      # start..end..step
echo {01..10}         # zero padded
seq 1 20              # alternative; also: seq 0 10 50 (start step end)
```

Variables do **not** work in a range:

```bash
max=4
for i in {1..$max}; do ...            # wrong: literal text
for (( i = 0; i <= max; i++ )); do ...    # right
for (( i = 0; i <= max; i += 2 )); do ... # with a step
```

## Braces vs. globs

| | Brace `{}` | Glob `*` |
|-|-----------|----------|
| Checks the filesystem | no | yes |
| Always expands | yes | only if something matches |

```bash
touch {foo,bar,baz}.{txt,jpg}
ls *.{txt,mov}       # brace first -> *.txt *.mov, then glob matches real files
```

The `brace-globb/brace-glob` script works inside its own `files/` folder, so it is safe to run.

## Practical uses

```bash
mkdir -p project/{src,tests,docs}
cp file.conf{,.bak}      # expands to: cp file.conf file.conf.bak
mv report.{txt,md}       # rename an extension
```
