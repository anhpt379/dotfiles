from ranger.api.commands import Command

class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import subprocess
        import os.path

        command="fd --no-ignore --hidden --exclude '.git' . | fzf"

        # if self.quantifier:
        #     # match only directories
        #     command="fd --hidden --type d --exclude '.git' . | fzf"
        # else:
        #     # match files and directories
        #     command="fd --hidden --exclude '.git' . | fzf"

        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()

        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class add_file(Command):
    def execute(self):
        import subprocess
        import os.path

        fname = self.arg(1)

        os.makedirs(os.path.dirname(fname))

        if os.path.exists(fname):
            os.utime(fname, None)
        else:
            open(fname, 'a').close()

        self.fm.select_file(fname)

    def tab(self, tabnum):
        return self._tab_directory_content()

