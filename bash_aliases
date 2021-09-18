###########
# Aliases #
###########

alias updatey='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'

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

# The usual cd shortcuts
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

alias wget='wget -c'

alias extip='curl ifconfig.me; echo'

# Makes it a little easier to use searchsploit
alias ssp='searchsploit $1'
alias ssx='searchsploit -x $1'

alias webup='python -m SimpleHTTPServer 80'

alias open='xdg-open'

# Needs work
# alias shieldsup='tcpdump -i tun0 -nnvv src net 10.10.14.0/24 and dst 10.10.14.23 -w - | tee capture.pcap | tcpdump -n -r -'


# Histignore ignores the following commands from the history file (at least sometimes)
export HISTIGNORE="ls:cd:c:clear:?:??"
# ignoreboth is shorthand for ignorespace and ignoredups, 
# erasedups is as the name suggests
export HISTCONTROL=ignoreboth:erasedups 


export EDITOR='vim'

# A shortcut for scanning THM and HTB boxes
function port-scan () {
    if [ $# -ne 1 ] ; then
      echo "Usage: remember to add the url"
      exit
    fi
    box=$1
    echo "Scanning for open ports on $box"
    nmap -Pn -sS -p- --open -T4 --min-rate=1000 $box -oN ${box}
    # Could probably improve my regex on this line
    ports=$(cat ${box} | grep open | cut -d " " -f 1 | cut -d "/" -f 1 | tr "\n" "," | cut -c3- | head -c-2)
    echo "Now scanning $ports on $box"
    # And add a error clause for no open ports
    nmap -Pn -p $ports -sCV --script=default $box -oN ${box}-nmap
}

alias htb='screen sudo openvpn ~/Documents/hackthebox.ovpn'
alias thm='screen sudo openvpn ~/Documents/tryhackme.ovpn'


