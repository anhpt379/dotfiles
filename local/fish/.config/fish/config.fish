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
fish_add_path $HOME/.local/bin/nvim-appimage/squashfs-root/usr/bin/
fish_add_path $HOME/.local/bin

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

set -gx Z_DATA "$HOME/.local/share/z/data"

set -gx FZF_DEFAULT_COMMAND 'command fd
    --one-file-system
    --hidden
    --type f
    --color=never
    --exclude=".git"
    --exclude="*.jp*g"
    --exclude="*.png"
'
set -gx FZF_DEFAULT_OPTS '
    --pointer=" "
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
    --bind=ctrl-/:toggle-preview
    --bind=ctrl-s:toggle-sort
    --bind=tab:accept,ctrl-j:ignore,ctrl-k:ignore
    --bind=change:first
    --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up
    --bind=ctrl-h:backward-kill-word
'
set -gx FZF_PREVIEW_COMMAND 'fzf_preview {}'

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
set -gx LS_COLORS "no=0:cd=0;38;2;185;84;225;48;2;51;51;51:rs=0:tw=0:st=0:di=1;38;2;40;201;255:*~=0;38;2;102;102;102:do=0;38;2;0;0;0;48;2;185;84;225:mh=0:ca=0:fi=0:so=0;38;2;0;0;0;48;2;185;84;225:sg=0:bd=0;38;2;60;200;180;48;2;51;51;51:ex=0;38;2;60;200;180:mi=0;38;2;0;0;0;48;2;226;47;98:pi=0;38;2;0;0;0;48;2;40;201;255:ow=0:ln=0;38;2;153;153;153:su=0:or=0;38;2;0;0;0;48;2;226;47;98:*.a=1;38;2;214;177;82:*.c=0;38;2;220;223;228:*.t=0;38;2;220;223;228:*.r=0;38;2;220;223;228:*.h=0;38;2;220;223;228:*.d=0;38;2;220;223;228:*.o=0;38;2;102;102;102:*.p=0;38;2;220;223;228:*.z=4;38;2;60;200;180:*.m=0;38;2;220;223;228:*.pp=0;38;2;220;223;228:*.xz=4;38;2;60;200;180:*.vb=0;38;2;220;223;228:*.go=0;38;2;220;223;228:*.ts=0;38;2;220;223;228:*.bc=0;38;2;102;102;102:*.hs=0;38;2;220;223;228:*.7z=4;38;2;60;200;180:*.la=0;38;2;102;102;102:*.cs=0;38;2;220;223;228:*.cc=0;38;2;220;223;228:*.wv=0;38;2;185;84;225:*.hh=0;38;2;220;223;228:*.ll=0;38;2;220;223;228:*.cr=0;38;2;220;223;228:*.td=0;38;2;220;223;228:*.rs=0;38;2;220;223;228:*.hi=0;38;2;102;102;102:*.py=0;38;2;220;223;228:*.jl=0;38;2;220;223;228:*.fs=0;38;2;220;223;228:*.rb=0;38;2;220;223;228:*.bz=4;38;2;60;200;180:*.ps=0;38;2;226;47;98:*.gz=4;38;2;60;200;180:*.ui=0;38;2;220;223;228:*.md=0;38;2;214;177;82:*.nb=0;38;2;220;223;228:*.js=0;38;2;220;223;228:*.ml=0;38;2;220;223;228:*.sh=0;38;2;220;223;228:*.cp=0;38;2;220;223;228:*.ex=0;38;2;220;223;228:*.el=0;38;2;220;223;228:*.as=0;38;2;220;223;228:*.kt=0;38;2;220;223;228:*.pl=0;38;2;220;223;228:*.rm=0;38;2;185;84;225:*.mn=0;38;2;220;223;228:*.pm=0;38;2;220;223;228:*.gv=0;38;2;220;223;228:*.lo=0;38;2;102;102;102:*.di=0;38;2;220;223;228:*.so=1;38;2;214;177;82:*.ko=1;38;2;214;177;82:*css=0;38;2;220;223;228:*.sql=0;38;2;220;223;228:*.jar=4;38;2;60;200;180:*.mpg=0;38;2;185;84;225:*.cpp=0;38;2;220;223;228:*.ico=0;38;2;185;84;225:*.otf=0;38;2;185;84;225:*.odt=0;38;2;226;47;98:*.swf=0;38;2;185;84;225:*.epp=0;38;2;220;223;228:*.png=0;38;2;185;84;225:*.csx=0;38;2;220;223;228:*.psd=0;38;2;185;84;225:*.bsh=0;38;2;220;223;228:*.toc=0;38;2;102;102;102:*.clj=0;38;2;220;223;228:*.tsx=0;38;2;220;223;228:*.pyd=0;38;2;102;102;102:*.vcd=4;38;2;60;200;180:*.ind=0;38;2;102;102;102:*.arj=4;38;2;60;200;180:*.rtf=0;38;2;226;47;98:*.bak=0;38;2;102;102;102:*.sty=0;38;2;102;102;102:*.swp=0;38;2;102;102;102:*.txt=0;38;2;214;177;82:*.tml=0;38;2;220;223;228:*.ods=0;38;2;226;47;98:*.ppm=0;38;2;185;84;225:*.mov=0;38;2;185;84;225:*.idx=0;38;2;102;102;102:*.cfg=0;38;2;220;223;228:*.flv=0;38;2;185;84;225:*.csv=0;38;2;214;177;82:*.dox=0;38;2;220;223;228:*.c++=0;38;2;220;223;228:*.h++=0;38;2;220;223;228:*.sxi=0;38;2;226;47;98:*.zst=4;38;2;60;200;180:*.img=4;38;2;60;200;180:*.rst=0;38;2;214;177;82:*.tmp=0;38;2;102;102;102:*.xml=0;38;2;214;177;82:*.bz2=4;38;2;60;200;180:*.deb=4;38;2;60;200;180:*.pbm=0;38;2;185;84;225:*.fnt=0;38;2;185;84;225:*.xlr=0;38;2;226;47;98:*.jpg=0;38;2;185;84;225:*.wav=0;38;2;185;84;225:*.kex=0;38;2;226;47;98:*.mp4=0;38;2;185;84;225:*.bib=0;38;2;220;223;228:*.apk=4;38;2;60;200;180:*.wmv=0;38;2;185;84;225:*.inl=0;38;2;220;223;228:*.pod=0;38;2;220;223;228:*.htm=0;38;2;214;177;82:*.zip=4;38;2;60;200;180:*.elm=0;38;2;220;223;228:*.fls=0;38;2;102;102;102:*.ogg=0;38;2;185;84;225:*.wma=0;38;2;185;84;225:*.tif=0;38;2;185;84;225:*.bag=4;38;2;60;200;180:*.pid=0;38;2;102;102;102:*.doc=0;38;2;226;47;98:*.yml=0;38;2;220;223;228:*.dpr=0;38;2;220;223;228:*.lua=0;38;2;220;223;228:*.dll=1;38;2;214;177;82:*.def=0;38;2;220;223;228:*.bat=1;38;2;214;177;82:*.pdf=0;38;2;226;47;98:*.mir=0;38;2;220;223;228:*.sxw=0;38;2;226;47;98:*.xmp=0;38;2;220;223;228:*.blg=0;38;2;102;102;102:*.bin=4;38;2;60;200;180:*.pro=0;38;2;220;223;228:*.ini=0;38;2;220;223;228:*.kts=0;38;2;220;223;228:*.log=0;38;2;102;102;102:*.vim=0;38;2;220;223;228:*.ps1=0;38;2;220;223;228:*.php=0;38;2;220;223;228:*.cxx=0;38;2;220;223;228:*.pyo=0;38;2;102;102;102:*.awk=0;38;2;220;223;228:*TODO=1:*.odp=0;38;2;226;47;98:*.zsh=0;38;2;220;223;228:*.xls=0;38;2;226;47;98:*.rar=4;38;2;60;200;180:*.eps=0;38;2;185;84;225:*.aux=0;38;2;102;102;102:*.out=0;38;2;102;102;102:*.hxx=0;38;2;220;223;228:*.ilg=0;38;2;102;102;102:*.cgi=0;38;2;220;223;228:*.dot=0;38;2;220;223;228:*.m4v=0;38;2;185;84;225:*hgrc=0;38;2;220;223;228:*.aif=0;38;2;185;84;225:*.tex=0;38;2;220;223;228:*.fsx=0;38;2;220;223;228:*.ppt=0;38;2;226;47;98:*.com=1;38;2;214;177;82:*.pps=0;38;2;226;47;98:*.mid=0;38;2;185;84;225:*.bmp=0;38;2;185;84;225:*.fon=0;38;2;185;84;225:*.bbl=0;38;2;102;102;102:*.pgm=0;38;2;185;84;225:*.exs=0;38;2;220;223;228:*.tgz=4;38;2;60;200;180:*.ipp=0;38;2;220;223;228:*.tcl=0;38;2;220;223;228:*.rpm=4;38;2;60;200;180:*.ics=0;38;2;226;47;98:*.xcf=0;38;2;185;84;225:*.erl=0;38;2;220;223;228:*.asa=0;38;2;220;223;228:*.pas=0;38;2;220;223;228:*.gif=0;38;2;185;84;225:*.htc=0;38;2;220;223;228:*.hpp=0;38;2;220;223;228:*.vob=0;38;2;185;84;225:*.gvy=0;38;2;220;223;228:*.git=0;38;2;102;102;102:*.iso=4;38;2;60;200;180:*.m4a=0;38;2;185;84;225:*.mp3=0;38;2;185;84;225:*.avi=0;38;2;185;84;225:*.tar=4;38;2;60;200;180:*.fsi=0;38;2;220;223;228:*.pkg=4;38;2;60;200;180:*.bst=0;38;2;220;223;228:*.dmg=4;38;2;60;200;180:*.ltx=0;38;2;220;223;228:*.pyc=0;38;2;102;102;102:*.tbz=4;38;2;60;200;180:*.inc=0;38;2;220;223;228:*.sbt=0;38;2;220;223;228:*.mkv=0;38;2;185;84;225:*.exe=1;38;2;214;177;82:*.mli=0;38;2;220;223;228:*.svg=0;38;2;185;84;225:*.ttf=0;38;2;185;84;225:*.nix=0;38;2;220;223;228:*.bcf=0;38;2;102;102;102:*.tbz2=4;38;2;60;200;180:*.yaml=0;38;2;220;223;228:*.fish=0;38;2;220;223;228:*.rlib=0;38;2;102;102;102:*.xlsx=0;38;2;226;47;98:*.psm1=0;38;2;220;223;228:*.toml=0;38;2;220;223;228:*.conf=0;38;2;220;223;228:*.jpeg=0;38;2;185;84;225:*.h264=0;38;2;185;84;225:*.opus=0;38;2;185;84;225:*.epub=0;38;2;226;47;98:*.mpeg=0;38;2;185;84;225:*.make=0;38;2;220;223;228:*.lisp=0;38;2;220;223;228:*.tiff=0;38;2;185;84;225:*.dart=0;38;2;220;223;228:*.html=0;38;2;214;177;82:*.psd1=0;38;2;220;223;228:*.hgrc=0;38;2;220;223;228:*.flac=0;38;2;185;84;225:*.purs=0;38;2;220;223;228:*.java=0;38;2;220;223;228:*.less=0;38;2;220;223;228:*.diff=0;38;2;220;223;228:*.pptx=0;38;2;226;47;98:*.orig=0;38;2;102;102;102:*.json=0;38;2;220;223;228:*.bash=0;38;2;220;223;228:*.docx=0;38;2;226;47;98:*.webm=0;38;2;185;84;225:*.lock=0;38;2;102;102;102:*.mdown=0;38;2;214;177;82:*.cmake=0;38;2;220;223;228:*shadow=0;38;2;220;223;228:*.swift=0;38;2;220;223;228:*passwd=0;38;2;220;223;228:*.cabal=0;38;2;220;223;228:*.ipynb=0;38;2;220;223;228:*README=1;38;2;95;174;77:*.shtml=0;38;2;214;177;82:*.cache=0;38;2;102;102;102:*.toast=4;38;2;60;200;180:*.class=0;38;2;102;102;102:*.dyn_o=0;38;2;102;102;102:*.patch=0;38;2;220;223;228:*.xhtml=0;38;2;214;177;82:*.scala=0;38;2;220;223;228:*INSTALL=1;38;2;95;174;77:*.config=0;38;2;220;223;228:*.ignore=0;38;2;220;223;228:*TODO.md=1:*LICENSE=0;38;2;153;153;153:*.gradle=0;38;2;220;223;228:*COPYING=0;38;2;153;153;153:*.groovy=0;38;2;220;223;228:*.flake8=0;38;2;220;223;228:*.dyn_hi=0;38;2;102;102;102:*.matlab=0;38;2;220;223;228:*setup.py=0;38;2;220;223;228:*TODO.txt=1:*Makefile=0;38;2;220;223;228:*Doxyfile=0;38;2;220;223;228:*.desktop=0;38;2;220;223;228:*.gemspec=0;38;2;220;223;228:*README.md=1;38;2;95;174;77:*.cmake.in=0;38;2;220;223;228:*.DS_Store=0;38;2;102;102;102:*.kdevelop=0;38;2;220;223;228:*.fdignore=0;38;2;220;223;228:*COPYRIGHT=0;38;2;153;153;153:*.rgignore=0;38;2;220;223;228:*.markdown=0;38;2;214;177;82:*configure=0;38;2;220;223;228:*Dockerfile=0;38;2;220;223;228:*.gitconfig=0;38;2;220;223;228:*SConscript=0;38;2;220;223;228:*.gitignore=0;38;2;220;223;228:*CODEOWNERS=0;38;2;220;223;228:*.localized=0;38;2;102;102;102:*SConstruct=0;38;2;220;223;228:*.scons_opt=0;38;2;102;102;102:*README.txt=1;38;2;95;174;77:*INSTALL.md=1;38;2;95;174;77:*Makefile.am=0;38;2;220;223;228:*Makefile.in=0;38;2;102;102;102:*.gitmodules=0;38;2;220;223;228:*MANIFEST.in=0;38;2;220;223;228:*.synctex.gz=0;38;2;102;102;102:*LICENSE-MIT=0;38;2;153;153;153:*INSTALL.txt=1;38;2;95;174;77:*.travis.yml=0;38;2;214;177;82:*configure.ac=0;38;2;220;223;228:*.fdb_latexmk=0;38;2;102;102;102:*.applescript=0;38;2;220;223;228:*CONTRIBUTORS=1;38;2;95;174;77:*appveyor.yml=0;38;2;214;177;82:*.clang-format=0;38;2;220;223;228:*.gitattributes=0;38;2;220;223;228:*LICENSE-APACHE=0;38;2;153;153;153:*CMakeLists.txt=0;38;2;220;223;228:*CMakeCache.txt=0;38;2;102;102;102:*CONTRIBUTORS.md=1;38;2;95;174;77:*requirements.txt=0;38;2;220;223;228:*CONTRIBUTORS.txt=1;38;2;95;174;77:*.sconsign.dblite=0;38;2;102;102;102:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102"

