# Update binary files

```
rm -rf .local

# fish
wget https://github.com/xxh/fish-portable/raw/master/result/fish-portable-musl-alpine-Linux-x86_64.tar.gz
mkdir -p /tmp/fish
tar -xzf fish-*.tar.gz -C /tmp/fish
cp /tmp/fish/bin/fish .local/bin/
rm -f fish-portable-musl-alpine-Linux-x86_64.tar.gz
rm -rf /tmp/fish

# nvim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage .local/bin/

# fzf
wget 'https://github.com/junegunn/fzf/releases/download/0.24.4/fzf-0.24.4-linux_amd64.tar.gz'
tar zxvf fzf-0.24.4-linux_amd64.tar.gz
mv fzf .local/bin/
rm -f fzf-0.24.4-linux_amd64.tar.gz

# fd
wget 'https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-x86_64-unknown-linux-musl.tar.gz'
tar zxvf fd-*.tar.gz
mv fd-*/fd .local/bin/
rm -rf fd-*

# devicon-lookup & exa
docker-compose build dotfiles
docker-compose run dotfiles fish
docker cp <container_id>:/usr/local/cargo/bin/exa .local/bin/
docker cp <container_id>:/usr/local/cargo/bin/devicon-lookup .local/bin/
```
