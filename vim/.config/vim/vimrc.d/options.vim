" --- General ---
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set nohidden
set mouse=a
set clipboard=unnamedplus
set history=1000

" --- File Handling ---
set autoread
set undofile
set undodir=~/.config/vim/undo
set noswapfile

" --- UI Enhancements ---
set number
set relativenumber
set cursorline
set ruler
set laststatus=2
set showcmd
set noshowmode
set wildmenu
set wildmode=longest:full,full
set signcolumn=yes
set scrolloff=5
set sidescrolloff=5
set lazyredraw
set ttyfast
set termguicolors
set linebreak
set breakindent

" --- Searching ---
set ignorecase
set smartcase
set incsearch
set hlsearch
set showmatch

" --- Indentation ---
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set breakindent

" --- Behavior ---
set updatetime=300
set timeoutlen=9999
set shortmess+=c
set formatoptions+=j
set completeopt=menuone,noinsert,noselect
set splitbelow
set splitright
set backspace=indent,eol,start


" --- Syntax & Filetype ---
syntax on
filetype plugin indent on
