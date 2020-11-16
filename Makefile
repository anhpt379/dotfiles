BREW      := $(shell brew --version 2>/dev/null)
CLI_TOOLS := $(xcode-select --install 2>&1 | grep installed;)


stow:
	stow bat
	stow curl
	stow fish
	stow fzf
	stow git
	stow inputrc
	stow kitty
	stow less
	stow lf
	stow nvim
	stow ssh
	stow tig
	stow tmux
	stow wakatime
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

	pip3 install --user -r requirements.txt
	cargo install devicon-lookup
	gem install --user-install \
		puppet-lint \
		puppet-lint-strict_indent-check \
		puppet-lint-trailing_comma-check \
		puppet-lint-trailing_newline-check \
		solargraph
	curl -fLo /usr/local/bin/prettyping https://github.com/denilsonsa/prettyping/raw/master/prettyping && chmod +x /usr/local/bin/prettyping

	mkdir -p ~/.config/nvim/autoload/
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim -c "PlugInstall" -c "call coc#util#install()" -c "qall"

	@if [ ! -d "$$HOME/.local/share/omf" ]; then \
		curl -L https://get.oh-my.fish > /tmp/install; \
		fish /tmp/install --yes --path=~/.local/share/omf --config=~/.config/omf; \
		rm -f /tmp/install; \
	fi
