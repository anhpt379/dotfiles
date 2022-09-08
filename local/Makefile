BREW      := $(shell brew --version 2>/dev/null)
CLI_TOOLS := $(xcode-select --install 2>&1 | grep installed;)


stow:
	stow bat
	stow clear
	stow curl
	stow docker
	stow fish
	stow fonts
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
	stow wakapi-data
	stow wakatime
	stow youtube-dl

	cp -r karabiner/.config/karabiner ~/.config/
	cp -r alt-tab/Library/*   ~/Library/
	cp -r maccy/Library/*     ~/Library/
	cp -r rectangle/Library/* ~/Library/

install:
ifndef CLI_TOOLS
else
	xcode-select --install
endif

ifndef BREW
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
else
endif

	bash .macos

	brew bundle
	brew autoupdate --start 86400
	brew autoupdate --upgrade
	brew autoupdate --cleanup
	brew autoupdate --enable-notification

	make stow
