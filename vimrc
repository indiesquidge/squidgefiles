" Use Vim settings, rather then Vi
set nocompatible

" ================ Colors ===========================

" Syntax highlighting
syntax on

" Colorscheme
se t_Co=16
let base16colorspace=256
set background=dark
let g:colors_name = 'base16-default'
colorscheme base16-default

" Line number color
highlight LineNr ctermfg=014

" Matching brackets, parens, etc. color
highlight MatchParen cterm=bold ctermfg=087

" ================ General Config ===================

"No sounds
set visualbell 

" change global leader key to spacebar
let mapleader = "\<Space>"

" Set line numbers to be shown relatively by default
set relativenumber

" buffers exist like in normal editors
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Highlight current line and colors
set cursorline

" Set 80 character ruler and colors
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn cterm=NONE ctermbg=0

" Show Vim commands in write bar
set showcmd

set sidescroll=1

" 8 line buffer when scrolling through file
set scrolloff=8

" Run RSpec tests with pretty colors by default!
let g:rspec_command = "!rspec --color {spec}"

" Hardtime off by default
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1

" Start NERDTree automatically if Vim is opened without a file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ================ Key Mappings =====================

" Ctrl-s to and save
inoremap <C-c> <esc>:w<CR>

" Use TAB key to sift through completion from neocomplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Ruby debugging
map <Leader>d orequire 'pry'<cr>binding.pry<esc>:w<cr>

" ================ Vundle Initialization ============
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" ================ Installed plugins ================

" Fuzzy searcher
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
Plugin 'itchyny/lightline.vim'

" Incredible Git wrapper
Plugin 'tpope/vim-fugitive'

" Multiple cursorlines (just like Sublime!)
Plugin 'terryma/vim-multiple-cursors'

" Add end statement automatically where needed
Plugin 'tpope/vim-endwise'

" Handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" Break bad Vim habits
Plugin 'takac/vim-hardtime'

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

" Lightline config
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', ], [ 'fugitive', 'readonly', 'filename' ] ],
    \   'right': [ [ 'syntastic', 'column', 'lineinfo' ], [ 'filetype' ] ]
    \ },
    \ 'component': {
    \   'column': '%c'
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'readonly': 'MyReadonly',
    \   'lineinfo': 'MyLineInfo'
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '⮀', 'right': '⮂' },
    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
    \ }

" Lightline functions
function! MyReadonly()
  if &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  if exists('*fugitive#head')
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! MyLineInfo()
  return '⭡ ' . line('.') . '/' . line('$')
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.rb,*.js,*.css,*.sh call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction
