#!/bin/bash

target=$1
lock_file="/tmp/.rsync-${target}.lock"

if [ ! -f "${lock_file}" ]; then
    touch "${lock_file}"

    echo "***************************************************************************"
    echo "Uploading ~/.local/bin/"
    rsync -azvhP \
        --bwlimit=200 \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        ~/.local/bin/ "${target}":~/.local/bin/ 2>/dev/null

    echo "***************************************************************************"
    echo "Uploading ~/.ssh/files/"
    rsync -azvhP \
        --bwlimit=200 \
        --info=name0 \
        --info=progress2 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        --exclude-from="$HOME/.ssh/files/.rsyncignore" \
        ~/.ssh/files/ "${target}":~/ 2>/dev/null
    echo "***************************************************************************"

    command ssh "${target}" -- 'touch ~/.rsync-done'

    rm -f "${lock_file}"
fi