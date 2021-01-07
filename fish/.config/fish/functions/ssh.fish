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
    if not string match -q -- "git*" $argv[1]
      rsync -azvhP \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        ~/.local/bin/ $argv[1]:~/.local/bin/ 2>/dev/null

      rsync -azvhP \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        --exclude-from="$HOME/.ssh/files/.rsyncignore" \
        ~/.ssh/files/ $argv[1]:~/ 2>/dev/null
    end

    command ssh $argv
end
