# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# my laziness
alias c='clear'
alias tree='tree -C -L 2'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

alias wget='wget -c'

alias extip='curl ifconfig.me'

# Does overwrite ss but I don't really use it
alias ss='searchsploit $1'
alias ssx='searchsploit -x $1'

alias webup='python -m SimpleHTTPServer 80'

alias open='xdg-open'
