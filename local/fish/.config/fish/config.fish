#!/usr/bin/env fish

if not set -q COMPANY_NAME
    if test -f ~/code/work/.gitconfig
        set -gx COMPANY_NAME (
            cat ~/code/work/.gitconfig | grep '@' | head -1 | awk -F@ '{ print $NF }'
        )
    end
end

# ssh to the VM automatically
if string match -q -- "Darwin" (uname)
    if limactl list | grep -q Running
        set -l lima_ssh (limactl show-ssh fedora)
        set -l kitty_ssh "kitty +kitten $lima_ssh -t COMPANY_NAME=$COMPANY_NAME /bin/fish"
        eval $kitty_ssh
    end
end

set -gx COMPANY_NAME_LOWER (echo $COMPANY_NAME | tr A-Z a-z)
set -gx COMPANY_NAME_UPPER (echo $COMPANY_NAME | tr a-z A-Z)
set -gx COMPANY_NAME_CAPITALIZE (echo $COMPANY_NAME | sed 's/[^ ]*/\u&/g')
set -gx COMPANY_DOMAIN "$COMPANY_NAME_LOWER.com"

# Common aliases
alias ..    'cd ..'
alias ...   'cd ../..'
alias ....  'cd ../../..'
alias ..... 'cd ../../../..'

if set -q TMUX
    alias clear 'tput reset'
end

alias cmd 'command'
alias c   'clear'
alias q   'exit'
alias l   'less'
alias v   'nvimpager'
alias t   'tail'
alias tf  'tail -f'

alias ls  'exa --group-directories-first'
alias la  'exa --group-directories-first -a'
alias ll  'exa --group-directories-first -l'
alias lla 'exa --group-directories-first -la'

alias dmesg 'dmesg --color'

# Key bindings
bind \cg accept-autosuggestion execute
bind \cz undo

# Delete big word with Ctrl+Backspace
bind \ch backward-kill-bigword

# Make reverse word delete work (using ctrl/option+delete)
bind \e\[3\;5~ kill-bigword
bind \e\[3\;3~ kill-word

# Use pageup/pagedown to jump between big words
bind \e\[5~ forward-bigword
bind \e\[6~ backward-bigword

# Fix random command appears when pressing Option-N/P. This maps them to
# Up/Down, to behave the same as Ctrl-N/P.
bind \en down-or-search
bind \ep up-or-search

# Ctrl-D to exit immediately (the default behavior is `delete-or-exit`, which
# is annoying since I can't exit the shell in the middle of typing a command)
bind \cd 'exit'

# Fix can't see `null` in jq output (also changed `false` to red, `true` to
# green)
set -gx JQ_COLORS '36:31:32:0;39:0;32:1;39:1;39'

# Custom fish color scheme
set -U fish_color_normal normal
set -U fish_color_command dcdfe4
set -U fish_color_quote ffcc66
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error dd3c69
set -U fish_color_param dcdfe4
set -U fish_color_comment ffcc66
set -U fish_color_match 6699cc
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --bold
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

# Hide fish greeting
set fish_greeting

# Kitty integration
set --global KITTY_SHELL_INTEGRATION enabled
source ~/.config/fish/kitty/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish
set --prepend fish_complete_path ~/.config/fish/kitty/shell-integration/fish/vendor_completions.d

if type -q direnv
    direnv hook fish | source
end

if begin not string match -q -- "Darwin" (uname);
    and not string match -e -q -- "fedora" (hostname); end
    alias pp   'command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t'
    alias ppa  'command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t --environment=panh'
    alias ppl  'nvimpager -- --cmd "autocmd VimEnter * :normal G" /var/log/puppet/puppetagent.log'
    alias ppc  'nvimpager -c -- --cmd "set ft=cfg" /etc/puppetlabs/puppet/puppet.conf'
    alias motd 'cat /etc/motd; [ -f /etc/motd.local ] && cat /etc/motd.local'
    alias ssh  'cmd ssh'

    # Update the default email for git
    git config --global user.email anh.pham@$COMPANY_DOMAIN

    # Tell nvimpager where the nvim is
    set -gx NVIM ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim

    # Fix nvim `Cannot open undo file for writing` sometimes
    mkdir -p ~/.config/nvim/undo/
    if test "$USER" = root; and set -q "$COMPANY_NAME_UPPER"_USER
        chown -R panh ~/.config/nvim/undo/

        if test -d ~/.cache
            chown -R panh ~/.cache/
        end
    end

    # Shorten title
    title (hostname | awk -F. '{ print $1 }')

    # Fix `exa -l` complaining about timezone:
    #
    #   Unable to determine time zone: No such file or directory (os error 2)
    #
    set --erase TZ

    # Fix <C-c> doesn't work in remote fish
    bind \cc 'commandline ""'

    # Fix git-deploy umask complaining
    umask 0002

    # Auto start tmux
    if not set -q TMUX
        tmux attach -t panh; or tmux new -s panh
    end
end

