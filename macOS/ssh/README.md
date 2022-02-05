# Remote copy/paste/open

## macOS side

```bash
launchctl load -w ~/Library/LaunchAgents/pbcopy.plist
launchctl load -w ~/Library/LaunchAgents/pbpaste.plist
launchctl load -w ~/Library/LaunchAgents/noti.plist

brew install superbrothers/opener/opener
brew services start opener
```
