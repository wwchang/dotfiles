" syntax highlight
let python_highlight_all=1
let python_slow_sync=1 " for fast machines

" Tab
setlocal expandtab " In insert mode, use appropriate number of spaces to insert a <Tab>
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal smarttab

" indent
setlocal autoindent

" fold
setlocal foldenable
setlocal foldmethod=indent
setlocal foldlevel=99

" character, signs, keyword
" the words with bellowing characters does not been wrapped line and split.
setlocal iskeyword+=_,$,@,%,#,-
