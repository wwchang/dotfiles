" syntax highlight
let python_highlight_all=1
let python_slow_sync=1 " for fast machines

" Tab
setlocal expandtab " Insert mode, use appropriate spaces to replace a <Tab>
" indent with 4 spaces.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal smarttab

" indent
setlocal autoindent

" fold
setlocal foldenable
setlocal foldmethod=indent
setlocal foldlevelstart=0
setlocal foldlevel=99

" character, signs, keyword
" the words with bellowing characters does not been wrapped line and split.
setlocal iskeyword+=_,$,@,%,#,-

" comment spell checker (do not do spell check on code. [smart])
setlocal spell

" omni-complete
" if has('python3/dyn') || has('python/dyn') || has('python3') || has('python')
if has('python3/dyn') || has('python3')
    setlocal omnifunc=python3complete#Complete " for Python 3.x
elseif has('python/dyn') || has('python')
    setlocal omnifunc=pythoncomplete#Complete " for Python 2.x
endif

" help (K)
setlocal keywordprg=pydoc

" REPL : run/execution
python << EOF
import vim
def EvaluateRangeCode():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOF
vnoremap <F5> :py EvaluateRangeCode()<CR>

" FIXME if module is a directory ??? e.g. import sys
" 'gf' jump to the filename under the cursor. like 'import module'.
" add python runtime path into vim option 'path'.
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
	vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
