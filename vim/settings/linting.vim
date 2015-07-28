let g:syntastic_mode_map = { "mode": "passive" }

" Error symbols
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = "⚠"

" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Spellchecking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell