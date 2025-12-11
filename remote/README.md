# Update binary files

```fish
# fish
set fish_version 4.1.2  # We can't use the uppercase FISH_VERSION because it's a built-in variable from fish shell.
wget https://github.com/fish-shell/fish-shell/releases/download/$fish_version/fish-$fish_version-linux-x86_64.tar.xz
tar xf fish-$fish_version-linux-x86_64.tar.xz
rm -f fish-$fish_version-linux-x86_64.tar.xz
mv fish* HOME/.local/bin/

# tmux
wget 'https://github.com/andryandrew/tmux-appimage/releases/download/next-3.5/tmux.appimage'
mv tmux.appimage HOME/.local/bin/tmux.appimage
chmod +x HOME/.local/bin/tmux.appimage

# nvim
# wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
# The nightly version on neovim repo requires glibc version 3.31+. We don't have
# it on CentOS 7, so I use the one from neovim-releases instead.
wget https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage HOME/.local/bin/nvim.appimage

# fzf
set FZF_VERSION 0.67.0
wget https://github.com/junegunn/fzf/releases/download/v$FZF_VERSION/fzf-$FZF_VERSION-linux_amd64.tar.gz
tar zxvf fzf-$FZF_VERSION-linux_amd64.tar.gz
mv fzf HOME/.local/bin/
rm -f fzf-$FZF_VERSION-linux_amd64.tar.gz

# lf
wget https://github.com/gokcehan/lf/releases/download/r38/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf HOME/.local/bin/
rm -f lf-linux-amd64.tar.gz

# fd
wget https://github.com/sharkdp/fd/releases/download/v10.3.0/fd-v10.3.0-x86_64-unknown-linux-musl.tar.gz
tar zxvf fd-*-x86_64-unknown-linux-musl.tar.gz
mv fd-*/fd HOME/.local/bin/
rm -rf fd-*

# rg
wget https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz
tar zxvf ripgrep-*-x86_64-unknown-linux-musl.tar.gz
mv ripgrep-*/rg HOME/.local/bin/
rm -rf ripgrep-*

# grc
for f in grc grcat; do
  curl -fLo HOME/.local/bin/$f https://raw.githubusercontent.com/garabik/grc/master/$f
  chmod +x HOME/.local/bin/$f
done

# jq
curl -fLo HOME/.local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x HOME/.local/bin/jq

# kubecolor
mkdir kubecolor/
cd kubecolor/
wget https://github.com/kubecolor/kubecolor/releases/download/v0.3.3/kubecolor_0.3.3_linux_amd64.tar.gz
tar zxvf kubecolor_*.tar.gz
mv kubecolor ../HOME/.local/bin/
cd ..
rm -rf kubecolor*
```

## How to sync remote's dotfiles to another git repo

1. Create an empty git repo

1. Place this `sync_dotfiles.sh` file to that repo:

```bash
#!/bin/bash

git reset --hard HEAD
for branch in minimal master; do
  git checkout $branch

  rm -rf HOME
  git rm -r --cached HOME/

  echo "Syncing ~/dotfiles/remote/HOME/"
  if test $branch = 'minimal'; then
    rsync -azvhP \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        --delete \
        --relative \
        ~/dotfiles/remote/HOME/./.{bash_aliases,bash_profile,bashrc,curlrc,gitconfig,gitmessage,inputrc,less,psqlrc,terminfo,tmux.conf,vimrc} HOME/
  else
    rsync -azvhP \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        --delete \
        --exclude-from="/home/panh.linux/dotfiles/remote/.rsyncignore" \
        ~/dotfiles/remote/HOME/ HOME/
  fi

  git add --all
  git status
  git commit -m 'Sync local dotfiles'
  git push origin HEAD --force-with-lease
done
```

1. Run `bash sync_dotfiles.sh` to copy everything there.
