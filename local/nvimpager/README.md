# How to update

<https://github.com/lucc/nvimpager>

```bash
curl -fLo .local/share/nvimpager/runtime/lua/nvimpager.lua https://raw.githubusercontent.com/lucc/nvimpager/main/lua/nvimpager.lua
curl -fLo .local/bin/nvimpager https://raw.githubusercontent.com/lucc/nvimpager/main/nvimpager

# Update the code to use a relative RUNTIME directory
# This way it'll be possible to copy the file to another machine.
sed -i 's|^RUNTIME=.*$|RUNTIME="$HOME/.local/share/nvimpager/runtime"|' .local/bin/nvimpager

chmod +x .local/bin/nvimpager
```bash
