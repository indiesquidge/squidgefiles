" ======================== General Config ========================

set visualbell            " No sounds
set number                " Line numbers
set showcmd               " Show Vim commands in write bar
set noshowmode            " Hide current vim mode from write line
set scrolloff=8           " 8 line vertical scroll buffer

" buffers exist like in normal editors
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Spacebar as global leader
let mapleader = "\<Space>"

" ===================== Vundle Initialization ====================

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

if filereadable(expand("~/.vim/plugins.vim"))
  source ~/.vim/plugins.vim
endif

call vundle#end()
filetype plugin indent on

" ========================= Key Mappings =========================

" Ctrl-c to exit insert mode and save
inoremap <C-c> <esc>:w<cr>

" Ruby debugging
map <Leader>a orequire "pry"; binding.pry<esc>:w<cr>

" Rename files within Vim
map <Leader>e :Rename<space>

" System yank, paste, and delete
map <Leader>y "+y<cr>
map <Leader>p "+p<cr>
map <Leader>d "+d<cr>

" Use leader-i to properly indent lines depending on filetype
map <Leader>i mzgg=G`z<cr>

" ======================== Persistent Undo =======================
" Keep undo history across sessions, by storing in file.

if has('persistent_undo')
  if !isdirectory($HOME . '/.vim/backups')
    call mkdir($HOME . '/.vim/backups', 'p')
  endif
  set undodir=~/.vim/backups
  set undofile
endif

" ========================= Indentation ==========================
" Results in spaces being used for all indentation

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Delete text present before insert mode
set backspace=2

" ============================ Folds =============================

set foldmethod=indent           "fold based on indent
set foldnestmax=3               "deepest fold is 3 levels
set nofoldenable                "dont fold by default

" ====================== Turn Off Swap Files =====================

set noswapfile
set nobackup
set nowb

" ======================== Custom Config =========================
" Colors, completion, statusbar, linting, etc.

source ~/.dotfiles/vim/settings.vim
