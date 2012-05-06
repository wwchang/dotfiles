au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx
 
" for mutt 
augroup filetypedetect
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END
" OR
" au BufRead /tmp/mutt-* set textwidth=72
