# macOS
- kitty
- karabiner
- opener
- rectangle
- alt-tab
- fonts

# vagrant
- inputrc
- bash
- fish
- lf
- curl
- docker
- fzf
- git
- tmux

# Why vagrant?

- git is slower in macOS, especially with ForcePoint
- poor persistent storage performance in Docker for macOS
- `git status` in puppet.git is ~50ms in Virtualbox, while ~200ms in macOS
  without ForcePoint, and ~900ms in macOS with ForcePoint.
