scriptencoding utf-8

set cmdheight=1 " currently clashes with shortmess

set foldmethod=marker

set nolist

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=500

set updatetime=0  " For CursorHold events

" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
  set clipboard+=unnamedplus
endif

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" Ignore certain files and folders when globing
set wildignore+=*.o,*.obj,*.dylib,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.bmp,*.gif,*.tiff,*.svg,*.ico
set wildignore+=*.pyc,*.pkl
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.xdv
set wildignorecase  " ignore file and dir name cases in cmd-completion

" Set up backup directory
let g:backupdir=expand(stdpath('data') . '/backup//')
let &backupdir=g:backupdir

" Skip backup for patterns in option wildignore
let &backupskip=&wildignore
set backup  " create backup for files
set backupcopy=yes  " copy the original file to backupdir and overwrite it

" General tab settings
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

set number relativenumber  " Show line number and relative line number

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File and script encoding settings for vim
set fileencoding=utf-8

" Break line at predefined characters
set linebreak

" List all matches and complete till longest common string
set wildmode=list:longest

" Use mouse to select and resize windows, etc.
set mouse=nic  " Enable mouse in several mode
set mousemodel=popup  " Set the behaviour of mouse
set mousescroll=ver:1,hor:6

" Disable showing current mode on command line since statusline plugins can show it.
set noshowmode

set fileformats=unix " Fileformats to use for new files

" Ask for confirmation when handling unsaved or read-only files
set confirm

set visualbell noerrorbells  " Do not use visual and errorbells
set history=500  " The number of command and search history to keep

" Auto-write the file based on some condition
set autowrite

" Show hostname, full path of file and last-mod time on the window title. The
" meaning of the format str for strftime can be found in
" http://man7.org/linux/man-pages/man3/strftime.3.html. The function to get
" lastmod time is drawn from https://stackoverflow.com/q/8426736/6064933
set title
set titlestring=%t

" Persistent undo even after you close a file and re-open it
set undofile

set spelllang=en     " Spell languages
set spellsuggest+=12 " show 12 spell suggestions at most

set virtualedit=block  " Virtual edit is useful for visual block edit

set nostartofline

" External program to use for grep command
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" Enable true color support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and https://gist.github.com/XVilka/8346728.
set termguicolors

" Remove certain character from file name pattern matching
set isfname-==
set isfname-=,

" diff options
set diffopt=
set diffopt+=vertical  " show diff in vertical position
set diffopt+=filler  " show filler for deleted lines
set diffopt+=closeoff  " turn off diff when one file window is closed
set diffopt+=context:3  " context for diff
set diffopt+=internal,indent-heuristic,algorithm:histogram
set diffopt+=linematch:60

set nowrap  " do no wrap
set noruler

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

