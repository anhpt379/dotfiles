" Git commands
command! Gundo               silent! G undo
command! Gstash              silent! G stash
command! Gstashpop           silent! G stash pop
command! Grebasecontinue     silent! G rebase --continue
command! Grebaseabort        silent! G rebase --abort
command! Gmergecontinue      silent! G merge --continue
command! Gmergeabort         silent! G merge --abort
command! Gcherrypickcontinue silent! G cherry-pick --continue
command! Gcherrypickabort    silent! G cherry-pick --abort

" Git mappings
noremap gr :execute 'G rebase -i --autosquash ' . system('git symbolic-ref --short HEAD') . '<CR>'
noremap ga :G absorb --and-rebase<CR>
noremap gs :tab Git<CR>gg4j
nnoremap <expr> gw &modified ? ':silent! Gwrite<CR>:update<CR>' : ''

let g:dispatch_no_maps = 1
nmap g[ :Start! git pull --rebase origin $(git default-branch)<CR>
nmap g] :Start! git push --force-with-lease origin HEAD<CR>:silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
nmap m  :Start! git checkout $(git default-branch) && git pull --rebase origin $(git default-branch)<CR>
nmap gB :G blame<CR>

" Disable :Gblame commit colors
let g:fugitive_dynamic_colors = 0

" GBrowse functionality
let g:fugitive_gitlab_domains = ['https://gitlab.' . $COMPANY_DOMAIN]
let g:netrw_nogx = 1

function! BrowseWithDefaultBranch(bang) range
  let l:mode = visualmode()
  let l:branch = substitute(system('git default-branch'), '\n', '', 'g')
  if l:mode ==# 'v' || l:mode ==# 'V' || l:mode ==# "\<C-V>"
    execute "'<,'>GBrowse" . a:bang . ' ' . l:branch . ':%'
  else
    execute 'GBrowse' . a:bang . ' ' . l:branch . ':%'
  endif
endfunction

nnoremap <silent> go :call BrowseWithDefaultBranch('')<CR>
nnoremap <silent> gO :call BrowseWithDefaultBranch('!')<CR>
vnoremap <silent> go :<C-U>call BrowseWithDefaultBranch('')<CR>
vnoremap <silent> gO :<C-U>call BrowseWithDefaultBranch('!')<CR>

nnoremap <silent> gm :!if git branch -a \| grep remotes/ \| grep -q /$(git branch --show-current)$; test $? -eq 1; then
                   \     git push --force-with-lease origin HEAD;
                   \   fi<CR>
                   \ :Start! open $(~/.local/bin/gm)<CR>
                   \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
nnoremap <silent> gM :Start! ~/.local/bin/gm \| pbcopy<CR>

" Git log mappings
nnoremap gb :call TermOpen('gb')<CR>
nnoremap gl :call TermOpen('gl')<CR>
nnoremap gL :call TermOpen('gl ' . expand('%:p'))<CR>
vnoremap gl :call TermOpen('gl ' . expand('%:p') . ':' . line('.'))<CR>

" FugitiveRetryCommit function
function! FugitiveRetryCommit()
  let l:msgfile = '.git/COMMIT_EDITMSG'
  if filereadable(l:msgfile)
    " Get actual last commit message (no comments)
    let l:last_msg = join(systemlist('git log -1 --pretty=%B'), "\n")
    let l:last_msg = trim(l:last_msg)
    " Get previous edit message without comment lines
    let l:edit_msg = filter(readfile(l:msgfile), 'v:val !~ "^#"')
    let l:edit_msg = trim(join(l:edit_msg, "\n"))
    " Compare the actual messages
    if l:edit_msg !=# l:last_msg
      execute 'vertical Git commit --quiet --no-status --edit -F .git/COMMIT_EDITMSG'
      return
    endif
  endif
  " No failed commit detected → start fresh
  execute 'vertical Git commit --quiet --no-status'
endfunction

" Close gstatus helper
function! s:close_gstatus()
  " Get the total number of windows
  let l:total = winnr('$')
  " Loop backwards to avoid messing up winnr() ordering after closing
  for l:winnr in range(l:total, 1, -1)
    if l:total > 1 && !empty(getwinvar(l:winnr, 'fugitive_status'))
      execute l:winnr . 'close'
      let l:total -= 1
    endif
  endfor
endfunction

" Fugitive buffer key mappings
augroup fugitive-personal-key-mappings
  autocmd!
  autocmd FileType fugitive nmap <buffer> r :<C-u>tab Git rebase -i <C-R>=expand('<cword>')<CR><CR>
  autocmd FileType fugitive nmap <buffer> p :bd!<CR>
        \ :Start git push origin HEAD --force-with-lease<CR>
        \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
  autocmd FileType fugitive nmap <buffer> P :bd!<CR>
        \ :Start git push origin HEAD --force<CR>
        \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
  autocmd FileType fugitive nmap <buffer> m
        \ :!if git branch -a \| grep remotes/ \| grep -q /$(git branch --show-current)$; test $? -eq 1; then
        \     git push --force-with-lease origin HEAD;
        \   fi<CR>
        \ :<C-u>call vim_git_browse#GitOpenPullRequest()<CR>
        \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
  " Verbose and quiet git commit by default
  autocmd FileType fugitive nmap <buffer> C  :call FugitiveRetryCommit()<CR>
  autocmd FileType fugitive nmap <buffer> cc :call FugitiveRetryCommit()<CR>
  autocmd FileType fugitive nmap <buffer> ca :vertical Git commit --quiet --no-status --amend<CR>
  autocmd FileType fugitive nmap <buffer> ce :Git commit --amend --quiet --no-status --no-edit<CR>
  " gw in gitcommit/gitrebase to save and close
  autocmd FileType gitcommit nmap <buffer> gw :x<CR>
  autocmd FileType gitrebase nmap <buffer> gw :x<CR>
  " m to open the merge request link
  autocmd FileType fugitive nmap <buffer> m gm
  " Open diff in a new buffer by default
  autocmd FileType fugitive map <buffer> <nowait> <CR> O
  " Easier to reach -= keys
  autocmd FileType fugitive map <buffer> <nowait> d =
  autocmd FileType fugitive map <buffer> <nowait> a -
  " x is easier to type than X
  autocmd FileType fugitive map <buffer> <nowait> x X
  " gr to rebase
  autocmd FileType fugitive map <buffer> <nowait> gr :execute 'G rebase -i ' . system('git symbolic-ref --short HEAD') . '<CR>'
  " Left padding
  autocmd FileType fugitive set signcolumn=yes | set number
  " Open G blame commit with `go`
  autocmd FileType fugitiveblame nmap <buffer> go :.GBrowse<CR>
augroup end

" Auto-insert for git commit
augroup fugitive-auto-insert
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG if empty(getline(1)) | startinsert | endif
  autocmd FileType gitrebase normal! 4G
augroup end

" Conflict marker settings
let g:conflict_marker_highlight_group = ''
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'
let g:conflict_marker_enable_matchit = 1
let g:conflict_marker_enable_mappings = 1

