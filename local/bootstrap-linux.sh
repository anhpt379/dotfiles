#!/bin/bash

sudo apt-get update --allow-releaseinfo-change

sudo apt-get install -y --no-install-recommends stow git \
  fzf jq ripgrep exa \
  curl ncat dnsutils \
  telnet atop corkscrew \
  grc gron pwgen tldr \
  youtube-dl ipython \
  python3-virtualenv python3-pip python3-dev \
  cargo npm luarocks golang build-essential

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
stow curl
stow docker
stow fish
stow fzf
stow git
stow grc
stow inputrc
stow less
stow lf
stow nvim
stow ssh
stow tmux
stow wakatime

# fd
wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-aarch64-unknown-linux-gnu.tar.gz
tar zxvf fd-*.tar.gz
mv fd-*/fd ~/.local/bin/
rm -rf fd-*

# nvim
# sudo npm i -g npm@latest

sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone --depth=1 https://github.com/neovim/neovim.git
cd neovim || exit 1
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

nvim -c "PlugInstall" -c "qall"
nvim -c "TSUpdate" -c "qall"

# neoformat
go install mvdan.cc/sh/v3/cmd/shfmt@latest
pip3 install black

# prettier
sudo npm install -g --save-dev --save-exact prettier

# python/ruby/node.js provider
pip install neovim
gem install --bindir ~/.local/bin/ neovim
sudo npm install -g neovim

# null-ls
pip install vim-vint 'ansible-lint[community,yamllint]'
sudo npm install -g jsonlint textlint write-good markdownlint-cli
sudo gem install --bindir ~/.local/bin/ rubocop rubocop-rspec
gem install --bindir ~/.local/bin/ mdl puppet puppet-lint puppet-lint-strict_indent-check
rm -f ~/.local/bin/puppet

sudo luarocks install luacheck
sudo dnf install -y ShellCheck codespell proselint
curl -fLo ~/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.8.0/hadolint-Linux-x86_64 && \
  chmod +x ~/.local/bin/hadolint

# nvimpager
sudo apt install -y scdoc
git clone --depth=1 https://github.com/lucc/nvimpager.git
cd nvimpager || exit 1
make PREFIX=~/.local install
cd ..
rm -rf nvimpager

# lf
wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf ~/.local/bin/
rm -f lf-linux-amd64.tar.gz

# prettyping
curl -fLo ~/.local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping
chmod +x ~/.local/bin/prettyping

# xh
cargo install xh

# grc-rs
cargo install grc-rs

# mocword
cargo install mocword

# fx
sudo npm install -g fx

# glow
sudo rpm -i https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.rpm

# diff-so-fancy
git clone --depth=1 https://github.com/so-fancy/diff-so-fancy.git
mv diff-so-fancy/diff-so-fancy ~/.local/bin/
mv diff-so-fancy/lib/ ~/.local/bin/lib
rm -rf diff-so-fancy

# docker
sudo dnf install -y docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo docker-compose -f ~/dotfiles/linux/docker-compose.yml up -d

# puppet-editor-config
cd ~/.local/share/nvim/lsp_servers/puppet || exit 1
sed -i 's/\r//g' puppet-*

# cron
sudo dnf install -y cronie
sudo systemctl enable crond
sudo systemctl start crond

echo "0 * * * * bash ~/Music/youtube-dl/download.sh" > cron
# Use this cronjob to refresh the list of servers that fzf_find uses to search
# for hosts when typing `ssh<C-f>`:
# echo "0 3 * * * bash -c \"curl -fsH 'Accept-encoding: gzip' https://<DOMAIN>/servers | gunzip - | jq -r '.servers | .[] | .fqdn' | sort | grep -v 'spare-' > ~/.cache/servers.txt\" >>/tmp/cron.log 2>&1" >> cron
crontab cron
rm -f cron

# ffmpeg
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
sudo dnf install -y ffmpeg

# ssh
mkdir ~/.ssh/control/

# timezone
sudo timedatectl set-timezone Europe/Amsterdam

# reboot to finish changing the shell to fish
reboot
