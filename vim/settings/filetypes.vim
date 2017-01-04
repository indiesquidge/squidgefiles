au BufNewFile,BufRead *.plug set filetype=vim
au BufNewFile,BufRead *{tslint,eslint,jshint}rc set filetype=json

" JSX syntax and indentation in normal JS files by default
let g:jsx_ext_required = 0
