source ~/.bashrc

export PATH=$HOME/.local/bin:$PATH

# Use fish shell as default
export SHELL=$HOME/.local/bin/fish
sleep 1
exec $HOME/.local/bin/fish
