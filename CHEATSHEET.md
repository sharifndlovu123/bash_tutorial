# Bash Cheatsheet

A quick reference. Each section links to the chapter with the full explanation and runnable examples.

## Script skeleton

```bash
#!/usr/bin/env bash
set -euo pipefail          # fail fast (read chapter 06 for the caveats)

main() {
    local name=${1:-world}
    echo "hello $name"
}

main "$@"
```

## Variables and quoting ([02](course/02/README.md))

```bash
name="value"              # no spaces around =
echo "$name"              # ALWAYS quote expansions
echo '$name'              # single quotes: literal
echo "${name:-default}"   # default if unset or empty
readonly PI=3.14          # constant
export NAME               # pass to child processes
unset name
```

## Special variables

| Variable | Meaning |
|----------|---------|
| `$0` | script name |
| `$1` .. `$9`, `${10}` | arguments |
| `$#` | number of arguments |
| `"$@"` | all arguments, separate words |
| `"$*"` | all arguments, one string |
| `$?` | exit status of the last command |
| `$$` | PID of the current shell |
| `$!` | PID of the last background job |
| `$_` | last argument of the previous command |
| `$RANDOM` | random number 0-32767 |
| `$LINENO` | current line number |
| `$SECONDS` | seconds since the shell started |
| `$BASH_VERSION` | bash version |

## Conditionals ([03](course/03/README.md), [12](course/12/README.md))

```bash
[[ -e f ]]  [[ -f f ]]  [[ -d d ]]  [[ -s f ]]  [[ -x f ]]  [[ -L f ]]
[[ -z $s ]]  [[ -n $s ]]  [[ $a == $b ]]  [[ $a == *.txt ]]  [[ $a =~ ^[0-9]+$ ]]
[[ $a -eq $b ]]  # -ne -lt -le -gt -ge
(( a > b ))      # arithmetic compare
[[ -f a && -f b ]]  [[ -f a || -f b ]]  [[ ! -f a ]]
```

```bash
if cmd; then ...; elif cmd; then ...; else ...; fi
case "$x" in a|b) ... ;; *) ... ;; esac
cmd1 && cmd2        # run cmd2 only if cmd1 succeeded
cmd1 || cmd2        # run cmd2 only if cmd1 failed
```

## Loops

```bash
for x in a b c; do ...; done
for x in "$@"; do ...; done
for f in ./*.txt; do ...; done
for ((i = 0; i < 10; i++)); do ...; done
for i in {1..10}; do ...; done
while read -r line; do ...; done < file
while true; do ...; done
until cmd; do ...; done
break  continue
```

## Functions ([07](course/07/README.md))

```bash
greet() {
    local name=$1
    echo "hello $name"
    return 0
}
result=$(greet dave)
```

## Redirection and pipes ([07](course/07/README.md))

```bash
cmd > file          # stdout to file (overwrite)
cmd >> file         # append
cmd 2> file         # stderr
cmd &> file         # both
cmd > /dev/null 2>&1
cmd < file          # stdin from file
cmd <<< "text"      # here-string
cmd1 | cmd2         # pipe
cmd | tee file      # copy to file and screen
cmd 2>&1 | less     # pipe both streams
```

Here-document:

```bash
cat <<END
Hello $USER
END

cat <<'END'          # quoted: no expansion
$USER stays literal
END
```

## Arrays ([04](course/04/README.md))

```bash
arr=(a b c)
arr+=(d)
"${arr[@]}"  "${#arr[@]}"  "${!arr[@]}"  "${arr[0]}"  "${arr[-1]}"
declare -A map; map[key]=value; "${!map[@]}"
mapfile -t lines < file
```

## String manipulation ([08](course/08/README.md))

```bash
${#s}               # length
${s:2:3}            # substring
${s/a/b}  ${s//a/b} # replace first / all
${s#pat}  ${s##pat} # trim from start (shortest / longest)
${s%pat}  ${s%%pat} # trim from end
${s^^}  ${s,,}      # upper / lower
```

## Arithmetic ([04](course/04/README.md))

```bash
(( i++ ))   x=$(( a * b ))   (( a % 2 == 0 ))
echo "scale=2; 10/3" | bc       # decimals
```

## Globbing and braces ([09](course/09/README.md), [10](course/10/README.md))

```bash
*.txt  ?.txt  [abc].txt  **/*.txt   # glob (** needs globstar)
!(*.txt)  +(a|b)  @(a|b)            # extglob
{a,b,c}  {1..10}  {01..10..2}       # brace expansion
```

## Files and text ([01](course/01/README.md), [05](course/05/README.md))

```bash
ls -la  cp -r  mv  rm -r  mkdir -p  touch  ln -s target link
find . -name '*.log' -mtime +7 -delete
grep -rn "text" .          # recursive with line numbers
sed -i 's/a/b/g' file
awk -F, '{print $1}' file.csv
sort | uniq -c | sort -rn
cut -d, -f1,3 file.csv
tr 'a-z' 'A-Z'
head -n 5  tail -n 5  tail -f  wc -l
xargs  tee  diff  column -t
stat file    du -sh dir    df -h
tar -czf out.tgz dir/   tar -xzf out.tgz
```

## Permissions

```bash
chmod +x file   chmod 755 file   chmod u+rwx,g+rx,o-rwx file
chown user:group file
umask               # default permission mask
```

## Processes and jobs ([13](course/13/README.md))

```bash
cmd &               # run in the background
jobs  fg  bg        # job control (Ctrl-Z suspends)
ps aux  pgrep name  pkill name
kill PID  kill -9 PID  kill -USR1 PID
wait                # wait for background jobs
nohup cmd &         # keep running after logout
timeout 5 cmd       # stop after 5 seconds
sleep 1
time cmd
trap 'cleanup' EXIT
```

## System information

```bash
uname -a   whoami   hostname   uptime   date
free -h   df -h   lsblk   lscpu
top   htop   ps aux --sort=-%mem | head
ip addr   ss -tulpn   curl -I https://example.com   ping -c 3 host
```

## Getting help ([01](course/01/README.md))

```bash
man cmd   help builtin   cmd --help   type -a cmd   which cmd
apropos keyword          # search manual pages
compgen -b               # list builtins
```

## Debugging ([06](course/06/README.md))

```bash
bash -n script      # syntax check
bash -x script      # trace
set -x ... set +x   # trace a section
shellcheck script   # lint
declare -p var      # inspect a variable
```

## Safety habits

- Quote every expansion: `"$var"`, `"${arr[@]}"`.
- Use `--` before filenames that might start with `-`: `rm -- "$file"`.
- Do not parse `ls`; use globs or `find -print0`.
- Test destructive commands with `echo` first: `echo rm -rf "$dir"/*`.
- Use `mktemp` for temp files and `trap ... EXIT` to clean up.
- Run `shellcheck` on everything.
