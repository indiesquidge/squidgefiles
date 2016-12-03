au BufNewFile,BufRead *.plug set filetype=vim
au BufNewFile,BufRead *{tslint,eslint,jshint}rc set filetype=json

" auto-wrap lines if they are over 80 characters
au FileType markdown set tw=80
