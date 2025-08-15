#!/usr/bin/env fish

# If not running interactively, don't do anything and return early
if not status is-interactive
    exit 0
end

if not set -q WORK_EMAIL
    if test -f ~/code/work/.gitconfig
        set -gx WORK_EMAIL (cat ~/code/work/.gitconfig | grep '@' | head -1 | awk '{ print $NF }')
    else
        echo "Error: No WORK_EMAIL detected!"
    end
end

set -gx COMPANY_NAME (echo $WORK_EMAIL | awk -F@ '{ print $NF }' | awk -F. '{ print $1 }')
set -gx COMPANY_NAME_LOWER (echo $COMPANY_NAME | tr A-Z a-z)
set -gx COMPANY_NAME_UPPER (echo $COMPANY_NAME | tr a-z A-Z)
set -gx COMPANY_NAME_CAPITALIZE (echo $COMPANY_NAME | sed 's/[^ ]*/\u&/g')
set -gx COMPANY_DOMAIN "$COMPANY_NAME_LOWER.com"

set -gx no_proxy localhost,.$COMPANY_DOMAIN

set -gx HOMEBREW_BUNDLE_FILE "~/.Brewfile"
set -gx GOPATH $HOME/.go

if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    fish_add_path /opt/homebrew/bin/
    fish_add_path /opt/homebrew/opt/grep/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
    fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
end

fish_add_path /usr/sbin
fish_add_path /usr/local/sbin
fish_add_path /opt/puppetlabs/bin
fish_add_path $HOME/.go/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $(python3 -m site --user-base)/bin

# https://github.com/high-moctane/mocword
set -gx MOCWORD_DATA $HOME/.config/nvim/dictionaries/mocword.sqlite

set -gx EDITOR nvim
set -gx KUBE_EDITOR vim

set -gx MANPAGER /usr/bin/less
set -gx PAGER /usr/bin/less
set -gx LESSEDIT 'nvimpager -p -- ?lm+%lm. %f'

set -gx PIP_ISOLATED 1

# Fix trackpad scrolling doesn't work in diff-so-fancy
# Need to remove the `X` flag from less options, but can't do it via .gitconfig,
# since git set the default to `FRX` if we don't set `LESS` environment variable
# https://github.com/so-fancy/diff-so-fancy/issues/246
# https://github.com/git/git/blob/v2.7.1/Documentation/config.txt#L646-L648
set -gx LESS '--LONG-PROMPT --RAW-CONTROL-CHARS'

# Fix fzf couldn't preview matches that end with `\`. This happens in fish
# only. Fzf uses the shell set in SHELL env to execute the preview command.
# https://github.com/junegunn/fzf/blob/0.25.0/src/util/util_unix.go#L13
set -gx SHELL /bin/bash

# Fix no colored output from `bk` when running in wezterm
set -gx FORCE_COLOR 1

