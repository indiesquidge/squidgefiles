autocmd BufRead,BufNewFile *.ts setlocal filetype=typescript
autocmd BufRead,BufNewFile *.tsx setlocal filetype=typescript
autocmd BufNewFile,BufRead *.d.ts setfiletype typescript syntax=typescript
autocmd FileType typescript setlocal completeopt-=preview completeopt+=menu
