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

" Delete text present before insert mode (FIX THIS WITH SENSIBLE.VIM!!!)
set backspace=2

" change global leader key to spacebar
let mapleader = "\<Space>"

" Set line numbers to be shown by default
set number

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

" Hardtime off by default
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1

" Start NERDTree automatically if Vim is opened without a file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Automatically remove trailing whitespace on save
autocmd BufWritePre *.rb,*.js,*.py,*.go :%s/\s\+$//e

let g:syntastic_ruby_checkers = ['rubocop']

" ================ Key Mappings =====================

" Ctrl-s to and save
inoremap <C-c> <esc>:w<CR>

" Use TAB key to sift through completion from neocomplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Ruby debugging
map <Leader>d orequire 'pry'<cr>binding.pry<esc>:w<cr>

" Running jasmine-node tests from Vim with Vimux
map <Leader>rj :w %<cr>:call VimuxRunCommand("clear; jasmine-node --verbose " . bufname("%"))<cr>

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

" Complement to neocomplete for common snippets
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'

" Insert quotes, brackets, etc. in pairs
Plugin 'jiangmiao/auto-pairs'

" Show Git diff in gutter of file
Plugin 'airblade/vim-gitgutter'

" Statusbar
Plugin 'itchyny/lightline.vim'

" Incredible Git wrapper
Plugin 'tpope/vim-fugitive'

" Add end statement automatically where needed
Plugin 'tpope/vim-endwise'

" Handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" Break bad Vim habits
Plugin 'takac/vim-hardtime'

" Interact with Tmux from Vim
Plugin 'benmills/vimux'

" Ruby-specific plugin for running tests
Plugin 'jgdavey/vim-turbux'

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

" Neosnippets example configuration
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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
