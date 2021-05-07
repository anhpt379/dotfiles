#!/bin/bash

target=$1
lock_file="/tmp/.rsync-${target}.lock"

if [ ! -f "${lock_file}" ]; then
    touch "${lock_file}"

    echo "***************************************************************************"
    echo "Uploading ~/.local/bin/"
    rsync -azvhP \
        --bwlimit=20 \
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
        --bwlimit=20 \
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

    echo "***************************************************************************"
    echo "Removing some accidentally deployed files"
    command ssh "${target}" -- 'rm -f ~/.config/fish/functions/less.fish'
    echo "***************************************************************************"

    rm -f "${lock_file}"
fi
