#!/bin/bash

# Exit if any command fails
set -e

echo "[+] Starting Kali configuration setup..."

### 1. Backup original dotfiles
echo "[+] Backing up original dotfiles..."
for file in .bashrc .bash_aliases .vimrc .screenrc; do
    if [ -f "$HOME/$file" ]; then
        mv "$HOME/$file" "$HOME/${file}.bak.$(date +%Y%m%d)"
    fi
done

### 2. Clone dotfiles repo if not already cloned
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone https://github.com/YOURUSERNAME/dotfiles.git "$DOTFILES_DIR"
else
    (cd "$DOTFILES_DIR" && git pull)
fi

### 3. Create symbolic links
echo "[+] Linking dotfiles..."
ln -sf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"
ln -sf "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/screenrc" "$HOME/.screenrc"

### 4. System update and package installations
echo "[+] Updating system and installing packages..."
sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove
sudo apt install -y terminator steghide tree gdb gdb-doc strace ltrace wget curl git stow

### 5. SSH key regeneration (enhanced)
echo "[+] Reconfiguring SSH server keys..."
sudo mkdir -p /etc/ssh/defaultsshkeys
sudo mv /etc/ssh/ssh_host_* /etc/ssh/defaultsshkeys/
sudo dpkg-reconfigure openssh-server

### 6. Install tools from GitHub to /opt
echo "[+] Installing git-based tools..."
sudo mkdir -p /opt && sudo chown "$USER":"$USER" /opt
cd /opt

tools=(
  "https://github.com/21y4d/nmapAutomator.git"
  "https://github.com/bitsadmin/wesng.git"
  "https://github.com/rebootuser/LinEnum.git"
)

for tool in "${tools[@]}"; do
  repo_name=$(basename "$tool" .git)
  if [ -d "$repo_name" ]; then
    echo "[*] Updating $repo_name"
    (cd "$repo_name" && git pull)
  else
    echo "[*] Cloning $repo_name"
    git clone "$tool"
  fi
done

### 7. Direct file downloads (pspy, unix-privesc-check, etc.)
echo "[+] Downloading additional tools..."
mkdir -p ~/tools && cd ~/tools
wget -qc https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32s
wget -qc https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s
wget -qc http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz

chmod +x pspy32s pspy64s
tar -xzf unix-privesc-check-1.4.tar.gz && rm unix-privesc-check-1.4.tar.gz

echo "[+] Setup complete! Restart your terminal to apply changes."
