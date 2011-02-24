call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" the pathogen call search the vim plugins on bundles

syntax on               "syntax highlighting
set number              "show the line number on left
set ruler               "mostra la línia en que ens trobem i la posició dins d'aquesta
set showmode            "ens mostra si estem en mode edició, substitució o cap
set hlsearch            "ressalta el text buscat
set autoindent          "opcions d'indentació
set cindent             "opcions d'indentació
set ignorecase          "fa la cerca insensible a majúscules i minúscules
set nocompatible        "treu la compatibilitat amb altres vim's per tal d'usar eines més potents (normalment necessari)
set backspace=2         "opcions per a que la tecla d'esborrar ens esborri sempre, no sols el text que acabem d'inserir
set tabstop=2           "per indicar al vim quina ha de ser la mida d'un tabulador quan el mostra per pantalla
set shiftwidth=2        "indica al vim quina és la mida d'un tabulador quan l'insereixes en mode edició
set softtabstop=2
set expandtab
"set bg=dark
"set nowrap              "d'aquesta manera no talla les línies al final de pantalla
set showmatch           "mostra l'altra banda d'una clau o d'un parèntesis quan ens situem al damunt
set completeopt=preview "opcions d'autocompletatge. Alternativa (vim 7): set completeopt=preview,menu
set pastetoggle=<F10>   "defineixes la tecla d'enganxar (paste) al F10
set diffopt=iwhite      "opcions per vimdiff: ignore white spaces
colorscheme torte
:filetype plugin on
set mouse=a
set listchars=tab:▸\ ,eol:¬
set list
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

