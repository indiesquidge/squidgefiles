" Call Neomake on vim save
au BufNewFile,BufRead,BufWritePost * Neomake

let g:neomake_verbose = 0

" define Neomake warning/error symbols in gutter
let g:neomake_warning_sign = {
      \ 'text': '✹',
      \ }

let g:neomake_error_sign = {
      \ 'text': '✖',
      \ }

if executable('eslint')
  let g:neomake_javascript_enabled_makers = ['eslint']
else
  echoe 'No eslint executable detected. Install eslint for JavaScript syntax higlighting. `npm install -g eslint`'
endif

if executable('tslint')
  let g:neomake_typescript_enabled_makers = ['tslint']
else
  echoe 'No tslint executable detected. Install tslint for TypeScript syntax higlighting. `npm install -g tslint`'
endif

let g:neomake_html_enabled_makers = []
