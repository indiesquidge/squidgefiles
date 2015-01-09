" Use Vim settings, rather then Vi
set nocompatible

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

" Syntax highlighting
syntax on

" Colorscheme
se t_Co=16
let base16colorspace=256
set background=dark
let g:colors_name = 'base16-tomorrow'
colorscheme base16-tomorrow

" Highlight current line and colors
set cursorline

" Set 80 character ruler and colors
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn cterm=NONE ctermbg=0

set sidescroll=1

" 8 line buffer when scrolling through file
set scrolloff=8

" Run RSpec tests with pretty colors by default!
let g:rspec_command = "!rspec --color {spec}"

" ================ Key Mappings =====================

" Use TAB key to sift through completion from neocomplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Toggle relative and normal line numbers
nnoremap <silent><leader>r :set rnu! rnu? <cr>
nnoremap <silent><leader>n :set nu! nu? <cr>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

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

" Lightweight RSpec runner for Vim
Plugin 'thoughtbot/vim-rspec'

" Multiple cursorlines (just like Sublime!)
Plugin 'terryma/vim-multiple-cursors'

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
    \   'right': [ [ 'syntastic', 'lineinfo' ], [ 'filetype' ] ]
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
  if &filetype == "help"
    return ""
  elseif &readonly
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
