" No Statusbar upon entering Ctrlp
let g:ctrlp_buffer_func = {
      \ 'enter': 'Enter_ctrlp',
      \ 'exit':  'Exit_ctrlp',
      \ }

func! Enter_ctrlp()
  set laststatus=0
endfunc

func! Exit_ctrlp()
  set laststatus=2
endfunc
