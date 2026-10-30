# Customising `~/.bashrc`

`~/.bashrc` runs for every new **interactive** shell, so it is the place for aliases, options and prompt settings (it is not read by scripts). Login shells read `~/.bash_profile` or `~/.profile`, which usually source `.bashrc`. Reload with `source ~/.bashrc`.

## Handy shell options

```bash
shopt -s cdspell     # fix small typos in cd arguments (cd /ect -> /etc)
shopt -s autocd      # type a directory name to cd into it
shopt -s histappend  # append to the history file rather than overwrite it
shopt -s checkwinsize
```

With `autocd`, even `..` on its own moves up a directory.

## History

```bash
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:ignorespace   # skip duplicates and commands starting with a space
```

## Conditional aliases

Only define an alias if the tool exists:

```bash
grep --color=auto < /dev/null &>/dev/null &&
    alias grep='grep --color=auto'
xdg-open --version &>/dev/null &&
    alias open='xdg-open'
command -v system_profiler &>/dev/null &&
    alias wattage='system_profiler SPPowerDataType | grep Wattage'

# colour support for ls (GNU vs BSD)
if ls --color=auto &>/dev/null; then
    alias ls='ls -p --color=auto'
else
    alias ls='ls -p -G'
fi
```

## Other ideas

```bash
export EDITOR=vim
export PATH="$HOME/bin:$PATH"
alias ll='ls -lah'
alias ..='cd ..'
PS1='\u@\h:\w\$ '    # prompt: user@host:dir$
```

Back up your `.bashrc` before experimenting, and test changes in a new terminal tab.
