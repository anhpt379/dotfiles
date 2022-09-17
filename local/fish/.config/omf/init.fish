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

# Edit and run the current command in vim
bind \cv edit_and_run_command_buffer

# Make Control+W (or Option+Delete) in fish works similar to vim. By default,
# fish binds it to `backward-kill-path-component`, which doesn't respect the
# `-` character in the middle of a word.
bind \cw backward-kill-word

bind \b backward-kill-bigword

# Fzf
bind --erase \co
bind \t  'fzf_complete'
bind \cf 'fzf_find'
bind \cr 'fzf_history'
# bind \t  '__fish_expand_globabbreviation || fzf_complete'

# Fix fzf couldn't preview matches that end with `\`. This happens in fish
# only. Fzf uses the shell set in SHELL env to execute the preview command.
# https://github.com/junegunn/fzf/blob/0.25.0/src/util/util_unix.go#L13
set -gx SHELL '/bin/bash'

set -gx Z_DATA "$HOME/.local/share/z/data"

set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f --color=never --exclude ".git" -E "*.jp*g" -E "*.png"'
set -gx FZF_PREVIEW_COMMAND 'fzf_preview {}'
set -gx FZF_DEFAULT_OPTS    '
  --pointer=" " --prompt="FZF> "
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
