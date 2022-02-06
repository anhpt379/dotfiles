#!/bin/bash

target=$1
lock_file="/tmp/.rsync-${target}.lock"

if [ ! -f "${lock_file}" ] || [ "$(find "${lock_file}" -mtime +4h -print)" ]; then
    touch "${lock_file}"

    echo "***************************************************************************"
    echo "Uploading ~/.ssh/files/"
    rsync -azvhP \
        --bwlimit=50 \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        --exclude-from="$HOME/.ssh/files/.rsyncignore" \
        ~/.ssh/files/ "${target}":~/ 2>/dev/null && \
        command ssh "${target}" -- 'touch ~/.rsync-done'
    echo "***************************************************************************"

    rm -f "${lock_file}"
fi
