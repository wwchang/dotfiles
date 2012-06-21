
" runtime! ftdetect/*.vim

augroup filetypedetect
    " CSS3
    autocmd BufRead,BufNewFile *.css set ft=css syntax=css3

    " Tmux
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux

    " Conky
    au BufRead,BufNewFile .conkyrc set filetype=conkyrc

    " Vimperator
    au BufRead,BufNewFile .vimperatorrc,vimperatorrc set filetype=vimperator
    au BufRead,BufNewFile *.vimp set filetype=vimperator

    " vimwiki
    au BufRead,BufNewFile *.{vimwiki,wiki} set filetype=vimwiki

    " Mutt mail
    au BufRead,BufNewFile /tmp/mutt-* set filetype=mail

    " Markdown
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown autoindent formatoptions=tcroqn2 comments=n:>

    " PostgreSQL
    au BufRead,BufNewFile *.psql set filetype=psql

    " UltiSnips.vim & SnipMate
    au BufRead,BufNewFile *.{snip,snippets,snippet}   set filetype=snippet
    au BufRead,BufNewFile *.snip   set filetype=snippet

    " Taskwarrior data files
    au BufRead,BufNewFile {pending,completed,undo}.data	set filetype=taskdata
    " Taskwarrior configuration file
    au BufRead,BufNewFile .taskrc				set filetype=taskrc
    au BufRead,BufNewFile taskrc				set filetype=taskrc
    " Taskwarrior handling of 'task 42 edit'
    au BufRead,BufNewFile *.task				set filetype=taskedit

    " Text
    au BufRead,BufNewFile *.{txt,text}   set filetype=text

    " gitconfig
    au BufRead,BufNewFile gitconfig* set filetype=gitconfig
    " gitignore
    au BufRead,BufNewFile gitignore* set filetype=gitignore
    " gitcommit
    au BufRead,BufNewFile COMMIT_EDITMSG set filetype=gitcommit
    " gitdiff

    " Engspchk plugin
    au BufNewFile,BufReadPost  *.eml setf mail

    " Go language
    au BufRead,BufNewFile *.go set filetype=go

    " Clojure
    autocmd BufRead,BufNewFile *.clj set filetype=clojure

    " JSON language.
    autocmd BufNewFile,BufRead *.json set filetype=json


    " Filetype detect for Assembly Language.
    autocmd BufRead,BufNewFile *.asm set ft=masm syntax=masm
    autocmd BufRead,BufNewFile *.inc set ft=masm syntax=masm
    autocmd BufRead,BufNewFile *.[sS] set ft=gas syntax=gas
    autocmd BufRead,BufNewFile *.hla set ft=hla syntax=hla
augroup END
