# Anh's dotfiles

Make sure you have [GNU stow](https://www.gnu.org/software/stow/) installed:

```bash
brew install stow
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

# Uninstall git config
stow -D git
```
