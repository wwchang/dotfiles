---------------------
-- Scheme Handlers --
---------------------

-- mailto:
webview.init_funcs.mailto_hook = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        if string.match(string.lower(uri), "^mailto:") then

            -- using Gmail:
            -- local mailto = "https://mail.google.com/mail/?extsrc=mailto&url=%s"
            -- w:new_tab(string.format(mailto, uri))

            -- using mutt
            luakit.spawn(string.format("%s %q", "urxvt -title mutt -e mutt", uri))

            return false
        end
    end)
end

-- magnet:
webview.init_funcs.magnet_hook = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        if string.match(string.lower(uri), "^magnet:") then

            -- open with Deluge:
            -- luakit.spawn(string.format("%s %q", "deluge-gtk", uri))

            -- open with rTorrent:
            luakit.spawn(string.format("%s %q", "mktor", uri))

            return false
        end
    end)
end
