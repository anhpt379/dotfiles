BREW      := $(shell brew --version 2>/dev/null)
CLI_TOOLS := $(xcode-select --install 2>&1 | grep installed;)


stow:
	stow wakatime
	stow git
	stow nvim
	stow tmux


install:
ifndef CLI_TOOLS
else
	xcode-select --install
endif

ifndef BREW
	echo "Homebrew isn't installed... installing..."
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
else
endif

	brew bundle
	make stow

	curl -L https://get.oh-my.fish > install
	fish install --yes --path=~/.local/share/omf --config=~/.config/omf


	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall

ifeq ($(wildcard ~/.tmux/plugins/tpm/.),)
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
endif

