# Youtube Liked Videos -> Music

## Download a `cookies.txt` file to `~/Music/youtube-dl/`

<https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg>

## Installation

```bash
pip3 install --force-reinstall https://github.com/yt-dlp/yt-dlp/archive/refs/heads/master.zip
```

## Add to crontab

```bash
0 * * * * bash ~/Music/youtube-dl/download.sh &> ~/Music/youtube-dl/download.log
```
