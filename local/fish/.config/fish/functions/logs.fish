#!/bin/bash

function logs
    if test -t 1
        SYSTEMD_PAGER=cat sudo journalctl -u $argv | nvimpager -p +\$ --cmd "set ft=log nowrap"
    else
        SYSTEMD_PAGER=cat sudo journalctl -u $argv
    end
end
