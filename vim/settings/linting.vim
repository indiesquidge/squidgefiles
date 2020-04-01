" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

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

let g:ale_linters['ruby'] = ['rubocop']
let g:ale_ruby_rubocop_options = '--config ~/airlab/repos/airbnb/.rubocop.yml'

let g:ale_linters['graphql'] = ['gqlint']

" Fix linting errors automatically on buffer save
let g:ale_fix_on_save = 1
