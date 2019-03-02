" ================ Installed plugins ================

" General-purpose fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Markdown syntax highlighting
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }

" JavaScript syntax highlighting and indentation
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx', 'markdown', 'md'] }

" JSX highlighting
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx', 'markdown', 'md'] }

" Heuristically set buffer indentation
Plug 'tpope/vim-sleuth'

" ripgrep in Vim
Plug 'jremmen/vim-ripgrep'

if executable('tmux')
  " Tmux bindings for Vim
  Plug 'christoomey/vim-tmux-navigator'

  " Make Vim autoread work properly in Tmux session
  Plug 'tmux-plugins/vim-tmux-focus-events'
endif

" Async plugins work in Vim8 or Neovim
if v:version >= 800 || has('nvim')
  " Asynchronous keyword completion, requires (neo)vim python module and ternJS
  Plug 'maralla/completor.vim', { 'do': 'make js' }

  " Asynchronous Lint Engine
  Plug 'w0rp/ale'
endif
