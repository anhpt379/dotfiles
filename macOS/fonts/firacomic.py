import fontforge
import psMat
import string


def copy_characters(source_font_path, dest_font_path, out_font_path, characters):
    # Open source and destination fonts
    source_font = fontforge.open(source_font_path)
    dest_font = fontforge.open(dest_font_path)

    dest_font.familyname = "FiraComic"
    dest_font.fontname = "FiraComic"
    dest_font.fullname = "FiraComic"

    for character in characters:
        # Check if the character exists in the source font
        unicode_value = ord(character)
        if unicode_value in source_font:
            # Select glyph in source font
            source_font.selection.select(unicode_value)

            # Copy glyph from source to destination font
            source_font.copy()
            dest_font.selection.select(unicode_value)
            dest_font.paste()
        else:
            print(f"Warning: '{character}' not found in source font.")

    # Shift all charactoers down 10%
    em_size = dest_font.em
    shift_amount = -0.1 * em_size  # Negative to move down
    for glyph in dest_font.glyphs():
        glyph.transform(psMat.translate(0, shift_amount))

    # Save the modified font
    dest_font.generate(out_font_path)

    # Close fonts
    source_font.close()
    dest_font.close()


if __name__ == "__main__":
    characters = list(string.ascii_letters + string.digits + string.punctuation)

    # We don't replace a few letters in FiraCode, since we want to enable ligatures
    # for them.
    for char in list("?.+~\\_-<>:;,|="):
        characters.remove(char)

    copy_characters(
        "ComicMonoNF-Regular.ttf", "FiraCode-Retina.ttf", "FiraComic.ttf", characters
    )
