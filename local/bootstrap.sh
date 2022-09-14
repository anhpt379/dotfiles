#!/bin/bash

sudo dnf install -y stow git fish neovim \
  jq ripgrep exa rsync \
  curl wget nmap-ncat dnsutils \
  telnet atop corkscrew \
  grc gron pwgen tldr man-pages \
  youtube-dl ipython python3-virtualenv \
  python3-setuptools python3-pip python3-devel \
  cargo npm luarocks lua-devel golang ruby-devel @development-tools

# dotfiles
cd ~/ || exit 1
git clone https://github.com/anhpt379/dotfiles.git
cd dotfiles/local/ || exit 1

stow fish

sudo usermod -s /bin/fish $USER

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
stow less
stow lf
stow nvim
stow nvimpager
stow ssh
stow tmux
stow wakatime

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
nvim -c "PlugInstall" -c "qall"

# code formatters
sudo dnf install shfmt
pip3 install black
sudo npm install -g @fsouza/prettierd
pip3 install yamlfixer-opt-nc

# python/ruby/node.js provider
pip3 install neovim
gem install --bindir ~/.local/bin/ neovim
sudo npm install -g neovim

# null-ls
pip3 install vim-vint
sudo npm install -g jsonlint textlint write-good markdownlint-cli
gem install --bindir ~/.local/bin/ rubocop rubocop-rspec mdl

sudo luarocks install luacheck
sudo dnf install -y codespell proselint hadolint shellcheck

# languagetool
pip3 install requests

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

wget https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gunzip mocword.sqlite.gz
mv mocword.sqlite ~/.config/nvim/dictionaries/mocword.sqlite

# docker
sudo dnf install -y docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# wakapi
# To access the web UI, go to UTM -> Edit VM -> Network -> Port Forward, map
# TCP Guest `0.0.0.0:3000` to Host `127.0.0.1:3000`, then open
# http://127.0.0.1:3000 in browser.
sudo docker-compose -f ~/dotfiles/local/docker-compose.yml up -d

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

