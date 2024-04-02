#!/bin/bash

sudo dnf install -y \
  kitty-terminfo which \
  stow git fish tmux \
  jq ripgrep exa rsync \
  curl wget nmap-ncat \
  telnet corkscrew \
  tldr man-pages grc dnsutils \
  atop pwgen gron ncdu hyperfine \
  ipython python3-virtualenv irb \
  python3-setuptools python3-pip python3-devel \
  cargo golang npm luarocks lua-devel ruby-devel \
  @development-tools

# dotfiles
cd ~/ || exit 1
git clone https://github.com/anhpt379/dotfiles.git
cd dotfiles/local/ || exit 1

stow fish

sudo usermod -s /bin/fish $USER

# fisher
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
git checkout origin/master local/fish/.config/fish/fish_plugins
fish -c 'fisher update'

# stow
mkdir -p ~/.local/bin/
mkdir -p ~/.config/nvim/undo/
stow bash
stow bin
stow curl
stow diff-so-fancy
stow docker
stow fish
stow gem
stow git
stow grc
stow inputrc
stow less
stow lf
stow man
stow nvim
stow nvimpager
stow ssh
stow tmux
stow vivid
stow wakatime

# neovim
sudo dnf install -y ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl
git clone --depth=1 https://github.com/neovim/neovim
cd neovim || exit 1
git fetch --tags --force
git checkout nightly
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
nvim --version
cd ..
rm -rf neovim

# nvimpager
sudo dnf install -y scdoc
cd /tmp || exit
git clone --depth=1 https://github.com/lucc/nvimpager.git
cd nvimpager/ || exit 1
make PREFIX=$HOME/.local install
# Update the code to use a relative RUNTIME directory
# This way it'll be possible to copy the file to another machine.
sed -i 's|^RUNTIME=.*$|RUNTIME="$HOME/.local/share/nvimpager/runtime"|' ~/.local/bin/nvimpager
cd ..
rm -rf nvimpager

# fd
wget https://github.com/sharkdp/fd/releases/download/v9.0.0/fd-v9.0.0-aarch64-unknown-linux-gnu.tar.gz
tar zxvf fd-*.tar.gz
mv fd-*/fd ~/.local/bin/
mv fd-*/fd.1 ~/.local/share/man/man1/
rm -rf fd-*

# fzf
cd /tmp || exit 1
curl -fLo ~/.local/share/man/man1/fzf.1 https://raw.githubusercontent.com/junegunn/fzf/0.48.0/man/man1/fzf.1
wget https://github.com/junegunn/fzf/releases/download/0.48.0/fzf-0.48.0-linux_arm64.tar.gz
tar zxvf fzf-*.tar.gz
mv fzf ~/.local/bin/
rm -rf fzf-*.tar.gz
cd - || exit 1

# fastgron
cd /tmp || exit 1
git clone https://github.com/adamritter/fastgron.git
cd fastgron || exit 1
git fetch --tags
git checkout v0.6.5
cmake -B build
cmake --build build
cmake install build/
cp build/fastgron ~/.local/bin/
cd - || exit 1

# nvim
nvim -c "PlugInstall" -c "TSInstall all" -c "qall"

# code formatters
sudo dnf install -y shfmt
pip3 install black
sudo npm install -g @fsouza/prettierd
pip3 install yamlfixer-opt-nc

# python/ruby/node.js provider
pip3 install neovim
sudo gem install --bindir ~/.local/bin/ neovim
sudo npm install -g neovim

# tree-sitter
sudo dnf install -y gcc-c++ libstdc++-static

# null-ls
pip3 install vim-vint
sudo npm install -g jsonlint textlint write-good markdownlint-cli
sudo gem install --bindir ~/.local/bin/ rubocop rubocop-rspec mdl

sudo luarocks install luacheck
sudo dnf install -y codespell proselint hadolint ShellCheck

# languagetool
pip3 install --upgrade requests

# lf
cd /tmp || exit
curl -fLo ~/.local/share/man/man1/lf.1 https://raw.githubusercontent.com/gokcehan/lf/r31/lf.1
wget https://github.com/gokcehan/lf/releases/download/r31/lf-linux-arm64.tar.gz
tar zxvf lf-*.tar.gz
mv lf ~/.local/bin/
rm -f lf-*.tar.gz
cd - || exit 1

# hping3
# the normal `ping` doesn't work in Lima VM
# (https://github.com/lima-vm/lima/blob/master/README.md#ping-shows-duplicate-packets-and-massive-response-times),
# but `hping3` does work
sudo dnf install -y hping3
sudo setcap cap_net_raw+ep "$(which hping3)"

# xh
curl -fLo ~/.local/share/man/man1/xh.1 https://raw.githubusercontent.com/ducaale/xh/v0.18.0/doc/xh.1
wget https://github.com/ducaale/xh/releases/download/v0.18.0/xh-v0.18.0-aarch64-unknown-linux-musl.tar.gz
tar zxvf xh-*.tar.gz
mv xh-*/xh ~/.local/bin/
rm -rf xh-*

# mocword
cargo install mocword

wget https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gunzip mocword.sqlite.gz
mv mocword.sqlite ~/.config/nvim/dictionaries/mocword.sqlite

# git-absorb
cargo install git-absorb

wget https://raw.githubusercontent.com/tummychow/git-absorb/master/Documentation/git-absorb.1
mv git-absorb.1 ~/.local/share/man/man1

# vivid
wget https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid-v0.8.0-aarch64-unknown-linux-gnu.tar.gz
tar zxvf vivid-*.tar.gz
mv vivid-*/vivid ~/.local/bin/
rm -rf vivid-*

# thefuck
pip3 install --upgrade thefuck

# docker
sudo dnf install -y docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# vault
wget https://releases.hashicorp.com/vault/1.16.0/vault_1.16.0_linux_arm64.zip
unzip vault_1.16.0_linux_arm64.zip
mv vault ~/.local/bin/
rm -f vault_1.16.0_linux_arm64.zip

# wakapi
sudo docker-compose -f ~/dotfiles/local/docker-compose.yml up -d

# cron
sudo dnf install -y cronie
sudo systemctl enable crond
sudo systemctl start crond

# # Use this cronjob to refresh the list of servers that fzf_find uses to search
# # for hosts when typing `ssh<C-f>`:
# echo "0 3 * * * bash -c \"curl -fsH 'Accept-encoding: gzip' https://<DOMAIN>/servers | gunzip - | jq -r '.servers | .[] | .fqdn' | sort | grep -v 'spare-' > ~/.cache/servers.tmp; if test -s ~/.cache/servers.tmp; then mv ~/.cache/servers.tmp ~/.cache/servers.txt; fi\" >>/tmp/cron.log 2>&1" >> cron && crontab cron && rm -f cron

# timezone
sudo timedatectl set-timezone Europe/Amsterdam

# work email
mkdir -p ~/code/work/
echo '[user]' > ~/code/work/.gitconfig
echo '  email = work.email@company.com' >> ~/code/work/.gitconfig

# reboot to finish changing the shell to fish
sudo reboot
