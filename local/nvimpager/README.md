# Git subtree commands

## Adding nvimpager

```bash
cd $(git rev-parse --show-toplevel)
git subtree add --prefix=local/nvimpager/src https://github.com/lucc/nvimpager.git main --squash
```

## Pulling nvimpager's updates

```bash
cd $(git rev-parse --show-toplevel)
git subtree pull --prefix=local/nvimpager/src https://github.com/lucc/nvimpager.git main --squash
```
