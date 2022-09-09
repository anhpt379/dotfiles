#!/bin/bash

bash .macos

xcode-select --install
ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \

brew bundle
brew autoupdate --start 86400
brew autoupdate --upgrade
brew autoupdate --cleanup
brew autoupdate --enable-notification

stow bat
stow clear
stow curl
stow diff-so-fancy
stow docker
stow fish
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
stow youtube-dl

cp -r karabiner/.config/karabiner ~/.config/
cp -r alt-tab/Library/*   ~/Library/
cp -r maccy/Library/*     ~/Library/
cp -r rectangle/Library/* ~/Library/

# fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --path=~/.local/share/omf --config=~/.config/omf --yes --noninteractive
rm -f install

chsh -s /usr/local/bin/fish

# nvim
nvim -c "PlugInstall" -c "qall"
nvim -c "TSUpdate" -c "qall"

# Disable lua ftplugin, since it's really slow
# It got introduced since nvim 0.7.2 (in
# https://github.com/neovim/neovim/commit/fd5e5d2715d264447d94d7253f3c78bd7003a472)
# and it took ~1s to load.
sed -i 's/^.*\.lua.*$//g' /usr/local/Cellar/neovim/*/share/nvim/runtime/ftplugin.vim

# code formatters
pip3 install black
npm install -g @fsouza/prettierd
pip3 install yamlfixer-opt-nc

# nvim python/ruby/node.js provider
pip3 install neovim
gem install --bindir ~/.local/bin/ neovim
npm install -g neovim

# nvim null-ls
pip3 install vim-vint 'ansible-lint[community,yamllint]'
npm install -g jsonlint textlint write-good markdownlint-cli
gem install --bindir ~/.local/bin/ rubocop rubocop-rspec
gem install --bindir ~/.local/bin/ mdl
luarocks install luacheck
curl -fLo ~/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.10.0/hadolint-Darwin-x86_64 && \
  chmod +x ~/.local/bin/hadolint

# languagetool
pip3 install requests

# prettyping
curl -fLo ~/.local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping
chmod +x ~/.local/bin/prettyping

# grc-rs
cargo install grc-rs

# mocword
cargo install mocword

wget https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gunzip mocword.sqlite.gz
mv mocword.sqlite ~/.config/nvim/dictionaries/mocword.sqlite
rm -f mocword*

# fx
# npm install -g fx

# diff-so-fancy
curl -fLo ~/.local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping

git clone --depth=1 https://github.com/so-fancy/diff-so-fancy.git
mv diff-so-fancy/diff-so-fancy ~/.local/bin/
mv diff-so-fancy/lib/ ~/.local/bin/lib
rm -rf diff-so-fancy

# docker
docker-compose -f ~/dotfiles/local/docker-compose.yml up -d

# youtube-dl
pip3 install youtube-dl
echo "0 * * * * bash ~/Music/youtube-dl/download.sh" > cron
# Use this cronjob to refresh the list of servers that fzf_find uses to search
# for hosts when typing `ssh<C-f>`:
# echo "0 3 * * * bash -c \"curl -fsH 'Accept-encoding: gzip' https://<DOMAIN>/servers | gunzip - | jq -r '.servers | .[] | .fqdn' | sort | grep -v 'spare-' > ~/.cache/servers.txt\" >>/tmp/cron.log 2>&1" >> cron
crontab cron
rm -f cron
