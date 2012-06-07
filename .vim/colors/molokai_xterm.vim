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
let g:colors_name="molokai_xterm"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif


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
   hi Operator        ctermfg=161  ctermbg=232 cterm=bold

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
   hi Comment         ctermfg=240 ctermbg=none
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
