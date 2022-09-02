#!/bin/bash

sudo dnf install -y \
  stow git fzf jq fd-find ripgrep exa direnv \
  nmap-ncat ipython python3-virtualenv bind-utils git-subtree \
  cargo npm telnet atop corkscrew \
  grc gron pwgen tldr youtube-dl \
  python3-pip python3-devel luarocks lua-devel ruby-devel golang \
  man-pages @development-tools
sudo dnf upgrade -y less
sudo dnf group install -y "C Development Tools and Libraries"

stow --dir=dotfiles/linux/ --target=/home/vagrant/ curl
stow --dir=dotfiles/linux/ --target=/home/vagrant/ docker
stow --dir=dotfiles/linux/ --target=/home/vagrant/ fish
stow --dir=dotfiles/linux/ --target=/home/vagrant/ fzf
stow --dir=dotfiles/linux/ --target=/home/vagrant/ git
stow --dir=dotfiles/linux/ --target=/home/vagrant/ grc
stow --dir=dotfiles/linux/ --target=/home/vagrant/ inputrc
stow --dir=dotfiles/linux/ --target=/home/vagrant/ less
stow --dir=dotfiles/linux/ --target=/home/vagrant/ lf
stow --dir=dotfiles/linux/ --target=/home/vagrant/ nvim
stow --dir=dotfiles/linux/ --target=/home/vagrant/ ssh
stow --dir=dotfiles/linux/ --target=/home/vagrant/ tmux
stow --dir=dotfiles/linux/ --target=/home/vagrant/ wakatime
stow --dir=dotfiles/linux/ --target=/home/vagrant/ youtube-dl

# fish
sudo dnf config-manager --add-repo \
  https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_33/shells:fish:release:3.repo
sudo dnf install -y fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --path=~/.local/share/omf --config=~/.config/omf --yes --noninteractive
rm -f install

sudo usermod -s /usr/bin/fish vagrant

# nvim
sudo dnf install -y libstdc++-static gcc-c++
sudo npm i -g npm@latest

curl -fLo ~/.local/bin/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x ~/.local/bin/nvim.appimage
mkdir ~/.local/bin/nvim-appimage/
cd ~/.local/bin/nvim-appimage/ || exit 1
../nvim.appimage --appimage-extract
sudo ln -sf ~/.local/bin/nvim-appimage/squashfs-root/AppRun /usr/bin/nvim
cd ~/ || exit 1

nvim -c "PlugInstall" -c "qall"
nvim -c "TSUpdate" -c "qall"

# neoformat
sudo dnf install -y shfmt
pip install black

# yamlfmt
pip install yamlfmt

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
sudo dnf install -y scdoc
git clone https://github.com/lucc/nvimpager.git
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
