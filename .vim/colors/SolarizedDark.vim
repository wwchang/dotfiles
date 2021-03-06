" Vim color file - SolarizedDark
" Generated by http://bytefluent.com/vivify 2012-02-06
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "SolarizedDark"

hi IncSearch guifg=#cb4b16 guibg=none guisp=none gui=none ctermfg=166 ctermbg=none cterm=none
hi WildMenu guifg=#eee8d5 guibg=#073642 guisp=#073642 gui=none ctermfg=230 ctermbg=23 cterm=none
hi SignColumn guifg=#839496 guibg=#bebebe guisp=#bebebe gui=none ctermfg=66 ctermbg=7 cterm=none
hi SpecialComment guifg=#dc322f guibg=none guisp=none gui=none ctermfg=160 ctermbg=none cterm=none
hi Typedef guifg=#b58900 guibg=none guisp=none gui=none ctermfg=136 ctermbg=none cterm=none
hi Title guifg=#cb4b16 guibg=none guisp=none gui=bold ctermfg=166 ctermbg=none cterm=bold
hi Folded guifg=#839496 guibg=#073642 guisp=#073642 gui=bold ctermfg=66 ctermbg=23 cterm=bold
hi PreCondit guifg=#cb4b16 guibg=none guisp=none gui=none ctermfg=166 ctermbg=none cterm=none
hi Include guifg=#cb4b16 guibg=none guisp=none gui=none ctermfg=166 ctermbg=none cterm=none
hi TabLineSel guifg=#586e75 guibg=#eee8d5 guisp=#eee8d5 gui=bold ctermfg=66 ctermbg=230 cterm=bold
hi StatusLineNC guifg=#657b83 guibg=#073642 guisp=#073642 gui=none ctermfg=66 ctermbg=23 cterm=none
hi CTagsMember guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi NonText guifg=#657b83 guibg=none guisp=none gui=bold ctermfg=66 ctermbg=none cterm=bold
hi CTagsGlobalConstant guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi DiffText guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi ErrorMsg guifg=#dc322f guibg=#0000c0 guisp=#0000c0 gui=none ctermfg=160 ctermbg=4 cterm=none
hi Ignore guifg=#000000 guibg=none guisp=none gui=none ctermfg=none ctermbg=none cterm=none
hi Debug guifg=#dc322f guibg=none guisp=none gui=none ctermfg=160 ctermbg=none cterm=none
hi PMenuSbar guifg=#eee8d5 guibg=#839496 guisp=#839496 gui=none ctermfg=230 ctermbg=66 cterm=none
hi Identifier guifg=#268bd2 guibg=none guisp=none gui=bold ctermfg=32 ctermbg=none cterm=bold
hi SpecialChar guifg=#dc322f guibg=none guisp=none gui=none ctermfg=160 ctermbg=none cterm=none
hi Conditional guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi StorageClass guifg=#b58900 guibg=none guisp=none gui=none ctermfg=136 ctermbg=none cterm=none
hi Todo guifg=#d33682 guibg=#00ffff guisp=#00ffff gui=bold ctermfg=168 ctermbg=14 cterm=bold
hi Special guifg=#dc322f guibg=none guisp=none gui=none ctermfg=160 ctermbg=none cterm=none
hi LineNr guifg=#586e75 guibg=#073642 guisp=#073642 gui=none ctermfg=66 ctermbg=23 cterm=none
hi StatusLine guifg=#93a1a1 guibg=#073642 guisp=#073642 gui=bold ctermfg=109 ctermbg=23 cterm=bold
hi Normal guifg=#839496 guibg=#002b36 guisp=#002b36 gui=none ctermfg=66 ctermbg=23 cterm=none
hi Label guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi CTagsImport guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi PMenuSel guifg=#586e75 guibg=#eee8d5 guisp=#eee8d5 gui=none ctermfg=66 ctermbg=230 cterm=none
hi Search guifg=#b58900 guibg=#00ffff guisp=#00ffff gui=none ctermfg=136 ctermbg=14 cterm=none
hi CTagsGlobalVariable guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi Delimiter guifg=#dc322f guibg=none guisp=none gui=none ctermfg=160 ctermbg=none cterm=none
hi Statement guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi SpellRare guifg=#e2e4e5 guibg=#ff40ff guisp=#ff40ff gui=none ctermfg=254 ctermbg=13 cterm=none
hi EnumerationValue guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi Comment guifg=#586e75 guibg=none guisp=none gui=italic ctermfg=66 ctermbg=none cterm=italic
hi Character guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi Float guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi Number guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi Boolean guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi Operator guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi CursorLine guifg=#e2e4e5 guibg=#073642 guisp=#073642 gui=underline ctermfg=254 ctermbg=23 cterm=underline
hi Union guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi TabLineFill guifg=#839496 guibg=#073642 guisp=#073642 gui=underline ctermfg=66 ctermbg=23 cterm=underline
hi Question guifg=#2aa198 guibg=none guisp=none gui=bold ctermfg=37 ctermbg=none cterm=bold
hi WarningMsg guifg=#dc322f guibg=none guisp=none gui=bold ctermfg=160 ctermbg=none cterm=bold
hi VisualNOS guifg=#e2e4e5 guibg=#073642 guisp=#073642 gui=bold ctermfg=254 ctermbg=23 cterm=bold
hi DiffDelete guifg=#dc322f guibg=#073642 guisp=#073642 gui=bold ctermfg=160 ctermbg=23 cterm=bold
hi ModeMsg guifg=#268bd2 guibg=none guisp=none gui=bold ctermfg=32 ctermbg=none cterm=bold
hi CursorColumn guifg=#e2e4e5 guibg=#073642 guisp=#073642 gui=none ctermfg=254 ctermbg=23 cterm=none
hi Define guifg=#cb4b16 guibg=none guisp=none gui=none ctermfg=166 ctermbg=none cterm=none
hi Function guifg=#268bd2 guibg=none guisp=none gui=bold ctermfg=32 ctermbg=none cterm=bold
hi FoldColumn guifg=#839496 guibg=#073642 guisp=#073642 gui=none ctermfg=66 ctermbg=23 cterm=none
hi PreProc guifg=#cb4b16 guibg=none guisp=none gui=none ctermfg=166 ctermbg=none cterm=none
hi EnumerationName guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi Visual guifg=#586e75 guibg=#002b36 guisp=#002b36 gui=none ctermfg=66 ctermbg=23 cterm=none
hi MoreMsg guifg=#268bd2 guibg=none guisp=none gui=none ctermfg=32 ctermbg=none cterm=none
hi SpellCap guifg=#e2e4e5 guibg=#ff6060 guisp=#ff6060 gui=none ctermfg=254 ctermbg=9 cterm=none
hi VertSplit guifg=#657b83 guibg=#657b83 guisp=#657b83 gui=none ctermfg=66 ctermbg=66 cterm=none
hi Exception guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi Keyword guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi Type guifg=#b58900 guibg=none guisp=none gui=none ctermfg=136 ctermbg=none cterm=none
hi DiffChange guifg=#b58900 guibg=#073642 guisp=#073642 gui=bold ctermfg=136 ctermbg=23 cterm=bold
hi Cursor guifg=#002b36 guibg=#839496 guisp=#839496 gui=none ctermfg=23 ctermbg=66 cterm=none
hi SpellLocal guifg=#e2e4e5 guibg=#ffff00 guisp=#ffff00 gui=none ctermfg=254 ctermbg=11 cterm=none
hi Error guifg=#dc322f guibg=#8080ff guisp=#8080ff gui=bold ctermfg=160 ctermbg=12 cterm=bold
hi PMenu guifg=#839496 guibg=#073642 guisp=#073642 gui=none ctermfg=66 ctermbg=23 cterm=none
hi SpecialKey guifg=#657b83 guibg=#073642 guisp=#073642 gui=bold ctermfg=66 ctermbg=23 cterm=bold
hi Constant guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi DefinedName guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi Tag guifg=#dc322f guibg=none guisp=none gui=none ctermfg=160 ctermbg=none cterm=none
hi String guifg=#2aa198 guibg=none guisp=none gui=none ctermfg=37 ctermbg=none cterm=none
hi PMenuThumb guifg=#839496 guibg=#002b36 guisp=#002b36 gui=none ctermfg=66 ctermbg=23 cterm=none
hi MatchParen guifg=#dc322f guibg=#586e75 guisp=#586e75 gui=bold ctermfg=160 ctermbg=66 cterm=bold
hi LocalVariable guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi Repeat guifg=#719e07 guibg=none guisp=none gui=none ctermfg=106 ctermbg=none cterm=none
hi SpellBad guifg=#e2e4e5 guibg=#8080ff guisp=#8080ff gui=none ctermfg=254 ctermbg=12 cterm=none
hi CTagsClass guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi Directory guifg=#268bd2 guibg=none guisp=none gui=none ctermfg=32 ctermbg=none cterm=none
hi Structure guifg=#b58900 guibg=none guisp=none gui=none ctermfg=136 ctermbg=none cterm=none
hi Macro guifg=#cb4b16 guibg=none guisp=none gui=none ctermfg=166 ctermbg=none cterm=none
hi Underlined guifg=#6c71c4 guibg=none guisp=none gui=underline ctermfg=61 ctermbg=none cterm=underline
hi DiffAdd guifg=#719e07 guibg=#073642 guisp=#073642 gui=bold ctermfg=106 ctermbg=23 cterm=bold
hi TabLine guifg=#839496 guibg=#073642 guisp=#073642 gui=underline ctermfg=66 ctermbg=23 cterm=underline
hi mbenormal guifg=#cfbfad guibg=#2e2e3f guisp=#2e2e3f gui=none ctermfg=187 ctermbg=237 cterm=none
hi perlspecialstring guifg=#c080d0 guibg=#404040 guisp=#404040 gui=none ctermfg=176 ctermbg=238 cterm=none
hi doxygenspecial guifg=#fdd090 guibg=none guisp=none gui=none ctermfg=222 ctermbg=none cterm=none
hi mbechanged guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=none ctermfg=255 ctermbg=237 cterm=none
hi mbevisiblechanged guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=none ctermfg=255 ctermbg=60 cterm=none
hi doxygenparam guifg=#fdd090 guibg=none guisp=none gui=none ctermfg=222 ctermbg=none cterm=none
hi doxygensmallspecial guifg=#fdd090 guibg=none guisp=none gui=none ctermfg=222 ctermbg=none cterm=none
hi doxygenprev guifg=#fdd090 guibg=none guisp=none gui=none ctermfg=222 ctermbg=none cterm=none
hi perlspecialmatch guifg=#c080d0 guibg=#404040 guisp=#404040 gui=none ctermfg=176 ctermbg=238 cterm=none
hi cformat guifg=#c080d0 guibg=#404040 guisp=#404040 gui=none ctermfg=176 ctermbg=238 cterm=none
hi lcursor guifg=#404040 guibg=#8fff8b guisp=#8fff8b gui=none ctermfg=238 ctermbg=120 cterm=none
hi cursorim guifg=none guibg=none guisp=none gui=none ctermfg=none ctermbg=none cterm=none
hi doxygenspecialmultilinedesc guifg=#ad600b guibg=none guisp=none gui=none ctermfg=130 ctermbg=none cterm=none
hi taglisttagname guifg=#808bed guibg=none guisp=none gui=none ctermfg=105 ctermbg=none cterm=none
hi doxygenbrief guifg=#fdab60 guibg=none guisp=none gui=none ctermfg=215 ctermbg=none cterm=none
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=none ctermfg=252 ctermbg=60 cterm=none
hi user2 guifg=#7070a0 guibg=#3e3e5e guisp=#3e3e5e gui=none ctermfg=103 ctermbg=60 cterm=none
hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=none ctermfg=48 ctermbg=60 cterm=none
hi doxygenspecialonelinedesc guifg=#ad600b guibg=none guisp=none gui=none ctermfg=130 ctermbg=none cterm=none
hi doxygencomment guifg=#ad7b20 guibg=none guisp=none gui=none ctermfg=130 ctermbg=none cterm=none
hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=none ctermfg=176 ctermbg=238 cterm=none
hi clear guifg=none guibg=none guisp=none gui=none ctermfg=none ctermbg=none cterm=none
hi underline guifg=#afafff guibg=none guisp=none gui=none ctermfg=147 ctermbg=none cterm=none
hi pythonimport guifg=#009000 guibg=none guisp=none gui=none ctermfg=28 ctermbg=none cterm=none
hi pythonexception guifg=#f00000 guibg=none guisp=none gui=none ctermfg=196 ctermbg=none cterm=none
hi pythonbuiltinfunction guifg=#009000 guibg=none guisp=none gui=none ctermfg=28 ctermbg=none cterm=none
hi pythonoperator guifg=#7e8aa2 guibg=none guisp=none gui=none ctermfg=103 ctermbg=none cterm=none
hi pythonexclass guifg=#009000 guibg=none guisp=none gui=none ctermfg=28 ctermbg=none cterm=none
hi pythonbuiltin guifg=#839496 guibg=none guisp=none gui=none ctermfg=66 ctermbg=none cterm=none
hi phpstringdouble guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi htmltagname guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi javascriptstrings guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi htmlstring guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none
hi phpstringsingle guifg=#e2e4e5 guibg=none guisp=none gui=none ctermfg=254 ctermbg=none cterm=none

