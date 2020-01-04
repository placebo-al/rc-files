#!/bin/bash

## This file is to allow faster and more consistent set up for kali

mv $HOME/.bashrc "$HOME/bashrc-bak"     # save the original until I'm happy with mine
cp ./bashrc "$HOME/.bashrc"
cp ./bash_aliases "$HOME/.bash_aliases"
cp ./vimrc "$HOME/.vimrc"
cp ./screenrc "$HOME/.screenrc"
# cp .ovpn ~/Documents/

### Changing the default ssh keys
cd /etc/ssh/
mkdir defaultsshkeys
mv ssh_host_* defaultsshkeys/
dpkg-reconfigure openssh-server


### Files to install with apt
apt update && apt -y upgrade && apt -y autoremove
apt install terminator steghide tree gdb gdb-doc strace ltrace


### Files to install via git
cd /opt
# nmap automator - at least until I make my own
git clone https://github.com/21y4d/nmapAutomator.git

# Windows exploit suggester might also look at other bitsadmin programs                                            
git clone https://github.com/bitsadmin/wesng.git                                                                   
                                                                                                                   
# Linenum                                                                                                          
git clone https://github.com/rebootuser/LinEnum.git                                                                
                                                                                                                   
### Files to download with wget                                                                                    
# pspy 32 and 64 bit                                                                                               
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32s                                       
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s                                       
                                                                                                                   
# unix-privesc-check                                                                                               
wget http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz 
