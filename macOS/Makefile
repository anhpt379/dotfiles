BREW      := $(shell brew --version 2>/dev/null)
CLI_TOOLS := $(xcode-select --install 2>&1 | grep installed;)


stow:
	stow fish
	stow kitty
	stow ssh
	cp -r karabiner/.config/karabiner ~/.config/

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
