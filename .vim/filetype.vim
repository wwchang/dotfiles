
" runtime! ftdetect/*.vim

if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    " CSS3
    autocmd BufRead,BufNewFile *.css set ft=css syntax=css3

    " Markdown
    au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=markdown autoindent formatoptions=tcroqn2 comments=n:>

    " PostgreSQL
    au BufRead,BufNewFile *.psql set filetype=psql

    " Git
    " gitconfig
    au BufRead,BufNewFile gitconfig* set filetype=gitconfig
    " gitignore
    au BufRead,BufNewFile gitignore* set filetype=gitignore
    " gitcommit
    au BufRead,BufNewFile COMMIT_EDITMSG set filetype=gitcommit
    " gitdiff

    " Go language
    au BufRead,BufNewFile *.go set filetype=go

    " Lisp
    au BufRead,BufNewFile *.{lisp,cl} set filetype=lisp

    " Clojure
    autocmd BufRead,BufNewFile *.clj set filetype=clojure

    " JSON language.
    autocmd BufNewFile,BufRead *.json set filetype=json


    " Filetype detect for Assembly Language.
    autocmd BufRead,BufNewFile *.{asm,inc} set ft=masm syntax=masm
    autocmd BufRead,BufNewFile *.[sS] set ft=gas syntax=gas
    autocmd BufRead,BufNewFile *.hla set ft=hla syntax=hla

    " Ruby
    " *.rb
    " Ruby document
    autocmd BufNewFile,BufRead *.{rd,rdoc} set filetype=rdoc

    " Text
    au BufRead,BufNewFile *.{txt,text}   set filetype=text

    " Tmux
    au BufNewFile,BufRead .tmux.conf*,tmux.conf* set filetype=tmux

    " Conky
    au BufRead,BufNewFile .conkyrc set filetype=conkyrc

    " Vimperator
    au BufRead,BufNewFile .vimperatorrc,*vimperatorrc* set filetype=vimperator
    au BufRead,BufNewFile *.vimp set filetype=vimperator

    " vimwiki
    au BufRead,BufNewFile *.{vimwiki,wiki} set filetype=vimwiki

    " Mutt mail
    au BufRead,BufNewFile /tmp/mutt-* set filetype=mail

    " Debian sources list
    autocmd BufNewFile,BufRead sources.list set filetype=debsources

    " UltiSnips
    au BufRead,BufNewFile *.snippets set filetype=snippets
    " neosnippet
    au BufRead,BufNewFile *.snip set filetype=snipppet

    " Engspchk plugin
    au BufNewFile,BufReadPost  *.eml set filetype=mail

    " Taskwarrior data files
    au BufRead,BufNewFile {pending,completed,undo}.data	set filetype=taskdata
    " Taskwarrior configuration file
    au BufRead,BufNewFile .taskrc				set filetype=taskrc
    au BufRead,BufNewFile taskrc				set filetype=taskrc
    " Taskwarrior handling of 'task 42 edit'
    au BufRead,BufNewFile *.task				set filetype=taskedit
augroup END
