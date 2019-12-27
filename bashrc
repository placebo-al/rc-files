export PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"
export CLICOLOR=1

export LSCOLORS=ExFxBxDxCxegedabagacad


# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Set default editor
export EDITOR='vim'


# Set alias used
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
