" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
" Vimhelp: :help group-name :help syntax.txt
" term={attr-list}
"   - bold, underline, undercurl, reverse, inverse, italic, bold, none.

" checks whether an earlier file has defined a syntax already. If so, exits with finish.
if exists("b:current_syntax")
    finish
endif

set background=dark " dark or light

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif

hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74  gui=italic
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#FFFFFF guibg=#F92672
hi iCursor         guifg=#66D9EF
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#960050 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi vimFold         guifg=#FFFFFF guibg=#000000 gui=bold
hi Folded          guifg=#465457 guibg=#000000 gui=bold
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" Pop complete menu
hi Pmenu           guifg=#000000 guibg=#FFFFFF
hi PmenuSel        guifg=#080808 guibg=#FE0086 gui=italic
hi PmenuSbar       guifg=#080808 guibg=#AEFE00
hi PmenuThumb      guifg=#FE0086

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#FFFFFF  guibg=#455354
" marks column
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
hi SpecialKey      guifg=#888A85               gui=italic

hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#127AFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#FF5F87 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

if s:molokai_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E gui=italic
   hi CursorLine                    guibg=#3E3D32
   hi CursorColumn                  guibg=#3E3D32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#BCBCBC guibg=#3B3A32
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
   hi Comment         guifg=#465457 gui=italic
   hi CursorLine                    guibg=#293739
   hi CursorColumn                  guibg=#293739
   hi LineNr          guifg=#BCBCBC guibg=#232526
   hi NonText         guifg=#BCBCBC guibg=#232526
   hi ColorColumn     guifg=none    guibg=#282828

    if has("spell")
        hi SpellBad    guisp=#FF0000 gui=undercurl
        hi SpellCap    guisp=#7070F0 gui=undercurl
        hi SpellLocal  guisp=#70F0F0 gui=undercurl
        hi SpellRare   guisp=#FFFFFF gui=undercurl
    endif

end

"
" Support for 256-color terminal
"
if &t_Co > 255
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   " String: string in quote 'string'
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Conceal         ctermfg=039  ctermbg=236  cterm=bold
   hi Cursor          ctermfg=255  ctermbg=197  cterm=underline
   hi iCursor         ctermfg=081               cterm=underline
   hi Debug           ctermfg=196               cterm=bold
   hi Define          ctermfg=081
   hi Delimiter       ctermfg=241

   hi DiffAdd         ctermfg=none ctermbg=022 cterm=none
   hi DiffDelete      ctermfg=none ctermbg=088 cterm=none
   hi DiffChange      ctermfg=none ctermbg=233 cterm=bold
   hi DiffText        ctermfg=none ctermbg=053 cterm=none

   hi Directory       ctermfg=118   ctermbg=none    cterm=bold
   hi Error           ctermfg=none  ctermbg=160     cterm=underline
   hi ErrorMsg        ctermfg=196   ctermbg=232     cterm=bold
   hi Exception       ctermfg=118                   cterm=bold
   hi Float           ctermfg=135

   " fold
   hi Folded          ctermfg=045   ctermbg=234 cterm=bold
   hi FoldColumn      ctermfg=045   ctermbg=016 cterm=bold
   hi vimFold         ctermfg=081   ctermbg=016 cterm=bold

   hi Function        ctermfg=118               cterm=bold
   hi Identifier      ctermfg=208               cterm=bold
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=196 ctermbg=016

   hi Keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193               cterm=none

   " brackets match color
   hi MatchParen      ctermfg=016  ctermbg=046 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161  ctermbg=016 cterm=bold

