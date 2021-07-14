function ssh -d "Make sure we have all the keys before ssh to a host"
    if not ssh-add -l | grep anhpt379@gmail.com | grep -q ED25519
        echo "GitHub's SSH key expired. Adding it again..."
        ssh-add ~/.ssh/id_ed25519
        echo
    end

    if not ssh-add -l | grep -q 'Booking.com temporary key'
        echo "Booking's SSH key expired. Getting a new one..."
        command ssh -A ssh.booking.com
    end

    # Sync dotfiles & binary files to remote
    if begin not string match -q -- "git*" $argv;
        and not string match -q -- "t-*" $argv;
        and not string match -q -- "root@*" $argv;
        and not string match -q -- "*ssh.booking.com" $argv; end
        if command ssh $argv -- /bin/true &> /dev/null
            rsync -azvhP \
                --info=name0 \
                --info=progress2 \
                --no-inc-recursive \
                --compress-level=9 \
                --copy-links \
                --keep-dirlinks \
                ~/.ssh/files/.*rc "$argv[1]":~/ 2>/dev/null

            nohup ~/.config/fish/functions/rsync_dotfiles.sh $argv[1] > /tmp/.rsync-$argv[1].log &
        end
    end

    command ssh $argv
end
