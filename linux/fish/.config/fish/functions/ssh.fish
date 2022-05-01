function ssh -d "Make sure we have all the keys before ssh to a host"
    # Run ssh-agent via fish shell
    # https://gist.github.com/josh-padnick/c90183be3d0e1feb89afd7573505cab3
    if test -z (pgrep ssh-agent | string collect)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end

    if not ssh-add -l | grep anhpt379@gmail.com | grep -q ED25519
        echo "GitHub's SSH key expired. Adding it again..."
        ssh-add ~/.ssh/id_ed25519
        echo
    end

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
            ~/.ssh/files/./.{bashrc,inputrc,vimrc,less,terminfo,local/bin/pbcopy,local/bin/pbpaste} "$argv[1]":/tmp/panh/ 2>/dev/null

        command kitty +kitten ssh $argv -t HOME=/tmp/panh bash

    else
        # Sync dotfiles & binary files to remote
        if command ssh $argv -- /bin/true &>/dev/null
            rsync -azvhP \
                --info=name0 \
                --info=progress2 \
                --no-inc-recursive \
                --compress-level=9 \
                --copy-links \
                --keep-dirlinks \
                --relative \
                ~/.ssh/files/./.{bashrc,inputrc,vimrc,less,terminfo,local/bin/pbcopy,local/bin/pbpaste} "$argv[1]":~/ 2>/dev/null

            mkdir -p ~/.cache/rsync
            nohup ~/.config/fish/functions/rsync_dotfiles.sh $argv >~/.cache/rsync/$argv[1].log &
        end

        command kitty +kitten ssh $argv
    end

end
