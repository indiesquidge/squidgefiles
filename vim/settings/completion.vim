" Stuff to ignore when tab completing
set wildmode=list:longest
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=node_modules/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.class,*.jar
set wildignore+=*.pdf
set wildignore+=*/tmp/*,*.o,*.so,*.swp,*.zip,*/node_modules/*,*/bower_components/*

" Autocompletion Deoplete
" Enable deoplete at vim startup
let g:deoplete#enable_at_startup = 1
" Set patterns for TypeScript autocompletion
let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
let g:deoplete#omni#input_patterns.typescript = ['[^. \t0-9]\.\w*']

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Trigger configuration for snippets
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
