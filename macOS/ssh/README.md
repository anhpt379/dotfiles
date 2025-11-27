# Remote copy/paste/open

```bash
launchctl bootout gui/$(id -u)/localhost.pbcopy 2>/dev/null || true
launchctl bootout gui/$(id -u)/localhost.pbpaste 2>/dev/null || true
launchctl bootout gui/$(id -u)/localhost.noti 2>/dev/null || true

launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/localhost.pbcopy.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/localhost.pbpaste.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/localhost.noti.plist

launchctl list | grep localhost

brew services start opener
```
