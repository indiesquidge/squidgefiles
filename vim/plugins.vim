" ================ Installed plugins ================

" Fuzzy searcher
Plug 'kien/ctrlp.vim'

" File tree view
Plug 'scrooloose/nerdtree'

" Asynchronous Error linting
Plug 'benekastah/neomake'

" Easily switch between vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Easy to use, file-type sensitive comments
Plug 'tomtom/tcomment_vim'

" Asynchronous keyword completion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Insert quotes, brackets, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Show Git diff in gutter of file
Plug 'airblade/vim-gitgutter'

" Statusbar
Plug 'itchyny/lightline.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Rename files from within Vim
Plug 'danro/rename.vim'

" snippets
Plug 'mattn/emmet-vim'

" Markdown syntax highlighting
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }

" JavaScript syntax highlighting and indentation
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

" JSX highlighting
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" Heuristically set buffer options
Plug 'tpope/vim-sleuth'

" 'ag' in Vim
Plug 'rking/ag.vim'
