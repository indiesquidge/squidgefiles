" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Spellchecking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Gutter signs
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '✹'

" Gutter sign colors
highlight ALEWarningSign ctermfg=227
highlight ALEErrorSign ctermfg=202

" Use StandardJS if binary found, otherwise prefer global ESLint and Prettier
let local_standard = finddir('node_modules', '.;') . '/.bin/standard'
if executable(local_standard)
  let g:ale_linters = {
  \ 'javascript': ['standard'],
  \ }

  let local_babel_eslint = finddir('node_modules', '.;') . '/babel-eslint'

  if isdirectory(local_babel_eslint)
    let g:ale_javascript_standard_options = '--parser babel-eslint'
  endif
else
  let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ }

  let g:ale_fixers = {
  \ 'javascript': ['prettier'],
  \}
endif

" Fix linting errors automatically on buffer save
let g:ale_fix_on_save = 1
