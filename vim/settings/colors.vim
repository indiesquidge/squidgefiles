" Syntax highlighting
syntax on

" Colorscheme
let g:seoul256_background = 233
colo seoul256

" General custom highlighting
hi Comment    ctermfg=242 cterm=italic
hi Include    cterm=italic
hi LineNr     ctermfg=246
hi MatchParen ctermfg=233 ctermbg=220 cterm=reverse
hi Todo       ctermbg=233
hi Visual     ctermfg=233 ctermbg=220

" Language-specific custom highlighting
hi jsExportDefault cterm=italic ctermfg=173
hi jsFuncArgs      cterm=italic ctermfg=179
hi jsThis          cterm=italic ctermfg=216
hi xmlAttrib       cterm=italic ctermfg=179

" Set 80 character ruler and colors
if exists('+colorcolumn')
  let &colorcolumn=join(range(81,999),",")
  highlight ColorColumn cterm=NONE ctermbg=233
endif

" Highlight current line and colors (must come last)
set cursorline
