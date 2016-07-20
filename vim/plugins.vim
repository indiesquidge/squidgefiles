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
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
endif

" Insert quotes, brackets, etc. in pairs
Plug 'jiangmiao/auto-pairs'

" Show Git diff in gutter of file
Plug 'airblade/vim-gitgutter'

" Statusbar
Plug 'indiesquidge/lightline.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" snippets
Plug 'mattn/emmet-vim'

" Markdown syntax highlighting
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }

" JavaScript syntax highlighting and indentation
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }

" JSX highlighting
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

" TypeScript omni-completion, definition locations, compilation errors, etc. (depends on vimproc)
Plug 'shougo/vimproc.vim', { 'do': 'make' } | Plug 'Quramy/tsuquyomi', { 'for': ['typescript', 'typescript.jsx'] }

" TypeScript Syntax
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }

" TSX highlighting
Plug 'ianks/vim-tsx', { 'for': ['typescript', 'typescript.jsx'] }

" Heuristically set buffer options
Plug 'tpope/vim-sleuth'

" 'ag' in Vim
Plug 'rking/ag.vim'
