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

    if string match -q -- Darwin $(uname)
        command ssh $argv
        return $status
    else
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

    if not string match -q -- "root@*" $argv
        # Single SSH call to check dependencies and detect architecture
        set -l remote_arch (ssh $argv "
            which rsync &>/dev/null || (echo 'Installing rsync...' >&2 && sudo dnf install -y rsync >/dev/null)
            which tmux &>/dev/null || (echo 'Installing tmux...' >&2 && sudo dnf install -y tmux >/dev/null)
            uname -m
        ") || return 1

        set REMOTE_COMMAND "
            export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
            export TERM=xterm-kitty
            export WORK_EMAIL=$WORK_EMAIL
            source ~/.bash_profile
        "

        # Phase 1: Small dotfiles for ALL architectures
        echo "Uploading dotfiles (CTRL+C to skip)..."
        rsync -azvhP \
            --info=name0 \
            --info=progress2 \
            --no-inc-recursive \
            --copy-links \
            --keep-dirlinks \
            --relative \
            ~/dotfiles/remote/HOME/./.{bashrc,bash_profile,bash_aliases,inputrc,vimrc,tmux.conf,less,terminfo,local/bin/pbcopy,local/bin/pbpaste} "$argv[1]": >/dev/null
        or true

        if string match -q "aarch64" $remote_arch
            # aarch64: Only Phase 1, done
        else
            # Phase 2: Upload all remaining files in background (100KB/s limit), then extract nvim
            # Skip if background rsync to this host is already running
            if not pgrep -f "rsync.*$argv[1]:" >/dev/null
                nohup sh -c "
                rsync -azP \
                    --bwlimit=100 \
                    --partial \
                    --copy-links \
                    --keep-dirlinks \
                    --relative \
                    ~/dotfiles/remote/HOME/./ '$argv[1]':
                ssh '$argv[1]' '
                    rm -rf ~/.local/bin/nvim-appimage/
                    mkdir -p ~/.local/bin/nvim-appimage/
                    cd ~/.local/bin/nvim-appimage/ && ../nvim.appimage --appimage-extract >/dev/null
                    ln -sf ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
                '
            " >/dev/null 2>&1 &
                disown
            end
        end

    end

    set start $(date +%s)
    if begin
            string match -q -- "git*" $argv
            or string match -q -- "*ssh.$COMPANY_DOMAIN" $argv
            or string match -q -- "*hsm*" $argv
            or string match -q -- "*@*" $argv
        end
        command ssh $argv
    else
        command ssh $argv[1] -t $REMOTE_COMMAND
    end
    set code $status

    # Reset alternate screen mode after SSH exits
    # Fixes broken double-click selection in tmux after abrupt disconnects
    printf '\e[?1049l'

    if test $code -ne 0
        set end $(date +%s)
        set duration $(expr $end - $start)
        if test $duration -gt 10
            scroll_up
        end
        echo "SSH: Connection to $argv[1] has been closed with code $code."
    end
    return $code
end
