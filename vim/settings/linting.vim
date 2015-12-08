let g:syntastic_mode_map = { 'mode': 'passive',
  \ 'active_filetypes': ['typescript'], }
let g:syntastic_stl_format = '%E{Err: %fe}%B{, }%W{Warn: %fw}'

function! HasConfig(file, dir)
  return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endfunction

" If project has .eslintrc file, use eslint; else, default to jshint (faster)
autocmd BufNewFile,BufReadPre *.js  let b:syntastic_checkers =
      \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
      \     ['jshint']

let g:syntastic_typescript_checkers = ['tslint', 'tsc']

" Error symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Spellchecking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Allow JSX in normal JS files
let g:jsx_ext_required = 0
