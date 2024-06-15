" ================ Installed plugins ================

" General-purpose fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File tree view
Plug 'scrooloose/nerdtree'

" Filetype-sensitive comments
Plug 'tomtom/tcomment_vim'

" Insert quotes, brackets, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Show Git diff in gutter of file
Plug 'airblade/vim-gitgutter'

" Statusbar
Plug 'itchyny/lightline.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" (Git)Hub wrapper
Plug 'tpope/vim-rhubarb'

" Collection of language packs
Plug 'sheerun/vim-polyglot'

" ripgrep in Vim
Plug 'jremmen/vim-ripgrep'

if executable('tmux')
  " Tmux bindings for Vim
  Plug 'christoomey/vim-tmux-navigator'

  " Make Vim autoread work properly in Tmux session
  Plug 'tmux-plugins/vim-tmux-focus-events'
endif

" Async plugins work in Vim8
if v:version >= 800
  " Asynchronous Lint Engine
  Plug 'w0rp/ale'
endif
