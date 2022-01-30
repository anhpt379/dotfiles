# Remote copy/paste

## Local (macOS) side

```bash
launchctl load -w ~/Library/LaunchAgents/pbcopy.plist
launchctl load -w ~/Library/LaunchAgents/pbpaste.plist
```

## Remote side

`pbcopy`

```bash
nc 127.0.0.1 2224 --send-only
```

`pbpaste`

```bash
nc 127.0.0.1 2225 --recv-only
```

`~/.vimrc`

```vim
nmap y0  <Plug>(highlightedyank)0:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap y$  <Plug>(highlightedyank)$:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap ye  <Plug>(highlightedyank)e:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap yw  <Plug>(highlightedyank)w:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap yy  <Plug>(highlightedyank)<Plug>(highlightedyank):sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap yib <Plug>(highlightedyank)ib:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap yiq <Plug>(highlightedyank)iq:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
nmap Y   <Plug>(highlightedyank)$:sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)
vmap y   <Plug>(highlightedyank):sleep 700m<CR>:call system('nc 127.0.0.1 2224 --send-only', @0)

nmap p :exec 'normal a' . system("nc 127.0.0.1 2225 --recv-only")<CR>
nmap P :exec 'normal i' . system("nc 127.0.0.1 2225 --recv-only")<CR>
```