" Pop complete menu   154 brightgreen  198 pink  038 light blue
   hi Pmenu           ctermfg=016 ctermbg=255  cterm=none
   hi PmenuSel        ctermfg=016 ctermbg=038  cterm=none
   hi PmenuSbar       ctermfg=203 ctermbg=016  cterm=none
   " scroll forward small bar
   hi PmenuThumb      ctermfg=198              cterm=none

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=081
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=232 ctermbg=154   cterm=bold

   " marks column
   hi SignColumn      ctermfg=161 ctermbg=none
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=081  ctermbg=232  cterm=bold

   hi Statement       ctermfg=161               cterm=bold
   " hi StatusLine      ctermfg=255 ctermbg=232
   hi StatusLine      ctermfg=236 ctermbg=255
   " NC = not current
   hi StatusLineNC    ctermfg=016 ctermbg=076

   " add for vimrc statusline
   hi StatusNormal       ctermfg=248 ctermbg=236 cterm=none
   hi StatusStop         ctermfg=248 ctermbg=236 cterm=none
   hi StatusSeparator    ctermfg=064 ctermbg=016 cterm=bold
   hi StatusBufferNumber ctermfg=250 ctermbg=236 cterm=bold
   hi StatusReadOnly     ctermfg=196 ctermbg=236 cterm=bold
   hi StatusModFlag      ctermfg=196 ctermbg=236 cterm=bold
   hi StatusModFlag2     ctermfg=046 ctermbg=236 cterm=none
   hi StatusList         ctermfg=106 ctermbg=236 cterm=none
   hi StatusChar         ctermfg=045 ctermbg=236 cterm=bold
   hi StatusFileType     ctermfg=204 ctermbg=236 cterm=bold
   hi StatusProgramInfo  ctermfg=076 ctermbg=236 cterm=bold
   hi StatusFugitive     ctermfg=190 ctermbg=236 cterm=bold
   hi StatusHELP         ctermfg=249 ctermbg=236 cterm=none
   hi StatusFilePath     ctermfg=248 ctermbg=236 cterm=none
   hi StatusLineNumber   ctermfg=104 ctermbg=236 cterm=none
   hi StatusPercent      ctermfg=202 ctermbg=236 cterm=bold

   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=081
   hi Tag             ctermfg=161 ctermbg=236   cterm=bold
   hi Title           ctermfg=124               cterm=bold
   hi Todo            ctermfg=033 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=081 ctermbg=236    cterm=bold
   hi Type            ctermfg=081                cterm=bold
   hi Underlined      ctermfg=033                cterm=underline

   hi VertSplit       ctermfg=236 ctermbg=232   cterm=bold
   hi VisualNOS       ctermfg=none ctermbg=238  cterm=none
   hi Visual          ctermfg=none ctermbg=024  cterm=bold
   hi WarningMsg      ctermfg=197 ctermbg=232   cterm=bold
   hi WildMenu        ctermfg=045 ctermbg=016   cterm=bold

   hi Normal          ctermfg=252 ctermbg=232
   hi Comment         ctermfg=240 cterm=italic
   " cursor line & column
   hi CursorLine      ctermfg=none ctermbg=233   cterm=bold
   hi CursorColumn    ctermfg=none ctermbg=233   cterm=none

   " line number
   hi LineNr          ctermfg=235 ctermbg=232

   " listchars
   hi NonText         ctermfg=087 ctermbg=none cterm=none
   hi SpecialKey      ctermfg=051 ctermbg=none cterm=none

   " tabs
   hi TabLine         ctermfg=244 ctermbg=233   cterm=none
   hi TabLineSel      ctermfg=233 ctermbg=118   cterm=none
   hi TabLineFill     ctermfg=233 ctermbg=233   cterm=none

   hi ColorColumn     ctermfg=none ctermbg=233  cterm=none

   hi link htmlLink         Underlined
   hi link pythonFunction   Identifier

    "if has("spell")
        "hi SpellBad       ctermfg=016 ctermbg=197
        "hi SpellCap       ctermfg=016 ctermbg=203
        "hi SpellLocal     ctermfg=none ctermbg=117
        "hi SpellRare      ctermfg=none ctermbg=214
    "endif

end

" Vimwiki: {{{
if &filetype ==? "vimwiki"
   " header,
   " hi Title           ctermfg=124 cterm=bold
   " hyperlink,
   hi Underlined      ctermfg=033                cterm=underline
   " un-existed hyperlink
   hi Normal          ctermfg=242 ctermbg=232
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

" {{{ for Tagbar.vim
    " cyan
    highlight TagbarHighlight       ctermfg=051 ctermbg=none cterm=bold
    " gray
    highlight TagbarComment         ctermfg=238 ctermbg=none cterm=none
    " green
    highlight TagbarKind            ctermfg=154 ctermbg=none cterm=bold,italic
    " dark green
    highlight TagbarNestedKind      ctermfg=070 ctermbg=none cterm=none
    " blue
    highlight TagbarScope           ctermfg=039 ctermbg=none cterm=none
    " yellow
    highlight TagbarType            ctermfg=190 ctermbg=none cterm=none
    " orange
    highlight TagbarSignature       ctermfg=202 ctermbg=none cterm=none
    " pink
    highlight TagbarPseudoID        ctermfg=205 ctermbg=none cterm=bold
    " red
    highlight TagbarFoldIcon        ctermfg=197 ctermbg=none cterm=none
    " dark green
    highlight TagbarAccessPublic    ctermfg=022 ctermbg=none cterm=none
    " dark red
    highlight TagbarAccessProtected ctermfg=088 ctermbg=none cterm=bold
    " red
    highlight TagbarPrivate         ctermfg=196 ctermbg=none cterm=italic
