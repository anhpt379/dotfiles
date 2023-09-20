# Update binary files

```fish
# fish
# https://github.com/fish-shell/fish-shell/issues/6475#issuecomment-1498722501
wget 'https://github.com/mliszcz/fish-shell/releases/download/fish-3.6.1-x86_64/fish-3.6.1-x86_64.AppImage'
mv fish-*.AppImage HOME/.local/bin/fish.appimage
chmod +x HOME/.local/bin/fish.appimage

# tmux
wget 'https://github.com/kiyoon/tmux-appimage/releases/download/3.3a/tmux.appimage'
mv tmux.appimage HOME/.local/bin/tmux.appimage
chmod +x HOME/.local/bin/tmux.appimage

# atop
docker-compose build atop
docker-compose run atop cp /usr/bin/atop /out/

# nvim
# wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
# The nightly version on neovim repo requires glibc version 3.31+. We don't have
# it on CentOS 7, so I use the one from neovim-releases instead.
wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage HOME/.local/bin/

# fzf
set FZF_VERSION 0.42.0
wget https://github.com/junegunn/fzf/releases/download/$FZF_VERSION/fzf-$FZF_VERSION-linux_amd64.tar.gz
tar zxvf fzf-$FZF_VERSION-linux_amd64.tar.gz
mv fzf HOME/.local/bin/
rm -f fzf-$FZF_VERSION-linux_amd64.tar.gz

# lf
wget https://github.com/gokcehan/lf/releases/download/r30/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf HOME/.local/bin/
rm -f lf-linux-amd64.tar.gz

# fd
wget https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-x86_64-unknown-linux-musl.tar.gz
tar zxvf fd-*-x86_64-unknown-linux-musl.tar.gz
mv fd-*/fd HOME/.local/bin/
rm -rf fd-*

# rg
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
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
```

## How to sync remote's dotfiles to another git repo

1. Create an empty git repo

1. Place this `sync_dotfiles.sh` file to that repo:

```bash
#!/bin/bash

rm -rf HOME
git rm -r --cached HOME/

echo "Syncing ~/dotfiles/remote/HOME/"
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

git add --all
git status
git commit -m 'Sync local dotfiles'
git push origin HEAD --force-with-lease
```

1. Run `bash sync_dotfiles.sh` to copy everything there.
