#!/bin/bash

sudo dnf install -y \
  stow git fzf jq fd-find ripgrep bat exa \
  nmap-ncat ipython \
  cargo npm telnet atop \
  grc gron pwgen tldr youtube-dl \
  python3-pip luarocks lua-devel ruby-devel \
  @development-tools
sudo dnf group install -y "C Development Tools and Libraries"

stow --dir=dotfiles/linux/ --target=/home/vagrant/ bat
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

# fish
sudo dnf config-manager --add-repo \
  https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_33/shells:fish:release:3.repo
sudo dnf install -y fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --path=~/.local/share/omf --config=~/.config/omf --yes --noninteractive
rm -f install

sudo usermod -s /usr/bin/fish vagrant

# nvim
sudo yum install -y libstdc++-static gcc-c++
sudo npm i -g npm@latest
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo mv squashfs-root /
sudo ln -sf /squashfs-root/AppRun /usr/bin/nvim
rm -f nvim.appimage
nvim -c "PlugInstall" -c "qall"
nvim -c "TSUpdate" -c "qall"

# null-ls
pip install vim-vint ansible-lint[community,yamllint]
sudo npm install -g jsonlint textlint write-good # markdownlint
gem install --bindir ~/.local/bin/ mdl rubocop
sudo luarocks install luacheck
sudo dnf install -y ShellCheck codespell proselint
curl -fLo ~/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.8.0/hadolint-Linux-x86_64 && \
  chmod +x ~/.local/bin/hadolint

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

# fx
sudo npm install -g fx

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

# ssh
mkdir ~/.ssh/control/

# timezone
sudo timedatectl set-timezone Europe/Amsterdam

# reboot to finish changing the shell to fish
reboot
