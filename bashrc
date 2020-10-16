# My Bashrc file

export PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"
export CLICOLOR=1

export LSCOLORS=ExFxBxDxCxegedabagacad

# Set history size, and ignore duplicate lines
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFIESIZE=20000

# Append to history and check window size
shopt -s histappend
shopt -s checkwinsize

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Set default editor
export EDITOR='vim'


# Set alias used
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# enable programmable completion features if not already enabled
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
