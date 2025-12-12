# Fonts

- ComicMono NF: <https://github.com/xtevenx/ComicMonoNF>
- Comic Fork Mono: <https://github.com/caioycosta/comic-fork-mono-font/tree/master>
- Symbols Nerd Font: <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/NerdFontsSymbolsOnly>

The icons from Symbols Nerd Font is too big. To make it look good on Kitty, we
need to scale it down a bit.

On macOS, run these commands:

```bash
brew install fontforge

cd ~/dotfiles/macOS/kitty/fonts/
fontforge -lang=py -c "import fontforge, psMat; f=fontforge.open('SymbolsNerdFontMono-Regular.ttf'); f.selection.all(); [g.transform(psMat.scale(0.75)) for g in f.selection.byGlyphs]; f.generate('SymbolsNerdFontMono-Regular-75%.ttf')"
```

Then, install the `SymbolsNerdFontMono-Regular-75%.ttf` font instead.
