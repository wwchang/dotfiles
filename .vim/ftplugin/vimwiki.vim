" colorscheme {{{
if &filetype ==? "vimwiki"
    " header,
    " hi Title           ctermfg=124 cterm=bold
    " hyperlink,
    hi Underlined      ctermfg=033                cterm=underline
    " un-existed hyperlink
    hi Normal          ctermfg=250 ctermbg=232
endif
" vimwiki header
" red: 124, orange: 202, blue: 039,
" cyan: 051, yellow: 226, green: 118
" red
hi VimwikiHeader1 ctermfg=124 ctermbg=232   cterm=bold
" green
hi VimwikiHeader2 ctermfg=118 ctermbg=232   cterm=bold
" blue
hi VimwikiHeader3 ctermfg=039 ctermbg=232   cterm=bold
" cyan
hi VimwikiHeader4 ctermfg=051 ctermbg=232   cterm=bold
" yellow
hi VimwikiHeader5 ctermfg=226 ctermbg=232   cterm=bold
" orange
hi VimwikiHeader6 ctermfg=202 ctermbg=232   cterm=bold
" }}}
