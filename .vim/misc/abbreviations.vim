" Description: easy type lite words to insert long string
" you can use this script with command
" :source ~/.vim/my_scripts/abbreviations.vim
" chris<space> or chris<Enter> to expand
" every time you realize that you will need to add a new abbreviation, you
" first execute it then add.
" :abbreviate for all modes, iabbrev for insert mode, cabbrev for cmd mode
" Example:
" Tips: :iabbr teh the    to corract words
" :iabbr forx forx(x=0;x<100;x++) {<cr><cr>}
" :cabbr csn colorscheme night

" Vim has a feature called "abbreviations" that feel similar to mappings but are meant for
" use in insert, replace, and command modes.
    " Vim will substitute an abbreviation when you type any "non-keyword character" after an
    " abbreviation. "Non-keyword character" means any character not in the iskeyword option.
    " :set iskeyword? :help isfname
" For our purposes you can simply remember that abbreviations will be expanded when you type
" anything that's not a letter, number, or underscore.
    " :iabbrev adn and

" iabbr chris chris M. sprite

" iabbr <expr> date strftime("%c")

" [ mail ]
" iabbr gmail numbchild@gmail.com
iabbr mygmail [ numbchild AT gmail DOT com ]
iabbr myqqmail 348284894@qq.com

" [ copyright ]
iabbr mycopyr Copyright 2011 stardiviner, all rights reserved.
iabbr mycopyl Copyleft 2011 stardiviner. CC.

" [ fonts ]
iabbr Comic_font        Comic Sans MS
iabbr DejaVu_font       DejaVu Sans Mono
iabbr WaWa_font         DFPWaWaW5-GB
iabbr ShaoNv_font       DFPShaoNvW5-GB
iabbr DeathNote_font    Death Note
iabbr Evanescence_font  Evanescent

iabbr oreilly O'Reilly
iabbr latex LaTeX
