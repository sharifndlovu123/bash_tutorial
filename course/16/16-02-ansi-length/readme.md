# Pitfall: String Length with ANSI Codes

Colour codes are real characters, so they count towards a string's length.

```bash
s=$'\e[33mHello World\e[0m'
echo "${#s}"                       # 20, but only 11 are visible
echo "$s" | wc -c                  # counts the newline too
echo -n 'Hello World' | wc -c      # 11
```

This breaks column alignment and prompts. Strip the codes before measuring:

```bash
plain=$(sed 's/\x1b\[[0-9;]*m//g' <<< "$s")
echo "${#plain}"                   # 11
```

Note `$"..."` is locale translation, not escape expansion. Use `$'...'` to get a real escape character.

In `PS1`, wrap non-printing sequences in `\[ ... \]` so readline counts the width correctly: `PS1='\[\e[32m\]\u\[\e[0m\]\$ '`.
