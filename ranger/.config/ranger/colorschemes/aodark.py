from ranger.gui.color import blue, cyan, green, magenta, red, yellow, default, normal, bold, reverse, BRIGHT
from ranger.gui.colorscheme import ColorScheme


class Xoria256(ColorScheme):
    progress_bar_color = blue
    default_colors = (250, 234, normal)

    def use(self, context):
        fg, bg, attr = self.default_colors

        if context.reset:
            return self.default_colors

        if context.in_browser:
            if context.error:
                fg = yellow
                bg = 52

            if context.media:
                fg = 182 if context.image else magenta

            if context.video:
                fg = 110
            if context.audio:
                fg = 116
            if context.document:
                fg = 44
            if context.container:
                fg = 174

            if context.directory:
                attr |= bold
                # fg = blue
            elif context.executable and not any((context.media, context.container, context.fifo, context.socket)):
                fg = 114

            if context.fifo or context.device or context.socket:
                fg = 107

            if context.link:
                fg = 180 if context.good else 128

            if context.tag_marker and not context.selected:
                fg = red

            if not context.selected and (context.cut or context.copied):
                attr = reverse
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = yellow

            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

            if context.inactive_pane:
                fg = 242

            if context.bad:
                bg = 235

            if context.selected:
                fg = 231
                bg = 236

        elif context.in_titlebar:
            if context.hostname:
                fg = 174 if context.bad else 180
            elif context.tab:
                bg = 236
                if context.good:
                    bg = 244
            elif context.link:
                fg = 180

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 108
                elif context.bad:
                    fg = 174
            if context.marked:
                attr |= bold | reverse
                fg = yellow
                fg += BRIGHT
            if context.frozen:
                attr |= bold | reverse
                fg = cyan
                fg += BRIGHT
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
                    fg += BRIGHT
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = blue
                attr &= ~bold
            if context.vcscommit:
                fg = yellow
                attr &= ~bold
            if context.vcsdate:
                fg = cyan
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = magenta
            elif context.vcsuntracked:
                fg = cyan
            elif context.vcschanged:
                fg = red
            elif context.vcsunknown:
                fg = red
            elif context.vcsstaged:
                fg = green
            elif context.vcssync:
                fg = green
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync or context.vcsnone:
                fg = green
            elif context.vcsbehind:
                fg = red
            elif context.vcsahead:
                fg = blue
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr
