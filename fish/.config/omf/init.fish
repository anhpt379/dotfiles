balias k kubectl
balias kd 'kubectl describe'
balias kdf 'kubectl delete --force --grace-period=0'
balias kn 'kubens'
balias kc 'kubectx'

balias g        'git'
balias gs       'git status'
balias push     'git push origin'
balias pull     'git pull --rebase origin'
balias fetch    'git fetch origin'
balias reset    'git reset'
balias master   'git checkout master'
balias gadd     'git add'
balias gpush    'git push'
balias gpull    'git pull'
balias gfetch   'git fetch'
balias gco      'git checkout'
balias glog     'git log'
balias greset   'git reset'
balias grevert  'git revert'
balias grestore 'git restore'
balias grebase  'git rebase'
balias gdiff    'git diff'
balias gshow    'git show'
balias gstash   'git stash'
balias gclone   'git clone'
balias gremote  'git remote'
balias gbranch  'git branch'

balias ..    'cd ..'
balias ...   'cd ../..'
balias ....  'cd ../../..'
balias ..... 'cd ../../../..'

balias ls 'exa --group-directories-first'
balias la 'exa -a --group-directories-first'
balias ll 'exa -la --group-directories-first'

alias  vi  'nvim'
alias  vim 'nvim'
balias cat 'bat'
balias ping 'prettyping --nolegend'
balias ncdu 'ncdu -rr -x --exclude .git'

# https://sw.kovidgoyal.net/kitty/faq.html#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-when-sshing-into-a-different-computer
balias ssh 'kitty +kitten ssh'

balias k 'kubectl'
balias d 'docker'
balias dc 'docker-compose'
balias m 'minikube'

balias c 'clear'
balias j 'z'
balias f 'fzf'
balias v 'vim'
balias l 'lf'

# key bindings
bind \cg accept-autosuggestion execute

set -x GOROOT /usr/local/opt/go/libexec
set -x GOPATH $HOME/.go
set -gx PATH $PATH $HOME/.krew/bin

set -gx PATH $HOME/Library/Python/3.7/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH '/usr/local/opt/gnu-sed/libexec/gnubin' $PATH
set -gx fish_user_paths '/usr/local/opt/curl/bin' $fish_user_paths

set -gx KUBE_EDITOR 'vim'

# Fix trackpad scrolling doesn't work in diff-so-fancy
# Need to remove the `X` flag from less options, but can't do it via .gitconfig,
# since git set the default to `FRX` if we don't set `LESS` environment variable
# https://github.com/so-fancy/diff-so-fancy/issues/246
# https://github.com/git/git/blob/v2.7.1/Documentation/config.txt#L646-L648
set -gx LESS 'RFS'

# Hide the fish greeting
set fish_greeting ""

# Delete big word with Ctrl+Delete
bind \cH backward-kill-bigword

