#!/bin/bash

source ~/.bash_aliases

# Fix unreadable dir names with 777 permissions
# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
export LS_COLORS=":ow=:"

# Fix unable to find `nginx` command
export PATH=/usr/sbin:$PATH

# Add ~/.local/bin to $PATH
export PATH=$HOME/.local/bin:$PATH

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

# A nicer bash prompt
export SHORT_HOST=$(hostname -f | cut -d. -f1-2)
if [ "$(id -u)" -eq 0 ]; then
  PS1="\[\e[00;31m\][${SHORT_HOST} \w]# \[\e[00m\]"
else
  PS1="[${SHORT_HOST} \w]$ "
fi

# Reset cursor shape to beam
PROMPT_COMMAND="printf '\033[6 q'"

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

# Fish-style abbr: expand aliases inline when pressing space.
# Uses bind -x so we mutate the readline buffer directly instead of
# replaying keys (which would recurse on the space binding).
_NO_EXPAND_ALIASES=(ls la ll lla grep fgrep egrep sudo)
_expand_alias_on_space() {
  local leading="${READLINE_LINE:0:$READLINE_POINT}"
  local trailing="${READLINE_LINE:$READLINE_POINT}"
  local first_word="${leading%% *}"
  if [[ -n $first_word && $leading == "$first_word" ]] && alias "$first_word" &>/dev/null; then
    local skip name
    for name in "${_NO_EXPAND_ALIASES[@]}"; do
      [[ $name == "$first_word" ]] && skip=1 && break
    done
    if [[ -z $skip ]]; then
      local def
      def=$(alias "$first_word")
      def="${def#*=\'}"
      def="${def%\'}"
      leading="$def"
    fi
  fi
  READLINE_LINE="${leading} ${trailing}"
  READLINE_POINT=$((${#leading} + 1))
}
bind -x '" ": _expand_alias_on_space'
