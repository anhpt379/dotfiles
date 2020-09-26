function ssh -d "Make sure we have all the keys before ssh to a host"
    if not ssh-add -l | grep anhpt379@gmail.com | grep -q ED25519
      ssh-add ~/.ssh/id_ed25519
    end

    if not ssh-add -l | grep -q 'Booking.com temporary key'
      command ssh -A ssh.booking.com
    end

    command ssh $argv
end
