
theme = {}

theme.font          = "Ubuntu 10"
--theme.font          = "FZMiaoWuS-GB 14"
--theme.font = "Sans 10"
--theme.font = "Digital dream 9"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535D6C"
theme.bg_urgent     = "#FF0000"
theme.bg_minimize   = "#7BB0CD"

theme.fg_normal     = "#AAAAAA"
theme.fg_focus      = "#FFFFFF"
theme.fg_urgent     = "#FFFFFF"
theme.fg_minimize   = "#FFFFFF"

theme.border_width  = "2"
theme.border_normal = "#000000"
theme.border_focus  = "#535D6C"
theme.border_marked = "#91231C"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

theme.taglist_font      = "Ubuntu 12"
theme.taglist_bg_focus  = "#535D6C"
theme.taglist_bg_normal = "#222222"
theme.taglist_bg_urgent = "#FF0000"

theme.taglist_fg_focus  = "#FFFFFF"
theme.taglist_fg_normal = "#FFFFFF"
theme.taglist_fg_urgent = "#FFFFFF"

theme.tasklist_font      = "ubuntu 10"
theme.tasklist_bg_focus  = "#535D6C"
theme.tasklist_bg_normal = "#222222"
theme.tasklist_bg_urgent = "#FF0000"

theme.tasklist_fg_focus  = "#FFFFFF"
theme.tasklist_fg_normal = "#FFFFFF"
theme.tasklist_fg_urgent = "#FFFFFF"

icons_dir = awful.util.getdir("config") .. "/themes/icons/"
theme_icons = awful.util.getdir("config") .. "/themes/black/icons/"

theme.taglist_squares_sel   = theme_icons .. "taglist/square_sel2.png"
theme.taglist_squares_unsel = theme_icons .. "taglist/square_unsel.png"

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

theme.mouse_finder_color = theme.fg_urgent

-- white bird on tasklist icon
-- theme.tasklist_floating_icon = theme_icons .. "tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = theme_icons .. "submenu.png"
theme.menu_height = "20"
theme.menu_width  = "120"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

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

-- theme.wallpaper_cmd = { "awsetbg" .. " " .. os.getenv("HOME") .. "/.Wallpaper" }
theme.wallpaper_cmd = { "feh --bg-fill /home/chris/.config/awesome/themes/wallpapers/gene.jpg" }

-- random wallpaper
-- XXX you can just { $ cd .config/awesome/.. ; ln -s /media/tux/Pictures . }
-- theme.wallpaper_cmd = { "awsetbg -c -r ~/.config/awesome/themes/black/background/" }
-- theme.wallpaper_cmd = { "awsetbg -c -r /media/tux/Private/Pictures/wallpapers/" }

theme.notify_icon = theme_icons .. "notify.jpg"

theme.layout_fairh = theme_icons .. "layouts/fairh.png"
theme.layout_fairv = theme_icons .. "layouts/fairv.png"
theme.layout_floating  = theme_icons .. "layouts/floating.png"
theme.layout_magnifier = theme_icons .. "layouts/magnifier.png"
theme.layout_max = theme_icons .. "layouts/max.png"
theme.layout_fullscreen = theme_icons .. "layouts/fullscreen.png"
theme.layout_tilebottom = theme_icons .. "layouts/tilebottom.png"
theme.layout_tileleft   = theme_icons .. "layouts/tileleft.png"
theme.layout_tile = theme_icons .. "layouts/tile.png"
theme.layout_tiletop = theme_icons .. "layouts/tiletop.png"
theme.layout_spiral  = theme_icons .. "layouts/spiral.png"
theme.layout_dwindle = theme_icons .. "layouts/dwindle.png"

theme.awesome_icon = theme_icons .. "menu_icon.png"

-- {{{ Widget icons
theme.widget_cpu    = icons_dir .. "Zenburn/cpu.png"
theme.widget_bat    = icons_dir .. "Zenburn/bat.png"
theme.widget_mem    = icons_dir .. "Zenburn/mem.png"
theme.widget_loadavg = icons_dir .. "Zenburn/cpu.png"
theme.widget_temp   = icons_dir .. "Zenburn/temp.png"
theme.widget_fs     = icons_dir .. "Zenburn/disk.png"
theme.widget_net    = icons_dir .. "Zenburn/down.png"
theme.widget_netup  = icons_dir .. "Zenburn/up.png"
theme.widget_wifi   = icons_dir .. "Zenburn/wifi.png"
theme.widget_mail   = icons_dir .. "Zenburn/mail.png"
theme.widget_vol    = icons_dir .. "Zenburn/vol.png"
theme.widget_music  = icons_dir .. "Zenburn/music.png"
theme.widget_weather = icons_dir .. "Zenburn/sun.png"
theme.widget_uptime = icons_dir .. "Zenburn/time.png"
theme.widget_org    = icons_dir .. "Zenburn/cal.png"
theme.widget_date   = icons_dir .. "Zenburn/time.png"
theme.widget_crypto = icons_dir .. "Zenburn/crypto.png"
theme.widget_sep    = icons_dir .. "Zenburn/separator.png"
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
