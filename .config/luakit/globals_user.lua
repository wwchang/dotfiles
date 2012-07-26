-- append settings to global tables.
-- e.g.  search_engines.google = "http://google.com/search?q=%s"

-- [ search_engines ]
search_engines.blekko = "http://blekko.com/ws/+%s"
search_engines.baidu = "http://www.baidu.com/s?wd=%s"
search_engines.github = "http://github.com/search?q=%s"
search_engines.wiki = "http://en.wikipedia.org/wiki/Special:Search?search=%s"
search_engines.googlecode = "http://code.google.com/query/#q=%s"

-- domain rules
-- properties reference :
-- http://webkitgtk.org/reference/webkitgtk/stable/WebKitWebSettings.html
domain_props = {
    ["all"] = {
        -- font
        sans_serif_font_family = "dejavu sans mono",
        serif_font_family = "dejavu serif",
        monospace_font_family = "monaco",
        default_font_size = 16,
        default_monospace_font_size = 16,
        minimum_font_size = 13,
        -- script & plugin
        enable_scripts = false,
        enable_plugins = false,
        -- style
        user_stylesheet_uri = nil,
    },
    ["github.com"] = {
        user_stylesheet_uri = "file://" .. luakit.data_dir .. "/styles/github.css",
    },
    ["youtube.com"] = {
        enable_scripts = true,
        enable_plugins = true,
    }
}
