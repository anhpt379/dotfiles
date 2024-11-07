#!/bin/bash

bash .macos

xcode-select --install

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install stow
stow brew

brew bundle --global
brew autoupdate start 86400 --upgrade --cleanup

brew services start autoraise

echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

stow bash
stow bin
stow diff-so-fancy
stow fish
stow git
stow inputrc
stow kitty
stow less
stow lf
stow nvim
stow nvimpager
stow ssh
stow youtube-dl

cp -r karabiner/.config/karabiner ~/.config/
cp -r alt-tab/Library/Preferences/* ~/Library/Preferences/
cp -r maccy/Library/* ~/Library/
cp -r rectangle/Library/* ~/Library/

# fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# nvim
nvim -c "PlugInstall" -c "qall"

# prettyping
curl -fLo ~/.local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping
chmod +x ~/.local/bin/prettyping

# youtube-dl/yt-dlp
pip3 install --force-reinstall https://github.com/yt-dlp/yt-dlp/archive/refs/heads/master.zip
echo "0 * * * * bash ~/Music/youtube-dl/download.sh" > cron
crontab cron
rm -f cron
