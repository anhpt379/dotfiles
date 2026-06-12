#!/usr/bin/env zsh
# Mirrors .bashrc: same PATH, same prompt shape, same fish-style abbr
# behaviour. Plus a handful of zsh-only completion knobs that bring tab
# completion close to fish without any external plugins.

source ~/.bash_aliases

# Fix unreadable dir names with 777 permissions
# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
export LS_COLORS=":ow=:"

# Unique PATH array so re-sourcing this file doesn't grow it
typeset -U path PATH
path=($HOME/.local/bin /usr/sbin $path)

# Fix SSH auth socket location so agent forwarding works within tmux
if [[ -n $SSH_CONNECTION ]]; then
  mkdir -p ~/.ssh

  if [[ -n $SSH_AUTH_SOCK ]] && [[ $SSH_AUTH_SOCK != */.ssh/ssh_auth_sock ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi

  if [[ -n $SSH_TTY ]] && [[ $SSH_TTY != */.ssh/ssh_tty ]]; then
    ln -sf "$SSH_TTY" ~/.ssh/ssh_tty
  fi
fi

# Prompt — same shape as the bash one in .bashrc
export SHORT_HOST=$(hostname -f | cut -d. -f1-2)
if [[ $UID -eq 0 ]]; then
  PROMPT="%F{red}[${SHORT_HOST} %~]# %f"
else
  PROMPT="[${SHORT_HOST} %~]\$ "
fi

# Reset cursor shape to beam before each prompt (matches PROMPT_COMMAND in bash)
autoload -Uz add-zsh-hook
_reset_cursor() { printf '\033[6 q' }
add-zsh-hook precmd _reset_cursor

# Fix git-deploy umask complaining
umask 0002

# Extract nvim appimage
if ! test -f ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim || test ~/.local/bin/nvim.appimage -nt ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim || ! test -e ~/.local/bin/nvim; then
  if test -f ~/.local/bin/nvim.appimage; then
    rm -rf ~/.local/bin/nvim-appimage/
    mkdir -p ~/.local/bin/nvim-appimage/
    cd ~/.local/bin/nvim-appimage/ || exit 1
    ../nvim.appimage --appimage-extract >/dev/null

    ln -sf ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
  fi
fi

cd ~/ || exit 1

# Emacs-style key bindings (matches readline default in bash)
bindkey -e

bindkey '^[OH'  beginning-of-line
bindkey '^[OF'  end-of-line

# History — big, shared across sessions, dedup'd
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE \
       HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS \
       EXTENDED_HISTORY

# Quality-of-life: bare dir name = cd, build a stack of recent dirs,
# allow `# comments` interactively, no terminal bell on errors.
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# Up/Down search history filtered by what's already typed (mimics fish).
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^P'   up-line-or-beginning-search
bindkey '^N'   down-line-or-beginning-search

# Tab completion — fish-feel without any plugins. Tab brings up a
# highlighted, navigable menu; matching is case-insensitive, partial-
# word, and substring; entries are colored like ls.
autoload -Uz compinit
compinit -C -d "$HOME/.zcompdump"

setopt AUTO_MENU COMPLETE_IN_WORD ALWAYS_TO_END LIST_PACKED

# Never prompt "do you wish to see all N possibilities?"; just show them.
LISTMAX=9999

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings'     format '%F{red}no matches for %d%f'
zstyle ':completion:*:default'      list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

# Fish-style abbr: expand aliases inline when pressing space, so the
# expanded command is what shows up in history and on screen rather
# than the abbreviation. Mirrors the bind -x widget in .bashrc.
typeset -a _NO_EXPAND_ALIASES
_NO_EXPAND_ALIASES=(ls la ll lla grep fgrep egrep sudo)
_expand-alias-on-space() {
  emulate -L zsh
  local first_word="${LBUFFER%% *}"
  if [[ -n $first_word && $LBUFFER == "$first_word" ]] && (( ${+aliases[$first_word]} )); then
    local skip=0 name
    for name in $_NO_EXPAND_ALIASES; do
      [[ $name == "$first_word" ]] && skip=1 && break
    done
    (( ! skip )) && LBUFFER="${aliases[$first_word]}"
  fi
  LBUFFER+=' '
}
zle -N _expand-alias-on-space
bindkey ' ' _expand-alias-on-space
bindkey '^ ' magic-space  # Ctrl-Space inserts a literal space (no expansion)