set -gx FZF_DEFAULT_COMMAND \
    $(echo 'command fd
                --one-file-system
                --hidden
                --type f
                --color=never
                --exclude=".git"
                --exclude="*.jp*g"
                --exclude="*.png"
            ' | tr -d '\n')
set -gx FZF_DEFAULT_OPTS \
    $(echo '--pointer=" "
            --prompt="FZF> "
            --color=fg:#eeeeee,bg:-1,hl:#eeeeee
            --color=fg+:#FFCC66,bg+:#262626,hl+:#FFCC66
            --color=prompt:#f1f1f1,pointer:#f1f1f1
            --color=info:#696969,spinner:#696969
            --color=marker:#55CABE
            --color=spinner:108
            --ansi
            --cycle
            --no-multi
            --reverse
            --height=40%
            --preview-window=right,60%,border-sharp
            --info=inline-right
            --no-separator
            --scrollbar='▌▐'
            --scheme=path
            --bind=ctrl-/:toggle-preview
            --bind=ctrl-s:toggle-sort
            --bind=tab:accept,ctrl-j:ignore,ctrl-k:ignore
            --bind=change:first
            --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up
            ' | tr -d '\n')
set -gx FZF_PREVIEW_COMMAND 'preview {}'

# lf
set -gx LF_ICONS (
    sed ~/.config/lf/icons \
        -e '/^[ \t]*#/d'   \
        -e '/^[ \t]*$/d'   \
        -e 's/[ \t]\+/=/g' \
        -e 's/$//'         \
    | tr '\n' ':'
)

# Use this command to generate the LS_COLORS string:
#
#   $ vivid generate aodark
#
set -gx LS_COLORS 'sg=0:or=0;38;2;226;47;98;48;2;28;28;28:pi=0;38;2;28;28;28;48;2;40;201;255:mi=0;38;2;28;28;28;48;2;226;47;98:bd=0;38;2;60;200;180;48;2;51;51;51:ca=0:*~=0;38;2;102;102;102:fi=0:mh=0:ex=0;38;2;60;200;180:no=0:ow=0:do=0;38;2;28;28;28;48;2;185;84;225:di=1;38;2;40;201;255:tw=0:st=0:rs=0:ln=0;38;2;153;153;153:cd=0;38;2;185;84;225;48;2;51;51;51:su=0:so=0;38;2;28;28;28;48;2;185;84;225:*.t=0;38;2;220;223;228:*.m=0;38;2;220;223;228:*.h=0;38;2;220;223;228:*.a=1;38;2;214;177;82:*.c=0;38;2;220;223;228:*.r=0;38;2;220;223;228:*.o=0;38;2;102;102;102:*.z=0;38;2;60;200;180:*.p=0;38;2;220;223;228:*.d=0;38;2;220;223;228:*.hh=0;38;2;220;223;228:*.rb=0;38;2;220;223;228:*.xz=0;38;2;60;200;180:*.kt=0;38;2;220;223;228:*.bc=0;38;2;102;102;102:*.7z=0;38;2;60;200;180:*.js=0;38;2;220;223;228:*.py=0;38;2;220;223;228:*.cc=0;38;2;220;223;228:*.el=0;38;2;220;223;228:*.di=0;38;2;220;223;228:*.md=0;38;2;214;177;82:*.ex=0;38;2;220;223;228:*css=0;38;2;220;223;228:*.nb=0;38;2;220;223;228:*.hi=0;38;2;102;102;102:*.pm=0;38;2;220;223;228:*.go=0;38;2;220;223;228:*.td=0;38;2;220;223;228:*.ts=0;38;2;220;223;228:*.bz=0;38;2;60;200;180:*.rm=0;38;2;185;84;225:*.fs=0;38;2;220;223;228:*.gv=0;38;2;220;223;228:*.mn=0;38;2;220;223;228:*.vb=0;38;2;220;223;228:*.so=1;38;2;214;177;82:*.hs=0;38;2;220;223;228:*.cs=0;38;2;220;223;228:*.ui=0;38;2;220;223;228:*.pp=0;38;2;220;223;228:*.ll=0;38;2;220;223;228:*.jl=0;38;2;220;223;228:*.sh=0;38;2;220;223;228:*.pl=0;38;2;220;223;228:*.ko=1;38;2;214;177;82:*.rs=0;38;2;220;223;228:*.as=0;38;2;220;223;228:*.lo=0;38;2;102;102;102:*.ps=0;38;2;226;47;98:*.ml=0;38;2;220;223;228:*.gz=0;38;2;60;200;180:*.wv=0;38;2;185;84;225:*.cp=0;38;2;220;223;228:*.la=0;38;2;102;102;102:*.cr=0;38;2;220;223;228:*.pps=0;38;2;226;47;98:*.kex=0;38;2;226;47;98:*.mp4=0;38;2;185;84;225:*.deb=0;38;2;60;200;180:*.bbl=0;38;2;102;102;102:*.cgi=0;38;2;220;223;228:*.pdf=0;38;2;226;47;98:*.rst=0;38;2;214;177;82:*.sxw=0;38;2;226;47;98:*.elm=0;38;2;220;223;228:*TODO=1:*.cxx=0;38;2;220;223;228:*.cpp=0;38;2;220;223;228:*.asa=0;38;2;220;223;228:*.yml=0;38;2;220;223;228:*.svg=0;38;2;185;84;225:*.ltx=0;38;2;220;223;228:*.epp=0;38;2;220;223;228:*.def=0;38;2;220;223;228:*.mpg=0;38;2;185;84;225:*.vcd=0;38;2;60;200;180:*.bin=0;38;2;60;200;180:*.pgm=0;38;2;185;84;225:*.com=1;38;2;214;177;82:*.hxx=0;38;2;220;223;228:*.ilg=0;38;2;102;102;102:*.idx=0;38;2;102;102;102:*.sty=0;38;2;102;102;102:*.xcf=0;38;2;185;84;225:*.odt=0;38;2;226;47;98:*.pkg=0;38;2;60;200;180:*.wmv=0;38;2;185;84;225:*.ods=0;38;2;226;47;98:*.wav=0;38;2;185;84;225:*.bib=0;38;2;220;223;228:*.bsh=0;38;2;220;223;228:*.bag=0;38;2;60;200;180:*.iso=0;38;2;60;200;180:*.zst=0;38;2;60;200;180:*.log=0;38;2;102;102;102:*.mli=0;38;2;220;223;228:*.fon=0;38;2;185;84;225:*.tcl=0;38;2;220;223;228:*.psd=0;38;2;185;84;225:*.odp=0;38;2;226;47;98:*.gif=0;38;2;185;84;225:*.aif=0;38;2;185;84;225:*.pyc=0;38;2;102;102;102:*.m4a=0;38;2;185;84;225:*.ttf=0;38;2;185;84;225:*.tsx=0;38;2;220;223;228:*.mid=0;38;2;185;84;225:*.bat=1;38;2;214;177;82:*.eps=0;38;2;185;84;225:*.m4v=0;38;2;185;84;225:*.dpr=0;38;2;220;223;228:*.pbm=0;38;2;185;84;225:*.sql=0;38;2;220;223;228:*.otf=0;38;2;185;84;225:*.cfg=0;38;2;220;223;228:*.mkv=0;38;2;185;84;225:*.ini=0;38;2;220;223;228:*.apk=0;38;2;60;200;180:*.txt=0;38;2;214;177;82:*.bz2=0;38;2;60;200;180:*.pod=0;38;2;220;223;228:*.xmp=0;38;2;220;223;228:*.tex=0;38;2;220;223;228:*.exs=0;38;2;220;223;228:*.avi=0;38;2;185;84;225:*.tar=0;38;2;60;200;180:*.swf=0;38;2;185;84;225:*.ics=0;38;2;226;47;98:*.mir=0;38;2;220;223;228:*.ico=0;38;2;185;84;225:*.fls=0;38;2;102;102;102:*.blg=0;38;2;102;102;102:*.ipp=0;38;2;220;223;228:*.dll=1;38;2;214;177;82:*.ppm=0;38;2;185;84;225:*.xml=0;38;2;214;177;82:*.fsi=0;38;2;220;223;228:*.git=0;38;2;102;102;102:*.htm=0;38;2;214;177;82:*.bst=0;38;2;220;223;228:*.exe=1;38;2;214;177;82:*.tgz=0;38;2;60;200;180:*.flv=0;38;2;185;84;225:*.bmp=0;38;2;185;84;225:*.inl=0;38;2;220;223;228:*.sbt=0;38;2;220;223;228:*.c++=0;38;2;220;223;228:*.pas=0;38;2;220;223;228:*.bak=0;38;2;102;102;102:*.sxi=0;38;2;226;47;98:*.mov=0;38;2;185;84;225:*.rar=0;38;2;60;200;180:*.kts=0;38;2;220;223;228:*.ogg=0;38;2;185;84;225:*.mp3=0;38;2;185;84;225:*.pro=0;38;2;220;223;228:*.csx=0;38;2;220;223;228:*.ind=0;38;2;102;102;102:*.gvy=0;38;2;220;223;228:*.tif=0;38;2;185;84;225:*.awk=0;38;2;220;223;228:*.erl=0;38;2;220;223;228:*.swp=0;38;2;102;102;102:*.tbz=0;38;2;60;200;180:*.doc=0;38;2;226;47;98:*.pid=0;38;2;102;102;102:*.dox=0;38;2;220;223;228:*.jpg=0;38;2;185;84;225:*hgrc=0;38;2;220;223;228:*.bcf=0;38;2;102;102;102:*.inc=0;38;2;220;223;228:*.arj=0;38;2;60;200;180:*.jar=0;38;2;60;200;180:*.dot=0;38;2;220;223;228:*.wma=0;38;2;185;84;225:*.hpp=0;38;2;220;223;228:*.zip=0;38;2;60;200;180:*.fnt=0;38;2;185;84;225:*.pyo=0;38;2;102;102;102:*.out=0;38;2;102;102;102:*.aux=0;38;2;102;102;102:*.xls=0;38;2;226;47;98:*.img=0;38;2;60;200;180:*.nix=0;38;2;220;223;228:*.php=0;38;2;220;223;228:*.fsx=0;38;2;220;223;228:*.vob=0;38;2;185;84;225:*.tmp=0;38;2;102;102;102:*.vim=0;38;2;220;223;228:*.csv=0;38;2;214;177;82:*.zsh=0;38;2;220;223;228:*.xlr=0;38;2;226;47;98:*.pyd=0;38;2;102;102;102:*.rpm=0;38;2;60;200;180:*.png=0;38;2;185;84;225:*.toc=0;38;2;102;102;102:*.rtf=0;38;2;226;47;98:*.ps1=0;38;2;220;223;228:*.ppt=0;38;2;226;47;98:*.clj=0;38;2;220;223;228:*.dmg=0;38;2;60;200;180:*.h++=0;38;2;220;223;228:*.tml=0;38;2;220;223;228:*.htc=0;38;2;220;223;228:*.lua=0;38;2;220;223;228:*.pptx=0;38;2;226;47;98:*.dart=0;38;2;220;223;228:*.tiff=0;38;2;185;84;225:*.json=0;38;2;220;223;228:*.purs=0;38;2;220;223;228:*.toml=0;38;2;220;223;228:*.java=0;38;2;220;223;228:*.lock=0;38;2;102;102;102:*.psm1=0;38;2;220;223;228:*.make=0;38;2;220;223;228:*.html=0;38;2;214;177;82:*.lisp=0;38;2;220;223;228:*.yaml=0;38;2;220;223;228:*.rlib=0;38;2;102;102;102:*.psd1=0;38;2;220;223;228:*.conf=0;38;2;220;223;228:*.fish=0;38;2;220;223;228:*.diff=0;38;2;220;223;228:*.docx=0;38;2;226;47;98:*.orig=0;38;2;102;102;102:*.tbz2=0;38;2;60;200;180:*.hgrc=0;38;2;220;223;228:*.bash=0;38;2;220;223;228:*.mpeg=0;38;2;185;84;225:*.jpeg=0;38;2;185;84;225:*.less=0;38;2;220;223;228:*.h264=0;38;2;185;84;225:*.opus=0;38;2;185;84;225:*.webm=0;38;2;185;84;225:*.epub=0;38;2;226;47;98:*.flac=0;38;2;185;84;225:*.xlsx=0;38;2;226;47;98:*.shtml=0;38;2;214;177;82:*.cabal=0;38;2;220;223;228:*.class=0;38;2;102;102;102:*.dyn_o=0;38;2;102;102;102:*.cache=0;38;2;102;102;102:*passwd=0;38;2;220;223;228:*.cmake=0;38;2;220;223;228:*.xhtml=0;38;2;214;177;82:*.scala=0;38;2;220;223;228:*.patch=0;38;2;220;223;228:*shadow=0;38;2;220;223;228:*.ipynb=0;38;2;220;223;228:*.mdown=0;38;2;214;177;82:*README=1;38;2;95;174;77:*.toast=0;38;2;60;200;180:*.swift=0;38;2;220;223;228:*.config=0;38;2;220;223;228:*.groovy=0;38;2;220;223;228:*LICENSE=0;38;2;153;153;153:*INSTALL=1;38;2;95;174;77:*TODO.md=1:*.gradle=0;38;2;220;223;228:*.ignore=0;38;2;220;223;228:*.dyn_hi=0;38;2;102;102;102:*.flake8=0;38;2;220;223;228:*COPYING=0;38;2;153;153;153:*.matlab=0;38;2;220;223;228:*Makefile=0;38;2;220;223;228:*TODO.txt=1:*Doxyfile=0;38;2;220;223;228:*.desktop=0;38;2;220;223;228:*setup.py=0;38;2;220;223;228:*.gemspec=0;38;2;220;223;228:*.cmake.in=0;38;2;220;223;228:*COPYRIGHT=0;38;2;153;153;153:*.fdignore=0;38;2;220;223;228:*configure=0;38;2;220;223;228:*.DS_Store=0;38;2;102;102;102:*.markdown=0;38;2;214;177;82:*.rgignore=0;38;2;220;223;228:*.kdevelop=0;38;2;220;223;228:*README.md=1;38;2;95;174;77:*README.txt=1;38;2;95;174;77:*.gitignore=0;38;2;220;223;228:*SConstruct=0;38;2;220;223;228:*.scons_opt=0;38;2;102;102;102:*CODEOWNERS=0;38;2;220;223;228:*.gitconfig=0;38;2;220;223;228:*SConscript=0;38;2;220;223;228:*Dockerfile=0;38;2;220;223;228:*INSTALL.md=1;38;2;95;174;77:*.localized=0;38;2;102;102;102:*.travis.yml=0;38;2;214;177;82:*.gitmodules=0;38;2;220;223;228:*Makefile.am=0;38;2;220;223;228:*Makefile.in=0;38;2;102;102;102:*LICENSE-MIT=0;38;2;153;153;153:*.synctex.gz=0;38;2;102;102;102:*MANIFEST.in=0;38;2;220;223;228:*INSTALL.txt=1;38;2;95;174;77:*configure.ac=0;38;2;220;223;228:*appveyor.yml=0;38;2;214;177;82:*.applescript=0;38;2;220;223;228:*CONTRIBUTORS=1;38;2;95;174;77:*.fdb_latexmk=0;38;2;102;102;102:*.clang-format=0;38;2;220;223;228:*LICENSE-APACHE=0;38;2;153;153;153:*.gitattributes=0;38;2;220;223;228:*CMakeLists.txt=0;38;2;220;223;228:*CMakeCache.txt=0;38;2;102;102;102:*CONTRIBUTORS.md=1;38;2;95;174;77:*requirements.txt=0;38;2;220;223;228:*CONTRIBUTORS.txt=1;38;2;95;174;77:*.sconsign.dblite=0;38;2;102;102;102:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102'

# Fix can't see `null` in jq output (also changed `false` to red, `true` to
# green)
set -gx JQ_COLORS '36:31:32:0;39:0;32:1;39:1;39'

# Hide fish greeting
set fish_greeting

# Use default fish key bindings
set -g fish_key_bindings fish_default_key_bindings

# Scroll screen up to put the prompt at middle of the screen on the second ENTER
bind \n magic_enter
bind \r magic_enter

# CTRL-H/L to act as HOME/END key, similar to non-terminal apps
bind ctrl-h beginning-of-line
bind ctrl-l end-of-line

source ~/.config/fish/abbr.fish
source ~/.config/fish/themes/aodark.fish

if string match -q -- Darwin (uname)
    set -g TERM xterm-256color
else if string match -e -q -- fedora (hostname)
    source ~/code/work/git-subrepo/.fish.rc

    # Auto start tmux when ssh to the Lima VM
    if test -z "$TMUX"
        mkdir -p ~/.ssh
        ln -sf "$SSH_TTY" ~/.ssh/ssh_tty

        tmux -u attach || tmux -u new
    end
else
    # Update the default email for git
    if set -q WORK_EMAIL; and not grep -q $COMPANY_DOMAIN ~/.gitconfig
        git config --global user.email $WORK_EMAIL
    end

    # Fix postgres user (`sudo -u postgres psql`) couldn't read the ~/.psqlrc
    if not test -f /tmp/.psqlrc
        cp -f ~/.psqlrc /tmp/
    end
    set -gx PSQLRC /tmp/.psqlrc

    # Tell nvimpager where the nvim is
    set -gx NVIM ~/.local/bin/nvim

    # Fix <C-c> doesn't work in remote fish
    bind \cc 'commandline ""'

    # Fix git-deploy umask complaining
    umask 0002
end

function preexec_scroll_up --on-event fish_preexec
    scroll_up
end

function postexec_bell_duration --on-event fish_postexec
    tput bel

    set -l duration_seconds $(math round $CMD_DURATION / 1000)
    if test $duration_seconds -ge 2
        set_color yellow
        echo "Executed in $(humantime $CMD_DURATION)"
        set -g CMD_DURATION 0
        set_color white
    end
end

if type -q zoxide
    zoxide init --cmd=j --hook=pwd fish | source
    zoxide init --cmd=cd --hook=pwd fish | source
end
