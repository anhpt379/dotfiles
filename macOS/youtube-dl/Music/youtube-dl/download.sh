#!/bin/bash

cd ~/Music/youtube-dl/ || exit 1

PLAYLIST="https://www.youtube.com/playlist?list=LLWHbPRck8HGdTIBFaYRjmsg"

youtube-dl \
  --dump-json \
  --flat-playlist \
  --playlist-end 100 \
  --playlist-reverse \
  --cookies cookies.txt "$PLAYLIST" \
  | /opt/homebrew/bin/jq -r '.id' \
  | sed 's_^_https://youtu.be/_' \
  > urls.txt

youtube-dl \
  --verbose \
  --ignore-errors \
  --continue \
  --no-overwrites \
  --no-post-overwrites \
  --embed-thumbnail \
  --extract-audio \
  --audio-format aac \
  --audio-quality 0 \
  --output "%(title)s.%(ext)s" \
  --download-archive downloaded.txt \
  --batch-file urls.txt \

rm -f ./*.temp.aac

mv ./*.aac ~/Music/Music/Media.localized/Automatically\ Add\ to\ Music.localized/

rm -f ./*.jpg ./*.webp ./*.png ./*.m4a ./*.webm ./*.mp4 ./*.part
