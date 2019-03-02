" ======================== General Config ========================

set visualbell            " No sounds
set number                " Line numbers
set showcmd               " Show Vim commands in write bar
set noshowmode            " Hide current vim mode from write line
set scrolloff=8           " 8 line vertical scroll buffer
set autoread              " Update contents when file changes outside of buffer
set mouse=a               " Enable mouse support
set encoding=utf-8        " Always use UTF-8 character encoding

" buffers exist like in normal editors
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" ===================== Plug Initialization ====================

call plug#begin()

if filereadable(expand("~/.vim/plugins.vim"))
  source ~/.vim/plugins.vim
endif

" Machine-specific settings (e.g. work vs. home computer, remote server, etc.)
if !empty(glob("$HOME/.vimrc_local"))
  source $HOME/.vimrc_local
endif

call plug#end()

" ========================= Key Mappings =========================

" Spacebar as global leader
let mapleader = "\<Space>"

" Ctrl-c to exit insert mode
inoremap <C-c> <esc>

" ripgrep search
map <Leader>s :Rg<space>

" Toggle NERDTree sidebar
map <Leader>n :NERDTreeToggle<CR>

" System yank, paste, and delete
map <Leader>y "+y
map <Leader>p "+p
map <Leader>d "+d

" Properly indent file contents
map <Leader>i mzgg=G`z

" FZF fuzzy finder controls
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>f :BLines<cr>
nnoremap <C-p> :FZF<cr>

" ======================== Persistent Undo =======================
" Keep undo history across sessions, by storing in file.

if has('persistent_undo')
  if !isdirectory($HOME . '/.vim/backups')
    call mkdir($HOME . '/.vim/backups', 'p')
  endif
  set undodir=~/.vim/backups
  set undofile
endif

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
" Colors, completion, statusbar, linting, and all other custom settings

source ~/.dotfiles/vim/settings.vim
