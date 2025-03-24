# Append to my Bashrc file (custom additions)

# Improve Bash history (ignore duplicates, larger history)
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
HISTIGNORE="ls:cd:c:clear:?:??"

# Autocorrect typos when using 'cd'
shopt -s cdspell

# Architecture flags for compiling software
export ARCHFLAGS="-arch x86_64"

# Set default editor
export EDITOR='vim'

