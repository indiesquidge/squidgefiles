" Call Neomake on vim save
if has('autocmd')
  autocmd! BufWritePost * Neomake
endif

" define Neomake warning/error symbols in gutter
let g:neomake_warning_sign = {
      \ 'text': '✹',
      \ }

let g:neomake_error_sign = {
      \ 'text': '✖',
      \ }

let g:neomake_typescript_tsc_maker = {
      \ 'args': [
      \ '-m', 'commonjs', '--noEmit', '--target', 'ES5', '--experimentalDecorators'
      \ ],
      \ 'errorformat':
      \ '%E%f %#(%l\,%c): error %m,' .
      \ '%E%f %#(%l\,%c): %m,' .
      \ '%Eerror %m,' .
      \ '%C%\s%\+%m'
      \ }

if executable('eslint')
  let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']
else
  echoe 'No eslint executable detected. Install eslint for JavaScript syntax higlighting. `npm install -g eslint`'
endif

if executable('tslint')
  let g:neomake_typescript_enabled_makers = ['tslint', 'tsc']
else
  echoe 'No tslint executable detected. Install tslint for TypeScript syntax higlighting. `npm install -g tslint`'
endif
