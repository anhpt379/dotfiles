# Update binary files

```
rm -rf .local

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
wget https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage .local/bin/

# fzf
wget 'https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz'
tar zxvf fzf-*-linux_amd64.tar.gz
mv fzf .local/bin/
rm -f fzf-*-linux_amd64.tar.gz

# lf
wget https://github.com/gokcehan/lf/releases/download/r24/lf-linux-amd64.tar.gz
tar zxvf lf-linux-amd64.tar.gz
mv lf .local/bin/
rm -f lf-linux-amd64.tar.gz

# fd
wget 'https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-x86_64-unknown-linux-musl.tar.gz'
tar zxvf fd-*-x86_64-unknown-linux-musl.tar.gz
mv fd-*/fd .local/bin/
rm -rf fd-*-x86_64-unknown-linux-musl.tar.gz

# diff-so-fancy
git clone --depth=1 https://github.com/so-fancy/diff-so-fancy.git
mkdir -p .local/bin/lib/
cp diff-so-fancy/diff-so-fancy .local/bin/
cp diff-so-fancy/lib/* .local/bin/lib/
rm -rf diff-so-fancy

```
