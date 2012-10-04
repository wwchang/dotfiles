let g:vimsyn_embed = "mpPr" " embed script highlight: perl,python,ruby,tcl
let g:vimsyn_folding = 'afmpPr' " augroup, function, perl, python, ruby
let g:vimsyn_noerror = 1 " suppress error highlighting.

" [ run/execution ] {{{ TODO merge this three mode into one.
" range
function! VimLRangeSource() range
    let tmpsofile = tempname()
    call writefile(getline(a:firstline, a:lastline), l:tmpsofile)
    execute "source " . l:tmpsofile
    call delete(l:tmpsofile)
endfunction

" visual
" V -> "ay -> :@a

command! -range VimL <line1>,<line2>call VimLRangeSource()
vnoremap <silent><buffer> <F5> <esc>:'<,'>:VimL<cr>

" file
" nnoremap <F5> :source %<cr>
nnoremap <silent><buffer> <F5> :exec 'source ' . bufname('%')<CR>
" }}}
