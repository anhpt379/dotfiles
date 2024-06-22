import fontforge
import psMat

# Open the font file
font = fontforge.open("ComicMonoNF-Fira.ttf")

# Calculate the shift amount
em_size = font.em
shift_amount = -0.1 * em_size  # Negative to move down

# Iterate through all glyphs in the font
for glyph in font.glyphs():
    # Move each glyph down by the shift amount
    glyph.transform(psMat.translate(0, shift_amount))

# Save the modified font
font.generate("ComicMonoNF-Fira-10.ttf")
