# Getting started

1. Enable iCloud

1. Open Terminal and install Xcode Command Line Tools:

   ```
   xcode-select --install
   ```

1. Clone dotfiles

   ```
   git clone https://github.com/anhpt379/dotfiles.git
   ```

   and follow commands in the `macOS/bootstrap.sh` file.

1. Install custom fonts for Kitty from `macOS/kitty/fonts/`

1. Open `System Settings`:

## Change display resolution

Go to `Settings` -> `Displays` -> `Built-in Display` -> `1800 x 1169`.

Then, `Finder` -> `View` -> `Show View Options` -> `Text size` -> `14`.

## Disable `Developer` search in Spotlight

```bash
cd /Applications
touch Xcode.app

# Then open Spotlight preferences, disable `Developer` checkbox
```

## Getting eyestrain when using MacBook Pro 14"?

Install this app & enable both options: <https://github.com/aiaf/Stillcolor>
