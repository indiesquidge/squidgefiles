" Syntax highlighting
syntax on

" Colorscheme
let g:seoul256_background = 233
colo seoul256

" General custom highlighting
hi MatchParen cterm=reverse ctermbg=220 ctermfg=232
hi Comment cterm=italic ctermfg=DarkGrey
hi Include cterm=italic
hi jsFuncArgs cterm=italic ctermfg=217
hi Visual ctermbg=220 ctermfg=232
hi Search cterm=reverse ctermfg=220 ctermbg=234
hi LineNr ctermfg=246

" Language-specific custom highlighting
hi xmlAttrib cterm=italic ctermfg=179
hi jsExportDefault cterm=italic ctermfg=179

" Set 80 character ruler and colors
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn cterm=NONE ctermbg=233

" Highlight current line and colors (must come last)
set cursorline
