function ssh -d "Make sure we have all the keys before ssh to a host"
    # Disable dotfiles cloning if there's a `-` in ssh arguments
    if string match --regex -q -- "(^| )-" $argv || string match --regex -q -- "(^| )trace.*" $argv
        command ssh $argv
        return $status
    end

    # Run ssh-agent via fish shell
    # https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3
    if ! ssh-add -l >/dev/null
        pkill ssh-agent
        eval $(ssh-agent -c)
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        ln -sf "$SSH_TTY" ~/.ssh/ssh_tty
    end

    if not string match -q -- Darwin $(uname)
        set -f now $(date +%s)
        set -f deadline $(expr $now - 86400 + 7200)
        set -f have_good_key no
        set -f have_temp_key no

        for ts in $(ssh-add -l 2>/dev/null | sed -ne 's/.*temporary key \([0-9]\+\) .*/\1/p')
            set -f have_temp_key yes
            if test $ts -gt $deadline
                set -f have_good_key yes
            end
        end

        if test $have_temp_key = no  || test $have_good_key = no
            ssh-add -D
            echo "$COMPANY_NAME_CAPITALIZE's SSH key has expired. Getting a new one..."
            command ssh -A ssh.$COMPANY_DOMAIN
        end
    end

    if string match -q -- "root@*" $argv
        set REMOTE_HOME_DIR /tmp/panh
    else if string match -q -- "*.compute.amazonaws.com" $argv
        rsync -azvhP \
            --info=name0 \
            --info=progress2 \
            --no-inc-recursive \
            --compress-level=9 \
            --copy-links \
            --keep-dirlinks \
            --relative \
            ~/dotfiles/remote/HOME/./.{bashrc,bash_profile,bash_aliases,inputrc,vimrc,less,terminfo,local/bin/pbcopy,local/bin/pbpaste} "$argv[1]": 2>/dev/null
    else
        set REMOTE_HOME_DIR /home/panh
    end
    set GITLAB_DOMAIN $(echo $WORK_EMAIL | awk -F@ '{ print "gitlab."$2 }')

    set REMOTE_COMMAND "
        if test -n "$REMOTE_HOME_DIR"; then
            export HOME=$REMOTE_HOME_DIR
            mkdir -p $REMOTE_HOME_DIR
        fi

        if ! test -d .files; then
            if test -f /usr/local/etc/gitlab_ssh_key_dotfiles/id_rsa; then
                GIT_SSH_COMMAND='ssh -i /usr/local/etc/gitlab_ssh_key_dotfiles/id_rsa' \
                    git clone --depth=1 git@$GITLAB_DOMAIN:panh/dotfiles.git .files
                rsync -av --ignore-existing .files/HOME/ ~/
            fi
        fi

        export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
        export TERM=xterm-kitty
        export WORK_EMAIL=$WORK_EMAIL
        export GITLAB_DOMAIN=$GITLAB_DOMAIN

        source ~/.bash_profile
    "

    set start $(date +%s)
    if begin
            string match -q -- "git*" $argv
            or string match -q -- "*ssh.$COMPANY_DOMAIN" $argv
            or string match -q -- "*hsm*" $argv
        end
        command ssh $argv
    else
        command ssh $argv[1] -t $REMOTE_COMMAND
    end
    set code $status

    if test $code -ne 0
        set end $(date +%s)
        set duration $(expr $end - $start)
        if test $duration -gt 10
            clear
        end
        echo "SSH: Connection to $argv[1] has been closed with code $code."
    end
    return $code
end
