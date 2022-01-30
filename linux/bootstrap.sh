#!/bin/bash

sudo dnf install -y stow git fzf jq ipython ripgrep bat exa cargo fd-find telnet npm @development-tools

cd ~
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
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_33/shells:fish:release:3.repo
sudo dnf install -y fish
# export XDG_DATA_HOME=/usr/local/share  # Different $XDG_DATA_HOME for oh-my-fish local & remote
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
# sudo usermod -s /usr/bin/fish vagrant

# docker
# sudo dnf install -y docker docker-compose
# sudo systemctl start docker
# sudo docker-compose up -d

# nvim
sudo yum install -y libstdc++-static gcc-c++
sudo npm i -g npm@latest
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
rm -f nvim.appimage
sudo mv squashfs-root /
sudo ln -sf /squashfs-root/AppRun /usr/bin/nvim
nvim --version
# nvim -c "PlugInstall"

# lf
wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf ~/.local/bin/
rm -f lf-linux-amd64.tar.gz

# pretty-ping
curl -fLo /usr/local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping && chmod +x /usr/local/bin/prettyping

# xh
# cargo install xh

# diff-so-fancy
git clone --depth=1 https://github.com/so-fancy/diff-so-fancy.git
mv diff-so-fancy/diff-so-fancy ~/.local/bin/
mv diff-so-fancy/lib/ ~/.local/bin/lib
rm -rf diff-so-fancy
