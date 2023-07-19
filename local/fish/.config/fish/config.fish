#!/usr/bin/env fish

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

    fish_add_path /opt/homebrew/opt/grep/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
    fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
end

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

set -U  Z_CMD 'j'
set -gx Z_DATA "$HOME/.local/share/z/data"
set -gx Z_EXCLUDE '.*/code/work/puppet$'
set -gx Z_OWNER (logname)

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
            --color=fg:#DCDFE4,bg:-1,hl:#DCDFE4
            --color=fg+:#FFCC66,bg+:#262626,hl+:#FFCC66
            --color=prompt:#f1f1f1,pointer:#f1f1f1
            --color=info:#696969,spinner:#696969
            --color=marker:#55CABE
            --color=spinner:108
            --cycle
            --no-multi
            --reverse
            --height=40%
            --preview-window=right:60%
            --info=inline-right
            --bind=ctrl-/:toggle-preview
            --bind=ctrl-s:toggle-sort
            --bind=tab:accept,ctrl-j:ignore,ctrl-k:ignore
            --bind=change:first
            --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up
            --bind=ctrl-h:backward-kill-word
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
set -gx LS_COLORS "bd=0;38;2;60;200;180;48;2;51;51;51:so=0;38;2;0;0;0;48;2;185;84;225:no=0:or=0;38;2;226;47;98;48;2;0;0;0:*~=0;38;2;102;102;102:mh=0:rs=0:pi=0;38;2;0;0;0;48;2;40;201;255:ex=0;38;2;60;200;180:fi=0:st=0:ca=0:di=1;38;2;40;201;255:ow=0:do=0;38;2;0;0;0;48;2;185;84;225:tw=0:ln=0;38;2;153;153;153:mi=0;38;2;0;0;0;48;2;226;47;98:cd=0;38;2;185;84;225;48;2;51;51;51:sg=0:su=0:*.t=0;38;2;220;223;228:*.a=1;38;2;214;177;82:*.m=0;38;2;220;223;228:*.c=0;38;2;220;223;228:*.d=0;38;2;220;223;228:*.h=0;38;2;220;223;228:*.r=0;38;2;220;223;228:*.p=0;38;2;220;223;228:*.z=0;38;2;60;200;180:*.o=0;38;2;102;102;102:*.la=0;38;2;102;102;102:*.go=0;38;2;220;223;228:*.wv=0;38;2;185;84;225:*.ts=0;38;2;220;223;228:*.fs=0;38;2;220;223;228:*.hi=0;38;2;102;102;102:*.rb=0;38;2;220;223;228:*.vb=0;38;2;220;223;228:*.lo=0;38;2;102;102;102:*.cc=0;38;2;220;223;228:*.pp=0;38;2;220;223;228:*.as=0;38;2;220;223;228:*.di=0;38;2;220;223;228:*.bc=0;38;2;102;102;102:*.hs=0;38;2;220;223;228:*.rm=0;38;2;185;84;225:*.cp=0;38;2;220;223;228:*.py=0;38;2;220;223;228:*.nb=0;38;2;220;223;228:*css=0;38;2;220;223;228:*.ex=0;38;2;220;223;228:*.ml=0;38;2;220;223;228:*.xz=0;38;2;60;200;180:*.td=0;38;2;220;223;228:*.ll=0;38;2;220;223;228:*.pm=0;38;2;220;223;228:*.pl=0;38;2;220;223;228:*.so=1;38;2;214;177;82:*.md=0;38;2;214;177;82:*.ko=1;38;2;214;177;82:*.cs=0;38;2;220;223;228:*.cr=0;38;2;220;223;228:*.rs=0;38;2;220;223;228:*.ui=0;38;2;220;223;228:*.mn=0;38;2;220;223;228:*.js=0;38;2;220;223;228:*.sh=0;38;2;220;223;228:*.kt=0;38;2;220;223;228:*.gz=0;38;2;60;200;180:*.hh=0;38;2;220;223;228:*.bz=0;38;2;60;200;180:*.gv=0;38;2;220;223;228:*.el=0;38;2;220;223;228:*.jl=0;38;2;220;223;228:*.7z=0;38;2;60;200;180:*.ps=0;38;2;226;47;98:*.bmp=0;38;2;185;84;225:*.csv=0;38;2;214;177;82:*.bib=0;38;2;220;223;228:*.pps=0;38;2;226;47;98:*.tsx=0;38;2;220;223;228:*.zip=0;38;2;60;200;180:*.htm=0;38;2;214;177;82:*.ico=0;38;2;185;84;225:*.odt=0;38;2;226;47;98:*.ipp=0;38;2;220;223;228:*.jpg=0;38;2;185;84;225:*.psd=0;38;2;185;84;225:*.otf=0;38;2;185;84;225:*.asa=0;38;2;220;223;228:*.arj=0;38;2;60;200;180:*.mov=0;38;2;185;84;225:*.ogg=0;38;2;185;84;225:*.mkv=0;38;2;185;84;225:*.ini=0;38;2;220;223;228:*.mli=0;38;2;220;223;228:*.pkg=0;38;2;60;200;180:*.dot=0;38;2;220;223;228:*.eps=0;38;2;185;84;225:*.inl=0;38;2;220;223;228:*.epp=0;38;2;220;223;228:*.rst=0;38;2;214;177;82:*.cxx=0;38;2;220;223;228:*.xml=0;38;2;214;177;82:*.m4a=0;38;2;185;84;225:*.xls=0;38;2;226;47;98:*.swf=0;38;2;185;84;225:*.blg=0;38;2;102;102;102:*.tml=0;38;2;220;223;228:*.mid=0;38;2;185;84;225:*.rar=0;38;2;60;200;180:*.kts=0;38;2;220;223;228:*.ppm=0;38;2;185;84;225:*.hpp=0;38;2;220;223;228:*.ods=0;38;2;226;47;98:*.h++=0;38;2;220;223;228:*.tmp=0;38;2;102;102;102:*.tex=0;38;2;220;223;228:*.fon=0;38;2;185;84;225:*.dpr=0;38;2;220;223;228:*.wma=0;38;2;185;84;225:*.txt=0;38;2;214;177;82:*.aux=0;38;2;102;102;102:*.mp3=0;38;2;185;84;225:*.exs=0;38;2;220;223;228:*.cpp=0;38;2;220;223;228:*.ics=0;38;2;226;47;98:*.vcd=0;38;2;60;200;180:*.tif=0;38;2;185;84;225:*.toc=0;38;2;102;102;102:*.sxw=0;38;2;226;47;98:*.vob=0;38;2;185;84;225:*.pyo=0;38;2;102;102;102:*.m4v=0;38;2;185;84;225:*.avi=0;38;2;185;84;225:*.xlr=0;38;2;226;47;98:*.c++=0;38;2;220;223;228:*.fsi=0;38;2;220;223;228:*.yml=0;38;2;220;223;228:*.kex=0;38;2;226;47;98:*.csx=0;38;2;220;223;228:*.ttf=0;38;2;185;84;225:*.wav=0;38;2;185;84;225:*.com=1;38;2;214;177;82:*.cfg=0;38;2;220;223;228:*.dmg=0;38;2;60;200;180:*.pyd=0;38;2;102;102;102:*.aif=0;38;2;185;84;225:*.iso=0;38;2;60;200;180:*.mp4=0;38;2;185;84;225:*.doc=0;38;2;226;47;98:*.sql=0;38;2;220;223;228:*.ind=0;38;2;102;102;102:*.pro=0;38;2;220;223;228:*.swp=0;38;2;102;102;102:*.pbm=0;38;2;185;84;225:*.log=0;38;2;102;102;102:*.ilg=0;38;2;102;102;102:*.jar=0;38;2;60;200;180:*.ppt=0;38;2;226;47;98:*TODO=1:*.bst=0;38;2;220;223;228:*.gif=0;38;2;185;84;225:*.dox=0;38;2;220;223;228:*.tbz=0;38;2;60;200;180:*.sty=0;38;2;102;102;102:*.git=0;38;2;102;102;102:*.png=0;38;2;185;84;225:*.rtf=0;38;2;226;47;98:*.tcl=0;38;2;220;223;228:*.ps1=0;38;2;220;223;228:*.elm=0;38;2;220;223;228:*.out=0;38;2;102;102;102:*.pyc=0;38;2;102;102;102:*.dll=1;38;2;214;177;82:*.sxi=0;38;2;226;47;98:*.inc=0;38;2;220;223;228:*.php=0;38;2;220;223;228:*.pgm=0;38;2;185;84;225:*.hxx=0;38;2;220;223;228:*.rpm=0;38;2;60;200;180:*.exe=1;38;2;214;177;82:*.bcf=0;38;2;102;102;102:*.bz2=0;38;2;60;200;180:*.awk=0;38;2;220;223;228:*.pod=0;38;2;220;223;228:*.bbl=0;38;2;102;102;102:*.sbt=0;38;2;220;223;228:*.deb=0;38;2;60;200;180:*.nix=0;38;2;220;223;228:*.erl=0;38;2;220;223;228:*.bag=0;38;2;60;200;180:*.pid=0;38;2;102;102;102:*.ltx=0;38;2;220;223;228:*.htc=0;38;2;220;223;228:*.bsh=0;38;2;220;223;228:*.bak=0;38;2;102;102;102:*.xmp=0;38;2;220;223;228:*.apk=0;38;2;60;200;180:*.flv=0;38;2;185;84;225:*.cgi=0;38;2;220;223;228:*.zst=0;38;2;60;200;180:*.gvy=0;38;2;220;223;228:*.clj=0;38;2;220;223;228:*.fls=0;38;2;102;102;102:*.wmv=0;38;2;185;84;225:*.tgz=0;38;2;60;200;180:*.odp=0;38;2;226;47;98:*.vim=0;38;2;220;223;228:*.bat=1;38;2;214;177;82:*.def=0;38;2;220;223;228:*.fnt=0;38;2;185;84;225:*.tar=0;38;2;60;200;180:*.pas=0;38;2;220;223;228:*.zsh=0;38;2;220;223;228:*.xcf=0;38;2;185;84;225:*.img=0;38;2;60;200;180:*.idx=0;38;2;102;102;102:*.fsx=0;38;2;220;223;228:*.mir=0;38;2;220;223;228:*.lua=0;38;2;220;223;228:*.svg=0;38;2;185;84;225:*hgrc=0;38;2;220;223;228:*.mpg=0;38;2;185;84;225:*.bin=0;38;2;60;200;180:*.pdf=0;38;2;226;47;98:*.jpeg=0;38;2;185;84;225:*.diff=0;38;2;220;223;228:*.h264=0;38;2;185;84;225:*.psm1=0;38;2;220;223;228:*.webm=0;38;2;185;84;225:*.json=0;38;2;220;223;228:*.purs=0;38;2;220;223;228:*.epub=0;38;2;226;47;98:*.html=0;38;2;214;177;82:*.psd1=0;38;2;220;223;228:*.tiff=0;38;2;185;84;225:*.pptx=0;38;2;226;47;98:*.docx=0;38;2;226;47;98:*.lock=0;38;2;102;102;102:*.make=0;38;2;220;223;228:*.tbz2=0;38;2;60;200;180:*.xlsx=0;38;2;226;47;98:*.fish=0;38;2;220;223;228:*.conf=0;38;2;220;223;228:*.rlib=0;38;2;102;102;102:*.opus=0;38;2;185;84;225:*.flac=0;38;2;185;84;225:*.orig=0;38;2;102;102;102:*.bash=0;38;2;220;223;228:*.mpeg=0;38;2;185;84;225:*.less=0;38;2;220;223;228:*.java=0;38;2;220;223;228:*.yaml=0;38;2;220;223;228:*.lisp=0;38;2;220;223;228:*.toml=0;38;2;220;223;228:*.hgrc=0;38;2;220;223;228:*.dart=0;38;2;220;223;228:*.xhtml=0;38;2;214;177;82:*.cmake=0;38;2;220;223;228:*.toast=0;38;2;60;200;180:*.patch=0;38;2;220;223;228:*passwd=0;38;2;220;223;228:*.swift=0;38;2;220;223;228:*.dyn_o=0;38;2;102;102;102:*.cabal=0;38;2;220;223;228:*shadow=0;38;2;220;223;228:*.scala=0;38;2;220;223;228:*.class=0;38;2;102;102;102:*.mdown=0;38;2;214;177;82:*.shtml=0;38;2;214;177;82:*.cache=0;38;2;102;102;102:*README=1;38;2;95;174;77:*.ipynb=0;38;2;220;223;228:*.gradle=0;38;2;220;223;228:*TODO.md=1:*.matlab=0;38;2;220;223;228:*.groovy=0;38;2;220;223;228:*.flake8=0;38;2;220;223;228:*.dyn_hi=0;38;2;102;102;102:*COPYING=0;38;2;153;153;153:*.ignore=0;38;2;220;223;228:*LICENSE=0;38;2;153;153;153:*.config=0;38;2;220;223;228:*INSTALL=1;38;2;95;174;77:*.desktop=0;38;2;220;223;228:*setup.py=0;38;2;220;223;228:*Makefile=0;38;2;220;223;228:*.gemspec=0;38;2;220;223;228:*Doxyfile=0;38;2;220;223;228:*TODO.txt=1:*README.md=1;38;2;95;174;77:*.cmake.in=0;38;2;220;223;228:*.markdown=0;38;2;214;177;82:*.kdevelop=0;38;2;220;223;228:*.rgignore=0;38;2;220;223;228:*COPYRIGHT=0;38;2;153;153;153:*.fdignore=0;38;2;220;223;228:*.DS_Store=0;38;2;102;102;102:*configure=0;38;2;220;223;228:*CODEOWNERS=0;38;2;220;223;228:*.localized=0;38;2;102;102;102:*SConscript=0;38;2;220;223;228:*SConstruct=0;38;2;220;223;228:*.gitconfig=0;38;2;220;223;228:*.gitignore=0;38;2;220;223;228:*Dockerfile=0;38;2;220;223;228:*.scons_opt=0;38;2;102;102;102:*INSTALL.md=1;38;2;95;174;77:*README.txt=1;38;2;95;174;77:*LICENSE-MIT=0;38;2;153;153;153:*.synctex.gz=0;38;2;102;102;102:*Makefile.am=0;38;2;220;223;228:*.gitmodules=0;38;2;220;223;228:*.travis.yml=0;38;2;214;177;82:*Makefile.in=0;38;2;102;102;102:*INSTALL.txt=1;38;2;95;174;77:*MANIFEST.in=0;38;2;220;223;228:*appveyor.yml=0;38;2;214;177;82:*CONTRIBUTORS=1;38;2;95;174;77:*.applescript=0;38;2;220;223;228:*configure.ac=0;38;2;220;223;228:*.fdb_latexmk=0;38;2;102;102;102:*.clang-format=0;38;2;220;223;228:*CMakeLists.txt=0;38;2;220;223;228:*.gitattributes=0;38;2;220;223;228:*CMakeCache.txt=0;38;2;102;102;102:*LICENSE-APACHE=0;38;2;153;153;153:*CONTRIBUTORS.md=1;38;2;95;174;77:*.sconsign.dblite=0;38;2;102;102;102:*requirements.txt=0;38;2;220;223;228:*CONTRIBUTORS.txt=1;38;2;95;174;77:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102"

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