# Make reverse word delete work (using ctrl/option+forward_delete)
bind \e\[3\;5~ kill-bigword
bind \e\[3\;3~ kill-word

# Use pageup/pagedown to jump between big words
bind \e\[5~ forward-bigword
bind \e\[6~ backward-bigword

# Edit current command in vim
bind \ce edit_command_buffer

# Fzf
bind \cf 'fzf_find'
bind \cr 'fzf_history'

set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f --exclude ".git"'
set -gx FZF_DEFAULT_OPTS    '--pointer=" >" --prompt="  " --color fg:#DCDFE4,bg:-1,hl:#55CABE,fg+:#FFCC66,bg+:#1C1E23,hl+:#FFCC66,info:#919BAA,prompt:#C068DF,pointer:#3BB0E0,marker:#55CABE,spinner:#919BAA --no-multi --reverse --height=40% --info=inline --bind=tab:accept,ctrl-j:ignore,ctrl-k:ignore --bind=change:top --bind=ctrl-f:page-down,ctrl-b:page-up'

# Custom fish color scheme
set -U fish_color_normal normal
set -U fish_color_command dcdfe4
set -U fish_color_quote ffcc66
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error dd3c69
set -U fish_color_param dcdfe4
set -U fish_color_comment ffcc66
set -U fish_color_match 6699cc
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;80m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[30;5;43m'     # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;74m'  # begin underline

# lf
set -x LF_ICONS "\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.7z=:\
*.a=:\
*.ai=:\
*.apk=:\
*.asm=:\
*.asp=:\
*.aup=:\
*.avi=:\
*.bat=:\
*.bmp=:\
*.bz2=:\
*.c=:\
*.c++=:\
*.cab=:\
*.cbr=:\
*.cbz=:\
*.cc=:\
*.class=:\
*.clj=:\
*.cljc=:\
*.cljs=:\
*.cmake=:\
*.coffee=:\
*.conf=:\
*.cp=:\
*.cpio=:\
*.cpp=:\
*.cs=:\
*.css=:\
*.cue=:\
*.cvs=:\
*.cxx=:\
*.d=:\
*.dart=:\
*.db=:\
*.deb=:\
*.diff=:\
*.dll=:\
*.doc=:\
*.docx=:\
*.dump=:\
*.edn=:\
*.efi=:\
*.ejs=:\
*.elf=:\
*.elm=:\
*.epub=:\
*.erl=:\
*.ex=:\
*.exe=:\
*.exs=:\
*.eex=:\
*.f#=:\
*.fifo=|:\
*.fish=:\
*.flac=:\
*.flv=:\
*.fs=:\
*.fsi=:\
*.fsscript=:\
*.fsx=:\
*.gem=:\
*.gif=:\
*.go=:\
*.gz=:\
*.gzip=:\
*.h=:\
*.hbs=:\
*.hpp=:\
*.hrl=:\
*.hs=:\
*.htaccess=:\
*.htpasswd=:\
*.htm=:\
*.html=:\
*.ico=:\
*.img=:\
*.ini=:\
*.iso=:\
*.jar=:\
*.java=:\
*.jl=:\
*.jpeg=:\
*.jpg=:\
*.js=:\
*.json=:\
*.jsx=:\
*.key=:\
*.less=:\
*.lha=:\
*.lhs=:\
*.log=:\
*.lua=:\
*.lzh=:\
*.lzma=:\
*.m4a=:\
*.m4v=:\
*.markdown=:\
*.md=:\
*.mkv=:\
*.ml=λ:\
*.mli=λ:\
*.mov=:\
*.mp3=:\
*.mp4=:\
*.mpeg=:\
*.mpg=:\
*.msi=:\
*.mustache=:\
*.o=:\
*.ogg=:\
*.pdf=:\
*.php=:\
*.pl=:\
*.pm=:\
*.png=:\
*.pub=:\
*.ppt=:\
*.pptx=:\
*.psb=:\
*.psd=:\
*.py=:\
*.pyc=:\
*.pyd=:\
*.pyo=:\
*.rar=:\
*.rb=:\
*.rc=:\
*.rlib=:\
*.rom=:\
*.rpm=:\
*.rs=:\
*.rss=:\
*.rtf=:\
*.s=:\
*.so=:\
*.scala=:\
*.scss=:\
*.sh=:\
*.slim=:\
*.sln=:\
*.sql=:\
*.styl=:\
*.suo=:\
*.t=:\
*.tar=:\
*.tgz=:\
*.ts=:\
*.twig=:\
*.vim=:\
*.vimrc=:\
*.wav=:\
*.webm=:\
*.xbps=:\
*.xhtml=:\
*.xls=:\
*.xlsx=:\
*.xml=:\
*.xul=:\
*.xz=:\
*.yaml=:\
*.yml=:\
*.zip=:\
.git=:\
Desktop=:\
Documents=:\
Downloads=:\
Dotfiles=:\
Dropbox=:\
Music=:\
Pictures=:\
Public=:\
Templates=:\
Videos=:\
*.Xauthority=:\
*.Xdefaults=:\
*.Xresources=:\
*.bash_aliases=:\
*.bashprofile=:\
*.bash_profile=:\
*.bash_logout=:\
*.bash_history=:\
*.bashrc=:\
*.dmrc=:\
*.DS_Store=:\
*.fasd=:\
*.fehbg=:\
*.gitconfig=:\
*.gitattributes=:\
*.gitignore=:\
*.inputrc=:\
*.jack-settings=:\
*.mime.types=:\
*.nvidia-settings-rc=:\
*.pam_environment=:\
*.profile=:\
*.recently-used=:\
*.selected_editor=:\
*.vim=:\
*.vimrc=:\
*.viminfo=:\
*.xinitrc=:\
*.xinputrc=:\
config=:\
Dockerfile=:\
docker-compose.yml=:\
dropbox=:\
exact-match-case-sensitive-1.txt=X1:\
exact-match-case-sensitive-2=X2:\
favicon.ico=:\
a.out=:\
bspwmrc=:\
sxhkdrc=:\
Makefile=:\
Makefile.in=:\
Makefile.ac=:\
config.mk=:\
config.m4=:\
config.ac=:\
configure=:\
Rakefile=:\
gruntfile.coffee=:\
gruntfile.js=:\
gruntfile.ls=:\
gulpfile.coffee=:\
gulpfile.js=:\
gulpfile.ls=:\
ini=:\
ledger=:\
package.json=:\
package-lock.json=:\
.ncmpcpp=:\
playlists=:\
known_hosts=:\
authorized_keys=:\
license=:\
LICENSE.md=:\
LICENSE=:\
LICENSE.txt=:\
mimeapps.list=:\
node_modules=:\
procfile=:\
react.jsx=:\
README.rst=:\
README.md=:\
README.markdown=:\
README=:\
README.txt=:\
user-dirs.dirs=:\
webpack.config.js=:\
"
