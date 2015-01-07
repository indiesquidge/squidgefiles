" Use Vim settings, rather then Vi
set nocompatible

" ================ General Config ===================

set number                      "Line numbers
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds

" buffers exist like in normal editors
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Syntax highlighting
syntax on

" Colorscheme
se t_Co=16
let base16colorspace=256
set background=dark
let g:colors_name = 'base16-tomorrow'
colorscheme base16-tomorrow

" Set 80 character ruler and colors
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn cterm=NONE ctermbg=0

" Highlight current line and colors
set cursorline
highlight CursorLine cterm=NONE ctermbg=235

set sidescroll=1

" Use TAB key to sift through completion from neocomplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" ================ Vundle Initialization ============

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" ================ Installed plugins ================

" Ctrl p to quickly switch files
Plugin 'kien/ctrlp.vim'

" Nerdtree file viewer
Plugin 'scrooloose/nerdtree'

" Error linting
Plugin 'scrooloose/syntastic'

" Easily switch between vim and tmux
Plugin 'christoomey/vim-tmux-navigator'

" Easy to use, file-type sensitive comments
Plugin 'tomtom/tcomment_vim'

" Keyword completion system
Plugin 'Shougo/neocomplete.vim'

" Insert quotes, brackets, etc. in pairs
Plugin 'jiangmiao/auto-pairs'

" Show Git diff in gutter of file
Plugin 'airblade/vim-gitgutter'

" Statusbar
Plugin 'bling/vim-airline'

call vundle#end()
filetype plugin indent on

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.

if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================
" Results in spaces being used for all indentation

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Detect filetypes
filetype plugin on
filetype indent on

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

" Stuff to ignore when tab completing
set wildmode=list:longest
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=node_modules/**
set wildignore+=tmp/**

" Autocompletion
let g:neocomplete#enable_at_startup = 1

" ================ Status bar =======================

" Enable status bar always
set laststatus=2

" Airline config
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols_branch = '⭠'

let g:airline_detect_modified=0
let g:airline_section_b = ''
let g:airline_section_c = '%t'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = '%03l/%03L'
