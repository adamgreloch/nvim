" Remove higlight of last search's occurences when not needed
augroup drop_search_highlight autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END


" Set scrolloff margin to 33% of winheight
augroup set_scrollof_margin
    autocmd!
    autocmd BufEnter,WinEnter,WinNew,VimResized *,*.*
                \ let &scrolloff=winheight(win_getid())/3
augroup END

" Enable spelling for blog posts
autocmd BufNewFile,BufRead **/_posts/* set spell spelllang=en_us

" Creates a new .txt.gpg file with a date on top and appends time of every new entry
let $JOURNALDIR = "/home/adam/Pudlo/journal"

" TODO port
" function! JournalOpen()
"     return ':e '.$JOURNALDIR.'/'.strftime('%Y%m%d').'.txt.gpg'
" endfunction
" 
" nnoremap <expr> <leader>oj JournalOpen()

" TODO set up PGP

augroup journal
  autocmd BufNewFile  $JOURNALDIR/* $pu!=strftime('%A, %d.%m.%y')
  autocmd BufWinEnter $JOURNALDIR/* setlocal tw=79 nowrap
  autocmd BufWinEnter $JOURNALDIR/* call append(line('$'), '') | $pu!=strftime('%H:%M') | call append(line('$'), '') | normal GA
augroup END

" Don't (ever) insert comment leader on newline
autocmd BufEnter * set formatoptions-=ro

" Switch cwd automatically to current file's dir
autocmd BufEnter * silent! lcd %:p:h
