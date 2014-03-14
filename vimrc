filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Raimondi/delimitMate'
Bundle 'godlygeek/tabular'
Bundle 'walm/jshint.vim'
Bundle 'altercation/vim-colors-solarized' 
Bundle 'airblade/vim-gitgutter'
Bundle 'jnwhiteh/vim-golang'
Bundle 'fxn/vim-monochrome'

" C-P is used by ctrlp and YankRing
"Bundle 'vim-scripts/YankRing.vim'

filetype plugin indent on

" ctrlp configuration
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_relative = 1
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>e :CtrlPMRU<CR>
nmap <Leader>o :CtrlPTag<CR>

map <leader>n <ESC>:NERDTreeToggle<RETURN>

let g:Powerline_symbols = 'fancy'

syntax on               "syntax highlighting
set number              "show the line number on left
set ruler               "mostra la línia en que ens trobem i la posició dins d'aquesta
set showmode
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
set completeopt=menu,preview "autocomple options. Alternative (vim 7): set completeopt=preview,menu
set pastetoggle=<F10>   "(paste) at F10
set diffopt=iwhite      "vimdiff: ignore white spaces
set mouse=a
set listchars=tab:▸\ ,eol:¬
set list
set laststatus=2        " Always show the statusline
set encoding=utf-8      " Necessary to show Unicode glyphs
set guifont=Monaco\ for\ Powerline:h10
set background=light
set autoread

colorscheme desert
if has("gui_running")
  colorscheme solarized
  let g:solarized_termcolors = 256
  let g:solarized_visibility = "high"
  let g:solarized_contrast = "high"
endif


" Don't beep
set visualbell
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

if has("autocmd")
  " Restore cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
endif

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

" ragtag helpful
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1
let g:CommandTMaxHeight = 30

if has('persistent_undo')
  silent !mkdir -p ~/.vim/tmp
  set undodir=~/.vim/tmp
  set undofile
endif
