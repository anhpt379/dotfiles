import fontforge
import psMat


def copy_characters(source_font_path, dest_font_path, out_font_path, characters):
    # Open source and destination fonts
    source_font = fontforge.open(source_font_path)
    dest_font = fontforge.open(dest_font_path)

    dest_font.familyname = "ComicFira"
    dest_font.fontname = "ComicFira"
    dest_font.fullname = "ComicFira"

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

    # Save the modified font
    dest_font.generate(out_font_path)

    # Close fonts
    source_font.close()
    dest_font.close()


if __name__ == "__main__":
    characters = ["<", "=", ">", "+", "-", ",", "~"]
    copy_characters("FiraCode-Retina.ttf", "ComicMono.ttf", "ComicFira.ttf", characters)
