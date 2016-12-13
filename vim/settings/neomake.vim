" Call Neomake on vim save
if has('nvim')
  au BufNewFile,BufRead,BufWritePost * Neomake

  let g:neomake_verbose = 0

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

  if executable('eslint')
    let g:neomake_javascript_enabled_makers = ['eslint']
  endif

  if executable('tslint')
    let g:neomake_typescript_enabled_makers = ['tslint']
  endif

  let g:neomake_html_enabled_makers = []
endif
