-- Play embedded video in external player.
key({}, "v", function (w)
    local view = w:get_current()
    local uri = view.hovered_uri or view.uri
    if uri then
        luakit.spawn(string.format("urxvt -e cclive -f best --filename-format '%%t.%%s' "
        .. "--output-dir %q --exec='mplayer \"%%f\"' %q", os.getenv("HOME"), uri))
    end
end)
-- This assumes you are using urxvt as a terminal, cclive to download videos and 
-- mplayer to play them, but should be pretty easy to adjust for other tools.
--
-- Hold your mouse over a youtube link and press 'v' to open a new terminal 
-- which shows the download processing. It will try to download the video in 
-- best available quality and save the file to your home directory. When 
-- download is complete it will close the terminal and start playing the video.
--
-- One of the benefits of using cclive is that once the video is downloaded, 
-- pressing 'v' again will simply play the movie, without downloading it again.
