# Cursor Commands

Run `./00-move-cursor`. It saves the cursor, jumps to row 20 column 20, prints text and restores the cursor.

```bash
printf '\e7'           # save cursor
printf '\e[20;20H'     # move to row;column
echo hello world
printf '\e8'           # restore cursor
```

Related commands:

```bash
clear
tput setaf 1 > file.txt     # the escape code itself is just bytes you can capture
```
