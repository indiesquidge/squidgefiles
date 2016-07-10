autocmd BufRead,BufNewFile *.ts,*.d.ts setlocal filetype=typescript
autocmd BufRead,BufNewFile *.tsx setlocal filetype=typescript
autocmd FileType typescript setlocal completeopt-=preview completeopt+=menu
