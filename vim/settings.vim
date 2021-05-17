" Remember last line position on buffer exit
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
      \ | exec "normal! g'\"" | endif

" Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Syntax highlighting
syntax on

" Colorscheme
let g:seoul256_background = 233
colo seoul256

" General custom highlighting
hi Comment    ctermfg=242 cterm=italic
hi LineNr     ctermfg=246
hi MatchParen ctermfg=233 ctermbg=220 cterm=reverse
hi Visual     ctermfg=233 ctermbg=220
hi Special    cterm=italic
hi Type       cterm=italic

" Set 100 character ruler and colors
if exists('+colorcolumn')
  let &colorcolumn=join(range(101,999),",")
  highlight ColorColumn cterm=NONE ctermbg=233
endif

" Highlight current line and colors (must come last)
set cursorline

let vimsettings = '~/.vim/settings'

for fpath in split(globpath(vimsettings, '*.vim'), '\n')
  exe 'source' fpath
endfor
