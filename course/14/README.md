# Chapter 14: Terminal Control, TTYs and Colour

## Cursor control

Terminals are driven by **ANSI escape sequences**: invisible byte sequences starting with the escape character (`\e`, also `\033` or `\x1b`, decimal 27).

```bash
printf '\e7'             # save cursor position
printf '\e[20;20H'       # move to row 20, column 20
echo "hello world"
printf '\e8'             # restore cursor position
```

See `14-01-cursor-commands/`. `tput` does the same job portably:

```bash
tput clear       # clear the screen
tput cup 5 10    # move the cursor
tput reset       # fix a garbled terminal
```

## Is the output a terminal?

`[[ -t 1 ]]` is true when stdout (file descriptor 1) is a terminal. Programs use it to decide whether to print colours.

```bash
if [[ -t 1 ]]; then echo "stdout is a terminal"; else echo "stdout is NOT a terminal"; fi
```

Compare `./check`, `./check | cat` and `./check | less`. `ls --color=auto|always|never` behaves this way: `auto` colours only for a terminal. See `14-02-isatty/`.

## Colour output

Look at the raw bytes to see there is nothing magic:

```bash
printf '%b' '\x61\x0a' | xxd       # "a" and a newline
printf '%b' '\x1b' | xxd           # the escape character
echo -e '\e[1mhello'               # bold, never switched off
echo -e '\e[1mhello\e[0m'          # \e[0m resets everything
```

These are all the same escape character:

```bash
echo $'\e[1mhello'
echo $'\033[1mhello'
echo $'\x1b[1mhello'
```

Keep them in variables:

```bash
bold=$'\e[1m'; reset=$'\e[0m'
echo "${bold}Hello${reset}"
```

### Codes

| Sequence | Effect |
|----------|--------|
| `\e[0m` | reset |
| `\e[1m` / `\e[4m` | bold / underline |
| `\e[30m` to `\e[37m` | foreground colours |
| `\e[40m` to `\e[47m` | background colours |
| `\e[38;5;Nm` | 256-colour foreground (N is 0 to 255) |
| `\e[38;2;R;G;Bm` | true-colour (24-bit) foreground |

```bash
printf '\e[31mred\e[0m\n'
printf '\e[38;5;128mpurple\e[0m\n'
printf '\e[38;2;255;0;0mred\e[0m\n'
```

The `color` script prints every 256-colour and a few true-colour samples.

### tput

`tput` looks up the right code for your terminal:

```bash
tput bold; echo hi; tput sgr0       # sgr0 resets
tput setaf 1; echo red; tput sgr0   # foreground colour 0-7
tput setab 2                        # background colour
```

Reference of every sequence: <https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797>

Even `clear` just prints escapes: `clear | xxd`. Programs such as vim, nano and htop move the cursor the same way.
