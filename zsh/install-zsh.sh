#!/bin/bash
set -e

# invoke this script from one directory up (see install.sh)

# zsh
# with root access
# apt update \
#     && DEBIAN_FRONTEND=noninteractive apt install -y \
#        -o Dpkg::Options::="--force-confnew" zsh
# without root access (https://www.baeldung.com/linux/install-packages-no-root-privileges)
apt download zsh
dpkg -x zsh*.deb $HOME/.local/share/zsh-deb
export PATH="$HOME/.local/share/zsh-deb/bin:$PATH"
rm zsh*.deb

# zsh history
# adapted from https://code.visualstudio.com/remote/advancedcontainers/persist-bash-history
mkdir -p "$HOME/commandhistory"
touch "$HOME/commandhistory/.zsh_history"
chown -R "$(id -un):$(id -gn)" "$HOME/commandhistory"

# initial zsh config
cp zsh/.zshrc "$HOME/.zshrc"

# Powerline fonts
# https://github.com/powerline/fonts?tab=readme-ov-file#quick-installation
git clone --depth=1 https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd .. && rm -rf fonts

# Powerlevel10k
# https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#manual
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
echo "source $HOME/powerlevel10k/powerlevel10k.zsh-theme" >> "$HOME/.zshrc"
cp zsh/.p10k.zsh "$HOME/.p10k.zsh"
echo "[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh" >> "$HOME/.zshrc"

# zsh autosuggestion
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#manual-git-clone
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
echo "source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> "$HOME/.zshrc"

# zsh syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#in-your-zshrc
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
echo "source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# zsh history substring search (install AFTER syntax highlighting)
# https://github.com/zsh-users/zsh-history-substring-search
git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git "$HOME/.zsh/zsh-history-substring-search"
echo "source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh" >> "$HOME/.zshrc"
