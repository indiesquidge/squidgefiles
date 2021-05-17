" Gutter signs
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '✹'

" Gutter sign colors
highlight ALEWarningSign ctermfg=227
highlight ALEErrorSign ctermfg=202

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint', 'tsserver'],
\ 'javascriptreact': ['eslint', 'tsserver'],
\ 'typescriptreact': ['eslint', 'tsserver'],
\ }

" Use ESLint if binary found
let eslint = finddir('node_modules', '.;') . '/.bin/eslint'

if executable(eslint)
  let eslint_config_prettier = finddir('node_modules', '.;') . '/eslint-config-prettier'

  if isdirectory(eslint_config_prettier)
    let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint'],
    \ 'javascriptreact': ['eslint'],
    \ 'typescriptreact': ['eslint'],
    \ }
  else
    let g:ale_fixers = {
    \ 'javascript': ['prettier'],
    \ 'typescript': ['prettier'],
    \ 'javascriptreact': ['prettier'],
    \ 'typescriptreact': ['prettier'],
    \ }
  endif
endif

" Fix linting errors automatically on buffer save
let g:ale_fix_on_save = 1

" Hotkeys to toggle ALE autofix
nnoremap <Leader>0 :let b:ale_fix_on_save = 0<cr>
nnoremap <Leader>1 :let b:ale_fix_on_save = 1<cr>
