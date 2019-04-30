" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Gutter signs
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '✹'

" Gutter sign colors
highlight ALEWarningSign ctermfg=227
highlight ALEErrorSign ctermfg=202

" Use StandardJS or ESLint if binary found, otherwise prefer global ESLint and Prettier
let local_standard = finddir('node_modules', '.;') . '/.bin/standard'
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'

if executable(local_standard)
  let g:ale_linters = {
  \ 'javascript': ['standard'],
  \ }

  let local_babel_eslint = finddir('node_modules', '.;') . '/babel-eslint'

  if isdirectory(local_babel_eslint)
    let g:ale_javascript_standard_options = '--parser babel-eslint'
  endif

elseif executable(local_eslint)
  let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint', 'tsserver'],
  \ }
  let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \ }

else
  let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ }

  let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \ 'markdown': ['prettier'],
  \ }
endif

let g:ale_linters['ruby'] = ['rubocop']
let g:ale_ruby_rubocop_options = '--config ~/airlab/repos/airbnb/.rubocop.yml'

let g:ale_linters['graphql'] = ['gqlint']

" Fix linting errors automatically on buffer save
let g:ale_fix_on_save = 1
