function motd
    cat /etc/motd
    [ -f /etc/motd.local ] && cat /etc/motd.local
end
