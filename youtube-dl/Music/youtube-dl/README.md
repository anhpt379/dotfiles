# Youtube Liked Videos -> Music

## Requirements

```bash
brew install libav trash
pip3 install youtube-dl
```

## Download a `cookies.txt` file to `~/Music/youtube-dl/`

<https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg>

## Add to crontab

```bash
0 * * * * bash ~/Music/youtube-dl/download.sh
```
