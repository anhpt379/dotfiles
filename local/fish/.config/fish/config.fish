#!/usr/bin/env fish

# Install fisher & fish plugins
if status is-interactive && ! functions --query fisher
    curl -sL https://git.io/fisher | source && fisher update
end

if not set -q WORK_EMAIL
    if test -f ~/code/work/.gitconfig
        set -gx WORK_EMAIL (cat ~/code/work/.gitconfig | grep '@' | head -1 | awk '{ print $NF }')
    else
        echo "Error: No WORK_EMAIL detected!"
    end
end

set -gx COMPANY_NAME (echo $WORK_EMAIL | awk -F@ '{ print $NF }' | awk -F. '{ print $1 }')
set -gx COMPANY_NAME_LOWER (echo $COMPANY_NAME | tr A-Z a-z)
set -gx COMPANY_NAME_UPPER (echo $COMPANY_NAME | tr a-z A-Z)
set -gx COMPANY_NAME_CAPITALIZE (echo $COMPANY_NAME | sed 's/[^ ]*/\u&/g')
set -gx COMPANY_DOMAIN "$COMPANY_NAME_LOWER.com"

set -gx no_proxy localhost,.$COMPANY_DOMAIN

set -gx HOMEBREW_BUNDLE_FILE "~/.Brewfile"
set -gx GOPATH $HOME/.go

if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

set -gx PATH /opt/homebrew/opt/grep/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH
set -gx PATH $HOME/.go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.local/bin/nvim-appimage/squashfs-root/usr/bin/ $PATH
set -gx PATH $HOME/.local/bin $PATH

# https://github.com/high-moctane/mocword
set -gx MOCWORD_DATA $HOME/.config/nvim/dictionaries/mocword.sqlite

set -gx EDITOR 'nvim'
set -gx KUBE_EDITOR 'vim'

set -gx MANPAGER "/usr/bin/less"
set -gx PAGER    "/usr/bin/less"

# Fix trackpad scrolling doesn't work in diff-so-fancy
# Need to remove the `X` flag from less options, but can't do it via .gitconfig,
# since git set the default to `FRX` if we don't set `LESS` environment variable
# https://github.com/so-fancy/diff-so-fancy/issues/246
# https://github.com/git/git/blob/v2.7.1/Documentation/config.txt#L646-L648
set -gx LESS '--LONG-PROMPT --RAW-CONTROL-CHARS'

# Fix fzf couldn't preview matches that end with `\`. This happens in fish
# only. Fzf uses the shell set in SHELL env to execute the preview command.
# https://github.com/junegunn/fzf/blob/0.25.0/src/util/util_unix.go#L13
set -gx SHELL '/bin/bash'

set -gx Z_DATA "$HOME/.local/share/z/data"

set -gx FZF_DEFAULT_COMMAND 'fd --one-file-system --hidden --type f --color=never --exclude ".git" -E "*.jp*g" -E "*.png"'
set -gx FZF_PREVIEW_COMMAND 'fzf_preview {}'
set -gx FZF_DEFAULT_OPTS    '
  --pointer=" "
  --prompt="FZF> "
  --color=fg:#DCDFE4,bg:-1,hl:#DCDFE4
  --color=fg+:#FFCC66,bg+:#262626,hl+:#FFCC66
  --color=prompt:#f1f1f1,pointer:#f1f1f1
  --color=info:#696969,spinner:#696969
  --color=marker:#55CABE
  --color=spinner:108
  --cycle
  --no-multi
  --reverse
  --height=40%
  --preview-window=right:60%
  --bind=ctrl-/:toggle-preview
  --bind=ctrl-s:toggle-sort
  --bind=tab:accept,ctrl-j:ignore,ctrl-k:ignore
  --bind=change:first
  --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up
  --bind=ctrl-h:backward-kill-word
'

# lf
set -gx LF_ICONS (
    sed ~/.config/lf/icons \
        -e '/^[ \t]*#/d'   \
        -e '/^[ \t]*$/d'   \
        -e 's/[ \t]\+/=/g' \
        -e 's/$//'         \
    | tr '\n' ':'
)

# Hide fish greeting
set fish_greeting

# Use default fish key bindings
set -g fish_key_bindings fish_default_key_bindings

# Kitty integration
set --global KITTY_SHELL_INTEGRATION enabled
source ~/.config/fish/kitty/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish
set --prepend fish_complete_path ~/.config/fish/kitty/shell-integration/fish/vendor_completions.d

if type -q direnv
    direnv hook fish | source
end

globabbr C '| grcat'
globabbr J '| jq'
globabbr G '| grep'
globabbr H '| head'
globabbr L '| less'
globabbr P '| pbcopy'
globabbr S '| sort'
globabbr T '| tail'
globabbr U '| uniq'
globabbr V '| nvimpager'
globabbr W '| wc -l'

# Load aliases
source ~/.bash_aliases
source ~/.config/fish/aliases.fish

# Key bindings
bind \cg accept-autosuggestion execute
bind \cz undo

# Delete big word with Ctrl+Backspace
bind \ch backward-kill-bigword
bind \b backward-kill-bigword

# Make Control+W (or Option+Delete) in fish works similar to vim. By default,
# fish binds it to `backward-kill-path-component`, which doesn't respect the
# `-` character in the middle of a word.
bind \cw backward-kill-word

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

# Edit and run the current command in vim
bind \cv edit_and_run_command_buffer

# Fzf
bind --erase \co
bind \t  'fzf_complete'
bind \cf 'fzf_find'
bind \cr 'fzf_history'
# bind \t  '__fish_expand_globabbreviation || fzf_complete'

# search a server by fqdn prefix and open it in serverdb
function sdb
    set -l query $argv[1]
    set -l fqdn (cat ~/.cache/servers.txt | grep ^$query | head -1 | xargs)
    if test -n $fqdn
        set -l id (curl -s https://simpleapi.prod.$COMPANY_DOMAIN/servers/$fqdn | jq .server.id)
        open https://serverdb.$COMPANY_DOMAIN/hud/v/servers/server/$id/
    else
        echo "No servers found"
    end
end

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

if begin not string match -q -- "Darwin" (uname);
    and not string match -e -q -- "fedora" (hostname); end

    function psql
        cp ~/.psqlrc /tmp/
        sudo -u postgres bash -c "PSQLRC=/tmp/.psqlrc psql $argv[1]"
    end

    # Update the default email for git
    if set -q WORK_EMAIL
        git config --global user.email $WORK_EMAIL
    end

    # Tell nvimpager where the nvim is
    set -gx NVIM ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim

    # Fix nvim `Cannot open undo file for writing` sometimes
    mkdir -p ~/.config/nvim/undo/
    if test "$USER" = root; and set -q "$COMPANY_NAME_UPPER"_USER
        chown -R panh ~/.config/nvim/undo/

        if test -d ~/.local/share/nvim/shada/
            chown -R panh ~/.local/share/nvim/shada/
        end

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
    if begin; not set -q TMUX; and test -x /usr/bin/tmux; end
        /usr/bin/tmux attach -t panh; or /usr/bin/tmux new -s panh
    end
end

