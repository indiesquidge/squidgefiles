" ================ Installed plugins ================

" Fuzzy searcher
Plug 'kien/ctrlp.vim'

" File tree view
Plug 'scrooloose/nerdtree'

" Tmux bindings for Vim
Plug 'christoomey/vim-tmux-navigator'

" Filetype-sensitive comments
Plug 'tomtom/tcomment_vim'

if has('nvim')
  " Asynchronous keyword completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Asynchronous Lint Engine
  Plug 'w0rp/ale'
endif

" Insert quotes, brackets, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Show Git diff in gutter of file
Plug 'airblade/vim-gitgutter'

" Statusbar
Plug 'itchyny/lightline.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Markdown syntax highlighting
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }

" JavaScript syntax highlighting and indentation
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'markdown', 'md'] }

" JSX highlighting
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx', 'markdown', 'md'] }

" Heuristically set buffer indentation
Plug 'tpope/vim-sleuth'

" 'ag' in Vim
Plug 'rking/ag.vim'

" Make Vim autoread option work properly in Tmux session
Plug 'tmux-plugins/vim-tmux-focus-events'
