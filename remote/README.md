# Update binary files

```bash
# fish
docker-compose build fish
docker-compose run fish cp /usr/bin/fish /out/

# atop
docker-compose build atop
docker-compose run atop cp /usr/bin/atop /out/

# rust apps
docker-compose build cargo
docker-compose run cargo cp /usr/local/cargo/bin/{exa,xh} /out/

# nvim
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage HOME/.local/bin/

# fzf
wget https://github.com/junegunn/fzf/releases/download/0.32.1/fzf-0.32.1-linux_amd64.tar.gz
tar zxvf fzf-*-linux_amd64.tar.gz
mv fzf HOME/.local/bin/
rm -f fzf-*-linux_amd64.tar.gz

# lf
wget https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf HOME/.local/bin/
rm -f lf-linux-amd64.tar.gz

# fd
wget https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-x86_64-unknown-linux-musl.tar.gz
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
```