" }}}

" Colors: {
"hi Black    ctermfg=240         ctermbg=none        cterm=none
"hi Blue     ctermfg=68          ctermbg=none        cterm=none
"hi Green    ctermfg=107         ctermbg=none        cterm=none
"hi Orange   ctermfg=214         ctermbg=none        cterm=none
"hi Peach    ctermfg=222         ctermbg=none        cterm=none
"hi Pink     ctermfg=205         ctermbg=none        cterm=none
"hi Pink2    ctermfg=211         ctermbg=none        cterm=none
"hi Purple   ctermfg=153         ctermbg=none        cterm=none
"hi Purple2  ctermfg=164         ctermbg=none        cterm=none
"hi Red      ctermfg=203         ctermbg=none        cterm=none
"hi Silver   ctermfg=245         ctermbg=none        cterm=none
"hi White    ctermfg=255         ctermbg=none        cterm=none
" }

"" JavaScript: {
"" Other
"hi link javaScriptSpecial               Pink
"hi link javaScriptFloat                 Red

"" Browser/DOM
"hi link javaScriptHtmlEvents            Pink2
"hi link javaScriptDomElemAttrs          Purple
"hi link javaScriptHtmlElemAttrs         Purple
"hi link javaScriptHtmlElemFuncs         Pink
"hi link javaScriptCssStyles             Purple

"" JSDoc
"hi link javaScriptDocType         Blue
"hi link javaScriptDocTypeNoParam  Blue
"hi link javaScriptDocParam        Silver

"" JavaScript
""syntax keyword javaScriptPrototype      prototype
"hi link javaScriptPrototype       Pink2
""syntax keyword javaScriptSource         import export
"hi link javaScriptSource          Red
""syntax keyword javaScriptType           const undefined var void yield
"hi link javaScriptType            Orange
""syntax keyword javaScriptOperator       delete new in instanceof let typeof
"hi link javaScriptOperator        Orange
""syntax keyword javaScriptBoolean        true false
"hi link javaScriptBoolean         Red
""syntax keyword javaScriptNull           null
"hi link javaScriptNull            Purple
""syntax keyword javaScriptThis           this self
""syntax keyword javaScriptConditional    if else
"hi link javaScriptConditional     Peach
""syntax keyword javaScriptRepeat         do while for
"hi link javaScriptRepeat          Peach
""syntax keyword javaScriptBranch         break continue switch case default return
"hi link javaScriptBranch          Orange
""syntax keyword javaScriptStatement      try catch throw with finally
"hi link javaScriptStatement       Red
""syntax keyword javaScriptGlobalObjects  Array Boolean Date Function Infinity JavaArray JavaClass JavaObject JavaPackage kind Math Number NaN Object Packages RegExp String Undefined java netscape sun
"hi link javaScriptGlobalObjects   Purple
""syntax keyword javaScriptExceptions     Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
"hi link javaScriptExceptions      Red
""syntax keyword javaScriptFutureKeys     abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws goto private transient debugger implements protected volatile double import public
"hi link javaScriptFutureKeys      Black
""  }

"" PHP: {
"hi link phpFunctions          Pink
"" }

"" HTML: {
"hi link htmlTag               Blue
"hi link htmlTagName           Blue
""}

"" Python: {
"hi link pythonPreCondit       Blue
"" }

"" CSS_LESS: {
"hi link lessVariable      Blue
"hi link lessFunction      Purple
"hi link lessFuncDef       Purple
"hi link cssBraces         Peach
"hi link cssTagName        Orange
"hi link cssClassName      Peach
"hi link cssCommonAttr     Pink
"hi link cssFontAttr       Pink
"hi link cssTextAttr       Pink
"hi link cssBoxAttr        Pink
"hi link cssColorAttr      Pink
"hi link cssRenderAttr     Pink
"hi link cssTableAttr      Pink
"hi link cssAuralAttr      Pink
"hi link cssUIAttr         Pink
"hi link cssGeneratedContentAttr      Pink
""}
