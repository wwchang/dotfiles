" indent {{{
setlocal autoindent
setlocal smartindent
setlocal cindent
" }}}

" fold {{{
setlocal foldenable
setlocal foldnestmax=1
setlocal foldmethod=syntax
" }}}

" completion {{{
setlocal omnifunc=ccomplete#Complete
" }}}

" wild menu & mode

" tags {{{
" ; means recurse upwards to deep under your project.
setlocal tags+=./tags;/
  " walk up the tree towards root until one is found
" }}}

" cscope {{{
setlocal cscopetag " use both cscope and ctags
setlocal cscopeverbose " show msg when cscope database added
setlocal cscopetagorder=1 " 0: cscope, 1: ctags
setlocal cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i- " use quickfix to show result
" }}}
