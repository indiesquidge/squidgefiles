" Use Vim settings, rather then Vi
set nocompatible

" ================ Colors ===========================

" Syntax highlighting
syntax on

" Colorscheme
se t_Co=16
let g:seoul256_background = 233
colo seoul256

" comment and visual mode highlight colors
hi Comment ctermfg=DarkGrey
hi Visual  ctermbg=239 ctermfg=253

" Line number color
highlight LineNr ctermfg=246

" Matching brackets, parens, etc. color
highlight MatchParen cterm=bold ctermbg=057 ctermfg=white

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
highlight ColorColumn cterm=NONE ctermbg=233

" Show Vim commands in write bar
set showcmd

" Hide current vim mode from write line
set noshowmode

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
autocmd BufWritePre * :%s/\s\+$//e

" ================ Error Linting ====================

let g:syntastic_mode_map = { "mode": "passive" }

" Error symbols
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = "⚠"

" ================ Key Mappings =====================

" Ctrl-c to exit insert mode and save
inoremap <C-c> <esc>:w<cr>

" Ruby debugging
map <Leader>a orequire 'pry'<cr>binding.pry<esc>:w<cr>

" Rename files within Vim
map <Leader>e :Rename<space>

" System yank, paste, and delete
map <Leader>y "+y<cr>
map <Leader>p "+p<cr>
map <Leader>d "+d<cr>

" Use leader-i to properly indent lines depending on filetype
map <Leader>i mzgg=G`z<cr>

" ================ Vundle Initialization ============
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

if filereadable(expand("~/.vim/plugins.vim"))
  source ~/.vim/plugins.vim
endif

call vundle#end()
filetype plugin indent on

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.

if has('persistent_undo')
  if !isdirectory($HOME . "/.vim/backups")
    call mkdir($HOME . ".vim/backups", "p")
  endif
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
let g:neocomplete#force_overwrite_completefunc = 1

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Trigger configuration for snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" ================ Ctrlp Statusbar ==================
" No Statusbar upon entering Ctrlp
let g:ctrlp_buffer_func = {
      \ 'enter': 'Enter_ctrlp',
      \ 'exit':  'Exit_ctrlp',
      \ }

func! Enter_ctrlp()
  set laststatus=0
endfunc

func! Exit_ctrlp()
  set laststatus=2
endfunc

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
