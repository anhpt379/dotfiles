#!/bin/bash

sudo apt-get update --allow-releaseinfo-change
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -

sudo apt-get install -y --no-install-recommends stow git \
  fzf jq ripgrep exa \
  curl ncat dnsutils \
  telnet atop corkscrew \
  grc gron pwgen tldr \
  youtube-dl ipython python3-virtualenv \
  python3-setuptools python3-pip python3-dev \
  cargo luarocks golang rubygems nodejs build-essential

# dotfiles
cd ~/ || exit 1
git clone https://github.com/anhpt379/dotfiles.git
cd dotfiles/local/ || exit 1

# fish
sudo apt install -y gpg
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
sudo apt update
sudo apt install fish

stow fish

# oh-my-fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --path=~/.local/share/omf --config=~/.config/omf --yes --noninteractive
rm -f install

# stow
stow bat
stow clear
stow curl
stow diff-so-fancy
stow docker
stow fzf
stow gem
stow git
stow grc
stow inputrc
stow kitty
stow less
stow lf
stow nvim
stow nvimpager
stow ssh
stow tmux
stow vale
stow wakatime
# stow youtube-dl

# fd
wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-aarch64-unknown-linux-gnu.tar.gz
tar zxvf fd-*.tar.gz
mv fd-*/fd ~/.local/bin/
rm -rf fd-*

# fzf
cd /tmp || exit 1
wget https://github.com/junegunn/fzf/releases/download/0.33.0/fzf-0.33.0-linux_arm64.tar.gz
tar zxvf fzf-*.tar.gz
mv fzf ~/.local/bin/
rm -rf fzf-*.tar.gz
cd - || exit 1

# nvim
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone --depth=1 https://github.com/neovim/neovim.git
cd neovim || exit 1
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

nvim -c "PlugInstall" -c "qall"
nvim -c "TSUpdate" -c "qall"

# neoformat
curl -fLo ~/.local/bin/shfmt https://github.com/mvdan/sh/releases/download/v3.5.1/shfmt_v3.5.1_linux_arm64 && chmod +x ~/.local/bin/shfmt
pip3 install black

# prettier
sudo npm install -g --save-dev --save-exact prettier

# python/ruby/node.js provider
pip3 install neovim
gem install --bindir ~/.local/bin/ neovim
sudo npm install -g neovim

# null-ls
pip3 install vim-vint
sudo npm install -g jsonlint textlint write-good markdownlint-cli
gem install --bindir ~/.local/bin/ rubocop rubocop-rspec mdl

sudo luarocks install luacheck
sudo apt-get install -y shellcheck codespell python3-proselint
curl -fLo ~/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Linux-arm64 && \
  chmod +x ~/.local/bin/hadolint

# lf
cd /tmp || exit
wget https://github.com/gokcehan/lf/releases/download/r27/lf-linux-arm64.tar.gz
tar zxvf lf-*.tar.gz
mv lf ~/.local/bin/
rm -f lf-*.tar.gz
cd - || exit 1

# prettyping
curl -fLo ~/.local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping
chmod +x ~/.local/bin/prettyping

# xh
wget https://github.com/ducaale/xh/releases/download/v0.16.1/xh-v0.16.1-aarch64-unknown-linux-musl.tar.gz
tar zxvf xh-*.tar.gz
mv xh-*/xh ~/.local/bin/
rm -rf xh-*.tar.gz

# grc-rs
cargo install grc-rs

# mocword
cargo install mocword

# docker
sudo apt install -y docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo docker-compose -f ~/dotfiles/linux/docker-compose.yml up -d

# cron
# sudo dnf install -y cronie
# sudo systemctl enable crond
# sudo systemctl start crond

# echo "0 * * * * bash ~/Music/youtube-dl/download.sh" > cron
# # Use this cronjob to refresh the list of servers that fzf_find uses to search
# # for hosts when typing `ssh<C-f>`:
# # echo "0 3 * * * bash -c \"curl -fsH 'Accept-encoding: gzip' https://<DOMAIN>/servers | gunzip - | jq -r '.servers | .[] | .fqdn' | sort | grep -v 'spare-' > ~/.cache/servers.txt\" >>/tmp/cron.log 2>&1" >> cron
# crontab cron
# rm -f cron

# ffmpeg
# sudo dnf install -y \
#   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
#   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
# sudo dnf install -y ffmpeg

# timezone
sudo timedatectl set-timezone Europe/Amsterdam

# reboot to finish changing the shell to fish
reboot