# Fix can't see `null` in jq output (also changed `false` to red, `true` to
# green)
set -gx JQ_COLORS '36:31:32:0;39:0;32:1;39:1;39'

# Hide fish greeting
set fish_greeting

# Use default fish key bindings
set -g fish_key_bindings fish_default_key_bindings

source ~/.config/fish/abbr.fish
source ~/.config/fish/themes/aodark.fish

globabbr C '| grcat'
globabbr J '| jq'
globabbr G '| grep'
globabbr H '| head'
globabbr L '| less'
globabbr P '| pbcopy'
globabbr S '| sort'
globabbr T '| tail'
globabbr U '| uniq'
globabbr V '| nvimpager'
globabbr W '| wc -l'

if begin
        not string match -q -- Darwin (uname)
        and not string match -e -q -- fedora (hostname)
    end

    function psql
        cp ~/.psqlrc /tmp/
        sudo -u postgres bash -c "PSQLRC=/tmp/.psqlrc psql $argv[1]"
    end

    # Update the default email for git
    if set -q WORK_EMAIL
        git config --global user.email $WORK_EMAIL
    end

    # Tell nvimpager where the nvim is
    set -gx NVIM ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim

    # Fix nvim `Cannot open undo file for writing` sometimes
    mkdir -p ~/.config/nvim/undo/
    if test "$USER" = root; and set -q "$COMPANY_NAME_UPPER"_USER
        chown -R panh ~/.config/nvim/undo/

        if test -d ~/.local/state/nvim/shada/
            chown -R panh ~/.local/state/nvim/shada/
        end

        if test -d ~/.cache
            chown -R panh ~/.cache/
        end
    end

    # Shorten title
    title (hostname | awk -F. '{ print $1 }')

    # Fix `exa -l` complaining about timezone:
    #
    #   Unable to determine time zone: No such file or directory (os error 2)
    #
    set --erase TZ

    # Fix <C-c> doesn't work in remote fish
    bind \cc 'commandline ""'

    # Fix git-deploy umask complaining
    umask 0002

    # Auto start tmux
    if begin
            not set -q TMUX; and test -x /usr/bin/tmux
        end
        /usr/bin/tmux attach -t panh; or /usr/bin/tmux new -s panh
    end
end
