# Chapter 05: Text-Processing Tools

The scripts live in [`cut_tr/`](cut_tr/) and are meant to be run from inside that folder. They are collections of commands to run **one at a time**, not scripts to execute whole.

## tr: translate characters

```bash
cat simple.csv | tr , '\t'     # commas -> tabs
echo hello | tr a-z A-Z        # uppercase
echo "a  b" | tr -s ' '        # squeeze repeated spaces
echo hello | tr -d l           # delete characters
```

`tr` works on single characters only and reads **stdin** (it cannot take a filename).

## cut: select columns

| Flag | Meaning |
|------|---------|
| `-d X` | delimiter |
| `-f N` | field(s): `2`, `1-3`, `1,3`, `3-` |
| `-c N` | by character position |

```bash
cut -d , -f 1-3 simple.csv
cut -d : -f 1,3 /etc/passwd
echo "$PATH" | cut -d : -f 1
```

`/etc/passwd` fields: login name, password placeholder, uid, gid, comment, home directory, shell (`man 5 passwd`).

## sed: search and replace

```bash
sed 's/old/new/'           # first match per line
sed 's/old/new/g'          # every match
sed -e 's/a/b/' -e 's/c/d/'   # several expressions
sed 's#/home#/Users#'      # any delimiter, handy for paths
sed -i 's/old/new/' file   # edit the file in place
```

## awk: field-based processing

```bash
awk '{ print $1 }' file               # first whitespace-separated field
awk -F : '{ print $1, $7 }' /etc/passwd
awk -F : '$3 >= 1000 { print $1 }' /etc/passwd   # with a condition
awk -F : '{ printf("%s has shell %s\n", $1, $7) }' /etc/passwd
```

`$0` is the whole line. `-F` sets the field separator.

## sort, uniq, wc

```bash
sort file            # alphabetical (-n numeric, -r reverse, -u unique)
sort file | uniq     # uniq only removes ADJACENT duplicates, so sort first
sort file | uniq -c  # count occurrences
wc -l file           # lines; -w words; -c bytes
```

## find

```bash
find . -type f                       # files (d = directory, l = symlink)
find . -name '*.txt'                 # by name (quote the pattern!)
find . -maxdepth 1 -type f           # do not recurse
find . -mtime -1                     # modified in the last day
find . -size +10M                    # bigger than 10 MB
find . -type f -exec echo {} ';'     # run a command per file
find . -type f -exec echo {} +       # batch files into fewer runs
```

`-exec` ends with `;`, which bash would swallow, so quote or escape it (`';'` or `\;`).

## xargs

`xargs` turns lines on stdin into arguments:

```bash
find . -name '*.txt' | xargs wc -l
find . -name '*.txt' -print0 | xargs -0 wc -l     # safe for spaces in names
```

## Other handy tools

```bash
tee file             # write stdin to a file AND stdout
diff a b             # compare files
comm a b             # compare sorted files
paste a b            # merge files side by side
column -t            # align columns
jq                   # process JSON
```