# Esc to enter tmux copy mode
bind \e 'tmux copy-mode -e'

source ~/.config/fish/abbr.fish
source ~/.config/fish/themes/aodark.fish

if begin
        not string match -q -- Darwin (uname)
        and not string match -e -q -- fedora (hostname)
    end

    function psql
        cp ~/.psqlrc /tmp/
        sudo -u postgres bash -c "PSQLRC=/tmp/.psqlrc psql $argv[1]"
    end

    # Update the default email for git
    if set -q WORK_EMAIL; and not grep -q $COMPANY_DOMAIN ~/.gitconfig
        git config --global user.email $WORK_EMAIL
    end

    # Tell nvimpager where the nvim is
    set -gx NVIM ~/.local/bin/nvim

    # Fix `exa -l` complaining about timezone:
    #
    #   Unable to determine time zone: No such file or directory (os error 2)
    #
    set --erase TZ

    # Fix <C-c> doesn't work in remote fish
    bind \cc 'commandline ""'

    # Fix git-deploy umask complaining
    umask 0002
else if string match -e -q -- fedora (hostname)
    # Auto start tmux when ssh to the Lima VM
    if test -z "$TMUX"
        tmux -u attach -t panh || tmux -u new -s panh
    end
end

function preexec_scroll_up --on-event fish_preexec
    scroll_up
end

