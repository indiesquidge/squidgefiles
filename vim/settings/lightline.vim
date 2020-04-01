" Enable status bar always
set laststatus=2

" Lightline config
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', ], [ 'fugitive', 'readonly', 'filename' ] ],
      \   'right': [ [ 'column', 'lineinfo' ], [ 'filetype' ] ]
      \ },
      \ 'component': {
      \   'column': '%c'
      \ },
      \ 'component_function': {
      \   'mode': 'LightLineMode',
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'filetype': 'MyFiletype',
      \   'lineinfo': 'MyLineInfo',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

" Lightline functions
function! LightLineMode()
  return winwidth(0) > 30 ? lightline#mode() : lightline#mode()[0]
endfunction

function! MyFugitive()
  if exists('*FugitiveHead')
    let _ = FugitiveHead()
    return winwidth(0) > 70 ? (strlen(_) ? '⭠ '._ : '') : ''
  endif
  return ''
endfunction

function! MyReadonly()
  return &readonly ? '⭤' : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyLineInfo()
  return winwidth(0) > 60 ? '⭡ ' . line('.') . '/' . line('$') : ''
endfunction
