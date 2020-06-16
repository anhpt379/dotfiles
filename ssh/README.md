# Remote pbcopy

## Start/stop the service

```bash
launchctl load pbcopy.plist
launchctl unload pbcopy.plist
```

## Start pbcopy service on startup

```bash
launchctl load -w pbcopy.plist
```
