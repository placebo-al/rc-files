# Append to my Bashrc file

# Set history size, and ignore duplicate lines, have to figure out a way to add over the previous bashrc file
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFIESIZE=20000

# Histignore ignore the following commands from the history file (at least sometimes)
HISTIGNORE="ls:cd:c:clear:?:??"

# Append to history and check window size
# shopt -s histappend       # In the default version
# shopt -s checkwinsize     # In the default version
shopt -s cdspell

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Set default editor
export EDITOR='vim'


## All in the default version

# Set alias used
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi


# enable programmable completion features if not already enabled
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
# fi
