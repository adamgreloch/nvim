scriptencoding utf-8

" Plugin specification and lua stuff
lua require('plugins')

" Use short names for common plugin manager commands to simplify typing.
" To use these shortcuts: first activate command line with `:`, then input the
" short alias, e.g., `pi`, then press <space>, the alias will be expanded to
" the full command automatically.
call utils#Cabbrev('pi', 'PackerInstall')
call utils#Cabbrev('pud', 'PackerUpdate')
call utils#Cabbrev('pc', 'PackerClean')
call utils#Cabbrev('ps', 'PackerSync')

call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<C-l>',
      \ 'reject_key': '<C-h>',
      \ 'enable_cmdline_enter': 1,
      \ })

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'set_pcre2_pattern': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])

let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': s:highlighters,
      \ 'max_height': '40%',
      \ 'reverse': 0,
      \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \ },
      \ }))

" vim-gnupg
let g:GPGDefaultRecipients = ['zplhatesbananas@gmail.com']

" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/ultisnips']

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

" vim-rooter
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['>rift-dev-zpp22']

" vim-gitgutter
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1
set signcolumn=no
