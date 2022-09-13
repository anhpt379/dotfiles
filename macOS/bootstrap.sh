#!/bin/bash

bash .macos

xcode-select --install
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew bundle
brew autoupdate start 86400 --upgrade --cleanup

stow clear
stow diff-so-fancy
stow fish
stow fzf
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

# fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --path=~/.local/share/omf --config=~/.config/omf --yes --noninteractive
rm -f install

echo '/opt/homebrew/bin/fish' | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# oh-my-fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install
fish install --path=~/.local/share/omf --config=~/.config/omf --yes --noninteractive
rm -f install

omf install

# nvim
nvim -c "PlugInstall" -c "qall"

# prettyping
curl -fLo ~/.local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping
chmod +x ~/.local/bin/prettyping

# youtube-dl
pip3 install youtube-dl
echo "0 * * * * bash ~/Music/youtube-dl/download.sh" > cron
crontab cron
rm -f cron
