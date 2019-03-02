" Remember last line position on buffer exit
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
      \ | exec "normal! g'\"" | endif
