#!/bin/bash

function ppl
    if test -t 1
        nvimpager -p +\$ /var/log/puppet/puppetagent.log
    else
        /usr/bin/less /var/log/puppet/puppetagent.log
    end
end
