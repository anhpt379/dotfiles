function ssh -d "Make sure we have all the keys before ssh to a host"
    # Run ssh-agent via fish shell
    # https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3
    if test -z (pgrep ssh-agent | string collect)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK &>/dev/null
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID &>/dev/null
    end

    if not ssh-add -l | grep anhpt379@gmail.com | grep -q ED25519
        echo "GitHub's SSH key expired. Adding it again..."
        if string match -q -- "Darwin" (uname)
            ssh-add --apple-use-keychain ~/.ssh/id_ed25519
        else
            ssh-add ~/.ssh/id_ed25519
        end
        echo
    end

    if not string match -q -- "Darwin" (uname)
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
            echo "$COMPANY_NAME_CAPITALIZE's SSH key has expired. Getting a new one..."
            command ssh -A ssh.$COMPANY_DOMAIN
        end
    end

    if begin
            string match -q -- "git*" $argv
            or string match -q -- "*ssh.$COMPANY_DOMAIN" $argv
        end

        command ssh $argv

    else if string match -q -- "root@*" $argv
        # Sync just the minimal dotfiles to /tmp/panh/ when using root@<host>
        # `root` is a shared account on servers, I don't want to pollute it with my
        # own personal settings, so let's change the $HOME to a different location.
        rsync -azvhP \
            --info=name0 \
            --info=progress2 \
            --no-inc-recursive \
            --compress-level=9 \
            --copy-links \
            --keep-dirlinks \
            --relative \
            ~/dotfiles/remote/HOME/./.{bashrc,inputrc,vimrc,less,terminfo,local/bin/pbcopy,local/bin/pbpaste} "$argv[1]":/tmp/panh/ 2>/dev/null

        command ssh $argv -t WORK_EMAIL=$WORK_EMAIL HOME=/tmp/panh bash

    else
        set -f start_time (date +%s)
        set -f jump_host (cat ~/.ssh/conf.d/work.conf | grep ProxyJump | tail -1 | awk '{ print $NF }')

        echo "Syncing dotfiles to $jump_host..."
        rsync -azhP \
            --quiet \
            --info=name0 \
            --info=progress2 \
            --no-inc-recursive \
            --compress-level=9 \
            --copy-links \
            --keep-dirlinks \
            --delete \
            --delete-excluded \
            --exclude-from="$HOME/dotfiles/remote/.rsyncignore" \
            ~/dotfiles/remote/HOME/ $jump_host:~/HOME/

        echo "Syncing dotfiles from $jump_host to $argv[1]..."
        command ssh $jump_host -- "rsync -e 'ssh -o UserKnownHostsFile=/dev/null' --quiet -a ~/HOME/ $argv[1]:~/"
        if test $status -ne 0
            return
        end

        set -f end_time (date +%s)
        set -f duration (expr $end_time - $start_time)
        if test $duration -gt 2
            echo "$(echo $argv[1] | awk -F. '{ print $1 }') is connected now 😀" | nc 127.0.0.1 2227
        end

        command ssh $argv -t WORK_EMAIL=$WORK_EMAIL fish

        set -f code $status
        if test $code -ne 0
            clear
            echo "`ssh $argv` returned $code"
        end
    end
end
