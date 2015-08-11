" Syntax highlighting
syntax on

" Colorscheme
se t_Co=16
let g:seoul256_background = 233
colo seoul256

" comment and visual mode highlight colors
hi Comment ctermfg=DarkGrey
hi Visual  ctermbg=215 ctermfg=232

" Line number color
highlight LineNr ctermfg=246

" Matching brackets, parens, etc. color
highlight MatchParen cterm=bold ctermbg=057 ctermfg=white

" Set 80 character ruler and colors
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn cterm=NONE ctermbg=233

" Highlight current line and colors (must come last)
set cursorline
