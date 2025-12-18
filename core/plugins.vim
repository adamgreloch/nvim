scriptencoding utf-8

" Plugin specification and lua stuff
lua require('plugins')

" Git shorts
call utils#Cabbrev('gb', 'Git blame')

" vim-gnupg
let g:GPGDefaultRecipients = ['zplhatesbananas@gmail.com']

" vimtex
let g:vimtex_motion_matchparen = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_forward_search_on_start = 0

" Close the loclist window automatically when the buffer is closed
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

autocmd BufNewFile,BufRead *.tikz set filetype=tex

let g:vimtex_compiler_latexmk = {
        \ 'out_dir' : 'build',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-pdf',
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \   '-shell-escape',
        \ ],
        \}

let g:tex_conceal='abdmg'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 0
