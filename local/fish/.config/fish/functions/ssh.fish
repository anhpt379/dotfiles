function ssh -d "Make sure we have all the keys before ssh to a host"
    # Disable dotfiles cloning if there's a `-v` in ssh arguments
    if string match -q -- "-v*" $argv
        command ssh $argv
        return
    end

    # Run ssh-agent via fish shell
    # https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3
    if ! ssh-add -l >/dev/null
        pkill ssh-agent
        eval (ssh-agent -c)
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
        ln -sf "$SSH_TTY" ~/.ssh/ssh_tty
    end

    if not string match -q -- Darwin (uname)
        set -f now (date +%s)
        set -f deadline (expr $now - 86400 + 7200)
        set -f have_good_key no
        set -f have_temp_key no

        for ts in (ssh-add -l 2>/dev/null | sed -ne 's/.*temporary key \([0-9]\+\) .*/\1/p')
            set -f have_temp_key yes
            if [ $ts -gt $deadline ]
                set -f have_good_key yes
            end
        end

        if [ $have_temp_key = no ] || [ $have_good_key = no ]
            ssh-add -D
            echo "$COMPANY_NAME_CAPITALIZE's SSH key has expired. Getting a new one..."
            command ssh -A ssh.$COMPANY_DOMAIN
        end
    end

    if string match -q -- "root@*" $argv
        set REMOTE_HOME_DIR /tmp/panh
    else
        set REMOTE_HOME_DIR /home/panh
    end
    set GITLAB_DOMAIN (echo $WORK_EMAIL | awk -F@ '{ print "gitlab."$2 }')

    set REMOTE_COMMAND "
        export HOME=$REMOTE_HOME_DIR
        mkdir -p $REMOTE_HOME_DIR

        if ! test -d .files; then
            GIT_SSH_COMMAND='ssh -i /usr/local/etc/gitlab_ssh_key_dotfiles/id_rsa' \
                git clone --depth=1 --branch=minimal git@$GITLAB_DOMAIN:panh/dotfiles.git .files
            rsync -av .files/HOME/ ~/
        fi

        export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
        export TERM=xterm-kitty
        export WORK_EMAIL=$WORK_EMAIL

        source ~/.bash_profile
    "

    if begin
            string match -q -- "git*" $argv
            or string match -q -- "*ssh.$COMPANY_DOMAIN" $argv
            or string match -q -- "*hsm*" $argv
        end
        command ssh $argv
    else
        command ssh $argv[1] -t $REMOTE_COMMAND
    end

    set -f code $status
    if test $code -ne 0
        echo "SSH: Connection to $argv[1] has been closed."
    end
end
