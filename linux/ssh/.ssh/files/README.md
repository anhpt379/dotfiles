# Update binary files

```
# fish
docker-compose build fish
docker-compose run fish cp /usr/bin/fish /out/

# atop
docker-compose build atop
docker-compose run atop cp /usr/bin/atop /out/

# rust apps
docker-compose build cargo
docker-compose run cargo cp /usr/local/cargo/bin/{bat,exa,xh} /out/

# nvim
wget https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage .local/bin/

# fzf
wget https://github.com/junegunn/fzf/releases/download/0.30.0/fzf-0.30.0-linux_amd64.tar.gz
tar zxvf fzf-*-linux_amd64.tar.gz
mv fzf .local/bin/
rm -f fzf-*-linux_amd64.tar.gz

# lf
wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf .local/bin/
rm -f lf-linux-amd64.tar.gz

# fd
wget https://github.com/sharkdp/fd/releases/download/v8.3.2/fd-v8.3.2-x86_64-unknown-linux-musl.tar.gz
tar zxvf fd-*-x86_64-unknown-linux-musl.tar.gz
mv fd-*/fd .local/bin/
rm -rf fd-*

# rg
wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
tar zxvf ripgrep-*-x86_64-unknown-linux-musl.tar.gz
mv ripgrep-*/rg .local/bin/
rm -rf ripgrep-*

# diff-so-fancy
git clone --depth=1 https://github.com/so-fancy/diff-so-fancy.git
mkdir -p .local/bin/lib/
cp diff-so-fancy/diff-so-fancy .local/bin/
cp diff-so-fancy/lib/* .local/bin/lib/
rm -rf diff-so-fancy

```
