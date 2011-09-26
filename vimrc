call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" the pathogen call search the vim plugins on bundles

syntax on               "syntax highlighting
set number              "show the line number on left
set ruler               "mostra la línia en que ens trobem i la posició dins d'aquesta
set showmode            "ens mostra si estem en mode edició, substitució o cap
set hlsearch            "highlight the search pattern
set autoindent
set cindent
set ignorecase          "search is not case sensitive
set nocompatible        "remove the compatibility with older versions of vim
set backspace=2         "backspace always remove not only on insert mode
set tabstop=2           "set the length of a tab
set shiftwidth=2
set softtabstop=2
set expandtab
set showmatch           "shows the other () or [] when we select one
set completeopt=preview "autocomple options. Alternative (vim 7): set completeopt=preview,menu
set pastetoggle=<F10>   "(paste) at F10
set diffopt=iwhite      "vimdiff: ignore white spaces
set background=dark
colorscheme solarized
:filetype plugin on
set mouse=a
set listchars=tab:▸\ ,eol:¬
set list

" Don't beep
set visualbell
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

if has("autocmd")
  " Enable filetype detection
  filetype plugin indent on

  " Restore cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
endif

set statusline=%F%m%r%h%w[%L]%y[%p%%][%04v][%{fugitive#statusline()}]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current
"              | | | | |  |   |      |  |     |       column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the rbuffer

" <leader> key
let mapleader = ","

" movement on the same line
" on Apple Keyboards: cmd + key
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" Bubble single lines: ctrl + up/down
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" keep swap files in one of these
set directory=/tmp
set backupdir=/tmp
