#!/bin/bash

function ppl
    if test -t 1
        /usr/bin/less /var/log/puppet/puppetagent.log
    else
        nvimpager -p +\$ /var/log/puppet/puppetagent.log
    end
end
