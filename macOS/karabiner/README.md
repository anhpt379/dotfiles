# How to sync Karabiner-Elements' settings

```bash
cp ~/dotfiles/macOS/karabiner/.config/karabiner/assets/complex_modifications/* ~/.config/karabiner/assets/complex_modifications/

# Add complex_modifications using Karabiner-Elements' UI

cp ~/.config/karabiner/karabiner.json ~/dotfiles/macOS/karabiner/.config/karabiner/karabiner.json
```

## Move cursor to center of active window when opening an app with Karabiner

This is useful when using multiple monitors. We need to copy [this
app](https://github.com/eucrasia/MoveCursorToCenterOfActiveWindow) to
~/Applications, and run this command:

```bash
xattr -d com.apple.quarantine ~/Applications/MoveCursorToCenterOfActiveWindow.app
```
