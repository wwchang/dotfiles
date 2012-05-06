"Humberto H. C. Pinheiro Qua, 05 Out 2011 10:41:02

if exists("g:loaded_lyrics") || &cp
    finish
endif
let g:loaded_lyrics = 0.0.1

let cpo_save = &cpo
set cpo-=C

" --------------------------------------------------------------------------
let s:lyrics_site = "http://www.lyrics.com/song-lyrics-artist.html"

" --------------------------------------------------------------------------

fun! s:DownloadLyrics(url)
    let file = tempname()
    let wget = "wget -q -O ". file ." " . a:url
    let html = system(wget)
    if filereadable(file)
        let html = system("sed -n '/<div id=\"lyrics_outer\">/,/<\\/div>/p'  " . file)
    else
        return ''
    endif
    return html
endfun

" Prepare song and artist name to remove unwanted chars in lyrics.com url
fun! s:Prepare(string)
    let delChars = ')\|(\|\.\|\n\|''\|^\s\+\|\s\+$\|\r\n\|!'
    let string   = substitute(a:string, delChars, '', 'g')
    return string
endfun

" Format for the site lyrics.com
fun! s:PrepareSongArtist(song, artist)
    let song     = substitute(a:song, '\s', '-' ,"g")
    let artist   = substitute(a:artist, '\s', '-',"g")
    return [song, artist]
endfun

fun! s:ShowLyrics(song, artist)
    let url            = s:lyrics_site
    let [song, artist] = s:PrepareSongArtist(a:song, a:artist)
    let url            = substitute(url, 'song', song, "g")
    let url            = substitute(url, 'artist', artist, "g")
    let lyrics         = s:DownloadLyrics(url)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    silent! execute "normal! a " . a:song . " - " . a:artist . "\n" .lyrics
    silent! %s/<[^>]*>//g  " strip html tags
    silent! %s/^\s*//g     " strip leading whitespace
    silent! g/^\_$\n\_^$/d " reduce multiple blank lines to a single one
    silent! execute "normal! gg"
endfun

fun! s:RhythmboxLyrics()
    let currentPlaying = system("rhythmbox-client --print-playing")
    if empty(matchstr(currentPlaying, '-'))
        echo 'Rhythmbox not playing'
        return
    endif
    " lyrics.com url requirements
    let currentPlaying = s:Prepare(currentPlaying)
    let [artist, song] = split(currentPlaying, '-')
    let artist         = substitute(artist, '^\s\+\|\s\+$\|\r\n', '', 'g')
    let song           = substitute(song, '^\s\+\|\s\+$\|\r\n', '', 'g')
    call s:ShowLyrics(song, artist)
endfun

fun! s:SearchLyrics()
    call inputsave()
    let  inputStr       = input('Enter song-artist:    ')
    call inputrestore()
    let  inputStr       = s:Prepare(inputStr)
    let  [song, artist] = split(inputStr, '-')
    call s:ShowLyrics(song, artist)
endfun

command! Lyrics       call s:RhythmboxLyrics()
command! SearchLyrics call s:SearchLyrics()

let &cpo = cpo_save
" -------------------------------------------------------------------------
