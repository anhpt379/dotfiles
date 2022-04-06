#!/bin/bash
set -x

target=$1

lock_file="$HOME/.cache/rsync/${target}.lock"

if [ ! -f "${lock_file}" ] || [ "$(find "${lock_file}" -mmin +240 -print)" ]; then
    touch "${lock_file}"

    echo "***************************************************************************"
    echo "Wait for dotfiles.pl to run..."
    sleep 15

    echo "***************************************************************************"
    echo "Uploading ~/.ssh/files/"
    rsync -azvhP \
        --bwlimit=50 \
        --no-inc-recursive \
        --compress-level=9 \
        --copy-links \
        --keep-dirlinks \
        --relative \
        --exclude-from="$HOME/.ssh/files/.rsyncignore" \
        ~/.ssh/files/ "${target}":~/ 2>/dev/null && \
        command ssh "${target}" -- 'touch ~/.rsync-done'
    echo "***************************************************************************"

    rm -f "${lock_file}"
fi
