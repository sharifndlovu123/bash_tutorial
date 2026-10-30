# Pitfall: Looping over `ls`

`bad` loops over the output of `ls`, which splits on whitespace, so a file called `d      e` becomes two items, and names containing newlines break completely:

```bash
for f in `ls files`; do echo "file is $f"; done
```

`good` uses a glob. The shell expands it to separate, intact words:

```bash
for f in ./files/*; do echo "file is $f"; done
```

Rules:

- Never parse `ls` output in scripts. Use globs, or `find ... -print0`.
- Quote `"$f"` when you use it.
- Remember `ls` itself detects whether it prints to a terminal (see [chapter 14](../../../14/14-02-isatty/readme.md)), so its output changes when piped.
