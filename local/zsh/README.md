# How to install

1. Install oh-my-zsh

```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

1. Clone necessary plugins.

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions          ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete.git     ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
```

1. Add plugins to ~/.zshrc as

```
plugins = ( [plugins...] zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)
```

Note: make sure zsh-syntax-highlighting is the last one in the above list.

1. Restart zsh

```bash
source ~/.zshrc
```
