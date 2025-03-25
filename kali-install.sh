#!/bin/bash

set -e

echo "[+] Starting Kali configuration setup..."

### 1. Backup original dotfiles
echo "[+] Backing up original dotfiles..."
for file in .bashrc .bash_aliases .vimrc .tmux.conf; do
    if [ -f "$HOME/$file" ]; then
        mv "$HOME/$file" "$HOME/${file}.bak.$(date +%Y%m%d)"
    fi
done

### 2. Clone or update dotfiles repo
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    git clone https://github.com/placebo-al/rc-files "$DOTFILES_DIR"
else
    (cd "$DOTFILES_DIR" && git pull)
fi

### 3. Create symbolic links
echo "[+] Linking dotfiles..."
ln -sf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash_aliases" "$HOME/.bash_aliases"
ln -sf "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
ln -sf "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

### 4. System update and package installations
echo "[+] Updating system and installing packages..."
sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove

ESSENTIAL_PACKAGES=(
    terminator steghide tree gdb gdb-doc strace ltrace wget curl git stow
    seclists gobuster feroxbuster wfuzz ffuf tmux neofetch bloodhound
    python3-pip rlwrap nishang powershell enum4linux smbclient crackmapexec
    hydra john hashcat exiftool imagemagick jq sqlmap docker.io docker-compose
    ufw open-vm-tools-desktop fuse fonts-powerline
)

echo "[+] Installing essential packages..."
sudo apt install -y "${ESSENTIAL_PACKAGES[@]}"

# Python tools
python3 -m pip install --upgrade pip
python3 -m pip install --user impacket pyftpdlib droopescan updog httpx certipy-ad

# Docker setup
sudo systemctl enable docker --now
sudo usermod -aG docker $USER

# UFW Firewall setup
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Git Configuration
GIT_NAME="${GIT_NAME:-Your Name}"
GIT_EMAIL="${GIT_EMAIL:-youremail@example.com}"

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global pull.rebase false
git config --global credential.helper store

# VM Tools
sudo systemctl enable --now open-vm-tools.service

### 5. SSH key regeneration
echo "[+] Reconfiguring SSH server keys..."
sudo mkdir -p /etc/ssh/defaultsshkeys
sudo mv /etc/ssh/ssh_host_* /etc/ssh/defaultsshkeys/ || true
sudo dpkg-reconfigure openssh-server

### 6. Install tools from GitHub
echo "[+] Installing git-based tools..."
sudo mkdir -p /opt && sudo chown "$USER":"$USER" /opt
cd /opt

tools=(
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

### 7. Download standalone tools
echo "[+] Downloading additional tools..."
mkdir -p ~/tools && cd ~/tools
wget -qc https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32s
wget -qc https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s
wget -qc http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz

chmod +x pspy32s pspy64s
tar -xzf unix-privesc-check-1.4.tar.gz && rm unix-privesc-check-1.4.tar.gz

echo "[+] Setup complete! Restart your terminal to apply changes."
