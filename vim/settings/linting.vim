" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Spellchecking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Call Neomake on vim save
if has('nvim')
  " show Standard linting as errors by default
  let g:neomake_javascript_standard_maker = { 'errorformat': '%E %f:%l:%c: %m' }
  let g:neomake_jsx_standard_maker = { 'errorformat': '%E %f:%l:%c: %m' }

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

  let g:neomake_javascript_enabled_makers = ['standard']
  let g:neomake_jsx_enabled_makers = ['standard']

  " if a project has a custom eslint config, prefer it over standard
  if findfile('.eslintrc', '.') !=# '' || (filereadable('package.json') && match(readfile('package.json'), 'eslintConfig') != -1)
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:neomake_jsx_enabled_makers = ['eslint']
    let g:neomake_javascript_eslint_exe = $PWD . '/node_modules/.bin/eslint'
  endif

  let g:neomake_html_enabled_makers = []

  autocmd! BufWritePost * Neomake
endif
