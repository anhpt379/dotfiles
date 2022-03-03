#!/bin/bash

sudo dnf install -y \
  stow git fzf jq fd-find ripgrep bat exa \
  nmap-ncat ipython python3-virtualenv bind-utils \
  cargo npm telnet atop \
  grc gron pwgen tldr youtube-dl \
  python3-pip luarocks lua-devel ruby-devel golang \
  man-pages @development-tools
sudo dnf upgrade -y less
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

curl -fLo ~/.local/bin/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x ~/.local/bin/nvim.appimage
mkdir ~/.local/bin/nvim-appimage/
cd ~/.local/bin/nvim-appimage/ || exit 1
../nvim.appimage --appimage-extract
sudo ln -sf ~/.local/bin/nvim-appimage/squashfs-root/AppRun /usr/bin/nvim
cd ~/ || exit 1

nvim -c "PlugInstall" -c "qall"
nvim -c "TSUpdate" -c "qall"

# neoformat
sudo yum install -y shfmt
pip install black

# null-ls
pip install vim-vint 'ansible-lint[community,yamllint]'
sudo npm install -g jsonlint textlint write-good markdownlint-cli
gem install --bindir ~/.local/bin/ \
  mdl rubocop \
  puppet puppet-lint \
  puppet-lint-absolute_classname-check \
  puppet-lint-absolute_template_path \
  puppet-lint-alias-check \
  puppet-lint-anchor-check \
  puppet-lint-appends-check \
  puppet-lint-array_formatting-check \
  puppet-lint-class_parameter-check \
  puppet-lint-classes_and_types_beginning_with_digits-check \
  puppet-lint-concatenated_template_files-check \
  puppet-lint-cuddled_else-check \
  puppet-lint-duplicate_class_parameters-check \
  puppet-lint-ec2_facts-check \
  puppet-lint-empty_lines_around_body-check \
  puppet-lint-empty_string-check \
  puppet-lint-empty_trailing_lines \
  puppet-lint-exec_idempotent-check \
  puppet-lint-explicit_hiera_class_param_lookup-check \
  puppet-lint-extended \
  puppet-lint-file_ensure-check \
  puppet-lint-file_line_match-check \
  puppet-lint-file_source_rights-check \
  puppet-lint-fileserver-check \
  puppet-lint-global_resource-check \
  puppet-lint-i18n \
  puppet-lint-leading_zero-check \
  puppet-lint-legacy_fact-check \
  puppet-lint-legacy_facts-check \
  puppet-lint-lookup_in_parameter-check \
  puppet-lint-manifest_whitespace-check \
  puppet-lint-no_chaining_arrows-check \
  puppet-lint-no_cron_resources-check \
  puppet-lint-no_erb_template-check \
  puppet-lint-no_file_path_attribute-check \
  puppet-lint-no_symbolic_file_modes-check \
  puppet-lint-non_erb_template_filename-check \
  puppet-lint-numericvariable \
  puppet-lint-optional_default-check \
  puppet-lint-package_ensure-check \
  puppet-lint-param-docs \
  puppet-lint-param-types \
  puppet-lint-parameter_type-check \
  puppet-lint-params_empty_string-check \
  puppet-lint-racism_terminology-check \
  puppet-lint-recurse_file-check \
  puppet-lint-resource_outside_class-check \
  puppet-lint-resource_reference_syntax \
  puppet-lint-roles-profiles \
  puppet-lint-roles_and_profiles-check \
  puppet-lint-security-plugins \
  puppet-lint-spaceship_operator_without_tag-check \
  puppet-lint-strict_indent-check \
  puppet-lint-template_file_extension-check \
  puppet-lint-top_scope_facts-check \
  puppet-lint-topscope-variable-check \
  puppet-lint-trailing_comma-check \
  puppet-lint-trailing_newline-check \
  puppet-lint-uncuddled_else-check \
  puppet-lint-undef_in_function-check \
  puppet-lint-unquoted_string-check \
  puppet-lint-usascii_format-check \
  puppet-lint-use_ensure_packages-check \
  puppet-lint-variable_contains_upcase \
  puppet-lint-version_comparison-check \
  puppet-lint-wmf_styleguide-check \
  puppet-lint-world_writable_files-check \
  puppet-lint-yumrepo_gpgcheck_enabled-check
rm -f ~/.local/bin/puppet

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

# grc-rs
cargo install grc-rs

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

echo "0 * * * * bash ~/dotfiles/linux/youtube-dl/Music/youtube-dl/download.sh" > cron
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
