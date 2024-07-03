import fontforge
import psMat


def shift(source_font_path, out_font_path):
    source_font = fontforge.open(source_font_path)

    # Shift all charactoers down 10%
    em_size = source_font.em
    shift_amount = -0.1 * em_size  # Negative to move down
    for glyph in source_font.glyphs():
        glyph.transform(psMat.translate(0, shift_amount))

    # Save the modified font
    source_font.generate(out_font_path)
    source_font.close()


if __name__ == "__main__":
    shift("ComicFira.ttf", "ComicFira-10.ttf")
    shift("SymbolsNerdFontMono-Regular.ttf", "SymbolsNerdFontMono-Regular-10.ttf")
