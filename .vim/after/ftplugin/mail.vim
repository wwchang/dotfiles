"" ============================================================================
""   ~/.vim/ftplugin/mail.vim
""   stardiviner [Gmail: numbchild]
"" ============================================================================

" TODO
" 1. hide some useless text for mutt.
" 2. highlight some special part like git diff. like language code.
" 3. use some cool Vim features on this. like conceal, fold. etc

" Setup to write mails with vim
" To use with Mutt, just put this line your ~/.vimrc :
"   autocmd BufRead /tmp/mutt*      :source ~/.vim/mail

""   Spell
set spell

" Engspchk plugin.
" in ~/.vim/after/syntax/mail.vim
" if (expand("%") != "") && !&diff && (v:progname !~ "vimdiff")
"     normal \ec
" endif

""   Automatic line wrap
" set textwidth=72	" max line length
" set formatoptions=tcql

" comment {{{
set comments=n:>
set comments+=n:\|	" '|' is a quote char.
set comments+=n:%	" '%' as well.
" }}}


" functions {{{
""   Suppressing quoted signature(s) if any when replying
function! Mail_Erase_Sig_old()
    let i = line('$')
    let j = i
    " search for the signature pattern (takes into account signature delimiters
    " from broken mailers that forget the space after the two dashes)
    while ((i > 0) && (getline(i) !~ '^> *-- \=$'))
        if (getline(i) =~ '^-- $')
            " this is my own sig. please don't delete it!
            let j = i - 1
        endif
        let i = i - 1
    endwhile

    " if found, then
    if (i != 0)
        " search for the last non empty (non sig) line
        while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
            let i = i - 1
        endwhile
        " and delete those lines plus the signature
        exe ':'.i.','.j.'d'
    endif
endfunction

" this new version handles cases where there are several signatures
" (sometimes added by mailing list software)
function! Mail_Erase_Sig()
    " search for the signature pattern (takes into account signature delimiters
    " from broken mailers that forget the space after the two dashes)
    let i = 0
    while ((i <= line('$')) && (getline(i) !~ '^> *-- \=$'))
        let i = i + 1
    endwhile

    " if found, then
    if (i != line('$') + 1)
        " first, look for our own signature, to avoid deleting it
        let j = i
        while (j < line('$') && (getline(j + 1) !~ '^-- $'))
            let j = j + 1
        endwhile

        " second, search for the last non empty (non sig) line
        while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
            let i = i - 1
        endwhile

        " third, delete those lines plus the signature
        exe ':'.i.','.j.'d'
    endif
endfunction


"" ----------------------------------------------------------------------------
""   Replacing empty quoted lines (e.g. "> $") with empty lines
""   (convenient to automatically reformat one paragraph)
"" ----------------------------------------------------------------------------

function! Mail_Del_Empty_Quoted()
    exe "normal :%s/^>[[:space:]\%\|\#>]\\+$//e\<CR>"
endfunction

""   Moving the cursor at the begining of the mail
function! Mail_Begining()
    exe "normal gg"
    if getline (line ('.')) =~ '^From: '
        " if we use edit_headers in Mutt, then go after the headers
        exe "normal /^$\<CR>"
    endif
endfunction
" }}}

" initialization {{{
" call Mail_Erase_Sig()
call Mail_Del_Empty_Quoted()
call Mail_Begining()

au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L
" }}}

" fold {{{
setlocal foldmethod=expr foldlevel=1 foldminlines=2
setlocal foldexpr=strlen(substitute(substitute(getline(v:lnum),'\\s','','g'),'[^>].*','',''))
" }}}

" lbdb function to complete {{{
fun! LBDBCompleteFn(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '[^:,]'
            let start -= 1
        endwhile
        while start < col('.') && line[start] =~ '[:, ]'
            let start += 1
        endwhile
        return start
    else
        let res = []
        let query = substitute(a:base, '"', '', 'g')
        let query = substitute(query, '\s*<.*>\s*', '', 'g')
        for m in LbdbQuery(query)
            call add(res, printf('"%s" <%s>', escape(m[0], '"'), m[1]))
        endfor
        return res
    endif
endfun

" set completefunc=LBDBCompleteFn
" ino <C-n> <C-X><C-U>
" ino <C-p> <C-X><C-U>
" }}}

" vim:fdm=marker
