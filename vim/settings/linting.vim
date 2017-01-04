" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Spellchecking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Call Neomake on vim save
if has('nvim')
  au BufNewFile,BufRead,BufWritePost * Neomake

  let g:neomake_verbose = 0

  " show Standard linting as errors by default
  let g:neomake_javascript_standard_maker = { 'errorformat': '%E %f:%l:%c: %m' }

  " define Neomake warning/error colors and symbols in gutter
  :highlight NeomakeWarningMsg ctermfg=227 ctermbg=237 " yellow
  :highlight NeomakeErrorMsg ctermfg=202 ctermbg=237   " red

  let g:neomake_warning_sign = {
        \ 'text': '✹',
        \ 'texthl': 'NeomakeWarningMsg',
        \ }

  let g:neomake_error_sign = {
        \ 'text': '✖',
        \ 'texthl': 'NeomakeErrorMsg',
        \ }

  " if eslintrc file present use eslint, else use standard
  if findfile('.eslintrc', '.;') !=# ''
    " unfortunately have to set both filetype makers
    " https://github.com/neomake/neomake/issues/572
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:neomake_jsx_enabled_makers = ['eslint']
    " load local eslint in the project root to avoid global plugin installations
    let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
    let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
  else
    let g:neomake_javascript_enabled_makers = ['standard']
    let g:neomake_jsx_enabled_makers = ['standard']
  endif

  let g:neomake_html_enabled_makers = []
endif
