# My dotfiles

## Installation

Clone this repo and use [make](https://www.gnu.org/software/make/) or
[stow](https://www.gnu.org/software/stow/) to install:

```bash
# Install everything
$ make install

# or install just a few components
$ stow git
$ stow nvim
$ stow kitty
```

## Screenshots

![screenshot-1](screenshots/1.png)
![screenshot-2](screenshots/2.png)
![screenshot-3](screenshots/3.png)
![screenshot-4](screenshots/4.png)
![screenshot-5](screenshots/5.png)
![screenshot-6](screenshots/6.png)
![screenshot-7](screenshots/7.png)
![screenshot-8](screenshots/8.png)

## Vim `HJKL` everywhere with [Karabiner](karabiner/.config/karabiner/karabiner.json)

### Navigation

When pressed together with `CapsLock`, `Option` or `Command`, `HJKL` will
become arrow keys (Left/Down/Up/Right):

- `CapsLock` + `H/J/K/L` will perform character-level cursor movements.
  - Hold additional `Shift` to select text.

- `Option` + `H/J/K/L` will perform word-level cursor movements.
  - Hold additional `Shift` to select text.

- `Command` + `H/J/K/L` will perform page-level cursor movements.
  - Hold additional `Shift` to select text.

- `Ctrl` + `N/P` to go down and up.

### A more useful `CapsLock` key

- Single press to simulate `Escape`.
- Hold to simulate `Control`.

