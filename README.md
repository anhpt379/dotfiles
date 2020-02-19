# My dotfiles

Install dependencies:

```bash
brew install stow yarn neovim git
```

Then:

```bash
# Navigate to your home directory
cd ~

# Clone this repo
git clone https://github.com/anhpt379/dotfiles.git

# Enter the dotfiles directory
cd dotfiles

# Install nvim config
stow nvim

# Install git config
stow git

# Install vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```

