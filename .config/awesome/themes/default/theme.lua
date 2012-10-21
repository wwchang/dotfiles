---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "2"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

theme_dir = awful.util.getdir("config") .. "/themes/"
theme_icons = awful.util.getdir("config") .. "/themes/icons/"
theme_wallpapers = awful.util.getdir("config") .. "/themes/wallpapers/"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

theme.taglist_font          = "DejaVu Sans Mono 12"
theme.taglist_bg_normal     = "#222222"
theme.taglist_bg_focus      = "#535D6C"
theme.taglist_bg_urgent     = "#FF0000"
theme.taglist_fg_normal     = "#AAAAAA"
theme.taglist_fg_focus      = "#FFFFFF"
theme.taglist_fg_urgent     = "#FFFFFF"
theme.taglist_squares_sel   = theme_icons .. "taglist/red/square_sel.png"
theme.taglist_squares_unsel = theme_icons .. "taglist/red/square_unsel.png"

theme.tasklist_font             = "sans 9"
theme.tasklist_bg_normal        = "#222222"
theme.tasklist_bg_focus         = "#535D6C"
theme.tasklist_bg_urgent        = "#FF0000"
theme.tasklist_fg_normal        = "#AAAAAA"
theme.tasklist_fg_focus         = "#FFFFFF"
theme.tasklist_fg_urgent        = "#FFFFFF"
theme.tasklist_floating_icon    = theme_icons .. "tasklist/default/floating.png"

theme.menu_height = "15"
theme.menu_width  = "100"
theme.menu_submenu_icon = theme_icons .. "menu/submenu.png"

theme.titlebar_close_button_normal = theme_icons .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_icons .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_icons .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_icons .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_icons .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_icons .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_icons .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_icons .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_icons .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_icons .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_icons .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_icons .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_icons .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_icons .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_icons .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_icons .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_icons .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_icons .. "titlebar/maximized_focus_active.png"

theme.wallpaper_cmd = { "awsetbg " .. os.getenv("HOME") .. "/.config/awesome/themes/wallpapers/wallpaper.jpg" }

theme.notify_icon = theme_icons .. "notify.jpg"

theme.mouse_finder_color = theme.fg_urgent

-- You can use your own layout icons like this:
theme.layout_fairh = theme_icons .. "layouts/default/fairhw.png"
theme.layout_fairv = theme_icons .. "layouts/default/fairvw.png"
theme.layout_floating  = theme_icons .. "layouts/default/floatingw.png"
theme.layout_magnifier = theme_icons .. "layouts/default/magnifierw.png"
theme.layout_max = theme_icons .. "layouts/default/maxw.png"
theme.layout_fullscreen = theme_icons .. "layouts/default/fullscreenw.png"
theme.layout_tilebottom = theme_icons .. "layouts/default/tilebottomw.png"
theme.layout_tileleft   = theme_icons .. "layouts/default/tileleftw.png"
theme.layout_tile = theme_icons .. "layouts/default/tilew.png"
theme.layout_tiletop = theme_icons .. "layouts/default/tiletopw.png"
theme.layout_spiral  = theme_icons .. "layouts/default/spiralw.png"
theme.layout_dwindle = theme_icons .. "layouts/default/dwindlew.png"

theme.awesome_icon = theme_icons .. "menu/awesome16.png"

-- {{{ Widgets
theme.fg_widget        = "#FFFFFF"
theme.fg_center_widget = "#535D6C"
theme.fg_end_widget    = "#000000"
theme.fg_off_widget    = "#222222"
theme.fg_netup_widget  = "#7F9F7F"
theme.fg_netdn_widget  = "#91231C"
theme.bg_widget        = theme.bg_normal
theme.border_widget    = theme.bg_normal
-- }}}

-- {{{ Widget icons
-- theme.widget_cpu    = icons_dir .. "Zenburn/cpu.png"
-- theme.widget_bat    = icons_dir .. "Zenburn/bat.png"
-- theme.widget_mem    = icons_dir .. "Zenburn/mem.png"
-- theme.widget_loadavg = icons_dir .. "Zenburn/cpu.png"
-- theme.widget_temp   = icons_dir .. "Zenburn/temp.png"
-- theme.widget_fs     = icons_dir .. "Zenburn/disk.png"
-- theme.widget_net    = icons_dir .. "Zenburn/down.png"
-- theme.widget_netup  = icons_dir .. "Zenburn/up.png"
-- theme.widget_wifi   = icons_dir .. "Zenburn/wifi.png"
-- theme.widget_mail   = icons_dir .. "Zenburn/mail.png"
-- theme.widget_vol    = icons_dir .. "Zenburn/vol.png"
-- theme.widget_music  = icons_dir .. "Zenburn/music.png"
-- theme.widget_weather = icons_dir .. "Zenburn/sun.png"
-- theme.widget_uptime = icons_dir .. "Zenburn/time.png"
-- theme.widget_org    = icons_dir .. "Zenburn/cal.png"
-- theme.widget_date   = icons_dir .. "Zenburn/time.png"
-- theme.widget_crypto = icons_dir .. "Zenburn/crypto.png"
-- theme.widget_sep    = icons_dir .. "Zenburn/separator.png"
-- }}}

return theme
