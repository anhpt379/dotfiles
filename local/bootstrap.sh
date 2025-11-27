#!/bin/bash

set -e

read -p "Enter company domain (e.g., example.com): " company_domain

sudo dnf copr enable -y alternateved/eza

sudo dnf install -y \
  kitty-terminfo which \
  stow git fish tmux neovim \
  jq ripgrep eza rsync zoxide \
  curl wget nmap-ncat \
  telnet corkscrew \
  tldr man-pages grc dnsutils moreutils\
  atop pwgen ncdu hyperfine \
  ipython python3-uv irb \
  python3-setuptools python3-pip python3-devel \
  golang npm luarocks lua-devel ruby-devel \

# dotfiles
cd ~/dotfiles/local

stow fish

sudo chsh -s /usr/bin/fish $USER

# fisher
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
git -C ~/dotfiles checkout origin/master local/fish/.config/fish/fish_plugins
fish -c 'fisher update'

# stow
mkdir -p ~/.local/bin/
mkdir -p ~/.config/nvim/undo/
rm -f ~/.bashrc
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

ln -sf /usr/bin/fish ~/.local/bin/fish
rm -f ~/Downloads && ln -s "/Users/$USER/Downloads" ~/Downloads

# neovim
# sudo dnf install -y ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch gettext curl
# git clone --depth=1 https://github.com/neovim/neovim
# cd neovim || exit 1
# git fetch --tags --force
# git checkout stable
# make CMAKE_BUILD_TYPE=RelWithDebInfo
# sudo make install
# nvim --version
# cd ..
# rm -rf neovim

# nvim needs this tree-sitter-cli to install some tree-sitter languages (e.g. swift)
sudo npm config set registry https://artifactory.${company_domain}/artifactory/api/npm/npm/
sudo npm install -g tree-sitter-cli

# Install nightly rust to compile blink.cmp
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup install nightly

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
wget https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-aarch64-unknown-linux-gnu.tar.gz
tar zxvf fd-*.tar.gz
mv fd-*/fd ~/.local/bin/
mv fd-*/fd.1 ~/.local/share/man/man1/
rm -rf fd-*

# fzf
cd /tmp || exit 1
export FZF_VERSION=0.66.0
curl -fLo ~/.local/share/man/man1/fzf.1 https://raw.githubusercontent.com/junegunn/fzf/v$FZF_VERSION/man/man1/fzf.1
wget https://github.com/junegunn/fzf/releases/download/v$FZF_VERSION/fzf-$FZF_VERSION-linux_arm64.tar.gz
tar zxvf fzf-*.tar.gz
mv fzf ~/.local/bin/
rm -rf fzf-*.tar.gz
cd - || exit 1

# fastgron
# cd /tmp || exit 1
# git clone https://github.com/adamritter/fastgron.git
# cd fastgron || exit 1
# git fetch --tags
# git checkout v0.6.5
# cmake -B build
# cmake --build build
# cmake install build/
# cp build/fastgron ~/.local/bin/
# cd - || exit 1

# nvim
nvim -c "PlugInstall" -c "TSInstall all" -c "qall"

# gitlint
pip3 install gitlint

# code formatters
sudo dnf install -y shfmt
pip3 install black
sudo npm install -g @fsouza/prettierd
pip3 install yamlfixer-opt-nc

cargo install stylua

# python/ruby/node.js provider
pip3 install neovim
sudo gem install --bindir ~/.local/bin/ neovim
sudo npm install -g neovim

# terraform
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --overwrite --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform

# gptree
pip3 install gptree-cli

# tree-sitter
sudo dnf install -y gcc-c++ libstdc++-static

# null-ls
pip3 install vim-vint
sudo npm install -g jsonlint write-good markdownlint-cli
sudo gem install --bindir ~/.local/bin/ rubocop rubocop-rspec mdl

sudo luarocks install luacheck
sudo dnf install -y codespell proselint hadolint ShellCheck

# languagetool
pip3 install --upgrade requests

# lf
cd /tmp || exit
export LF_VERSION=r38
curl -fLo ~/.local/share/man/man1/lf.1 https://raw.githubusercontent.com/gokcehan/lf/$LF_VERSION/lf.1
wget https://github.com/gokcehan/lf/releases/download/$LF_VERSION/lf-linux-arm64.tar.gz
tar zxvf lf-*.tar.gz
mv lf ~/.local/bin/
rm -f lf-*.tar.gz
cd - || exit 1

# Install crystal lang (to compile tmux-fingers)
sudo tee /etc/yum.repos.d/84codes_crystal.repo << 'EOF'
[84codes_crystal]
name=84codes_crystal
baseurl=https://packagecloud.io/84codes/crystal/fedora/$releasever/$basearch
gpgkey=https://packagecloud.io/84codes/crystal/gpgkey
repo_gpgcheck=1
gpgcheck=0
EOF
sudo dnf install -y crystal

# Clone tmux-fingers
if ! test -d ~/.tmux/plugins/tmux-fingers; then
  git clone https://github.com/anhpt379/tmux-fingers ~/.tmux/plugins/tmux-fingers
fi

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

# vivid
VIVID_VERSION=0.10.1
wget https://github.com/sharkdp/vivid/releases/download/v${VIVID_VERSION}/vivid-v${VIVID_VERSION}-aarch64-unknown-linux-gnu.tar.gz
tar zxvf vivid-*.tar.gz
mv vivid-*/vivid ~/.local/bin/
rm -rf vivid-*

# docker
sudo dnf install -y docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# vault
VAULT_VERSION=1.21.0
wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_arm64.zip
unzip vault_${VAULT_VERSION}_linux_arm64.zip
mv vault ~/.local/bin/
rm -f vault_${VAULT_VERSION}_linux_arm64.zip

# okta-aws-cli
OKTA_AWS_CLI_VERSION=2.5.1
mkdir /tmp/okta-aws-cli
cd /tmp/okta-aws-cli
wget https://github.com/okta/okta-aws-cli/releases/download/v${OKTA_AWS_CLI_VERSION}/okta-aws-cli_${OKTA_AWS_CLI_VERSION}_linux_arm64.tar.gz
tar zxvf okta-aws-cli_*.tar.gz
mv okta-aws-cli ~/.local/bin/
rm -rf /tmp/okta-aws-cli/*
cd -

# wakapi
sudo docker-compose -f ~/dotfiles/local/docker-compose.yml up -d

# cron
sudo dnf install -y cronie
sudo systemctl enable crond
sudo systemctl start crond

# # Use this cronjob to refresh the list of servers that fzf_find uses to search
# # for hosts when typing `ssh<C-f>`:
echo "0 3 * * * bash -c \"curl -fsH 'Accept-encoding: gzip' https://simpleapi.prod.${company_domain}/servers | gunzip - | jq -r '.servers | .[] | .fqdn' | sort | grep -v 'spare-' > ~/.cache/servers.tmp; if test -s ~/.cache/servers.tmp; then mv ~/.cache/servers.tmp ~/.cache/servers.txt; fi\" >>/tmp/cron.log 2>&1" >> cron && crontab cron && rm -f cron

# timezone
sudo timedatectl set-timezone Europe/Amsterdam

# work email
mkdir -p ~/code/work/
echo '[user]' > ~/code/work/.gitconfig
echo "  email = anh.pham@${company_domain}" >> ~/code/work/.gitconfig

cd ~/dotfiles
git remote set-url origin git@github.com:anhpt379/dotfiles.git

# reboot to finish changing the shell to fish
sudo reboot
