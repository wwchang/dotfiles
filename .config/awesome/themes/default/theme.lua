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

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.taglist_font          = "sans 9"
-- Display the taglist squares
theme.taglist_squares_sel   = theme_dir .. "default/taglist/squarefw2.png"
theme.taglist_squares_unsel = theme_dir .. "default/taglist/squarew.png"

theme.tasklist_floating_icon = theme_dir .. "default/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_dir .. "default/icons/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme_dir .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme_dir .. "default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme_dir .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme_dir .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme_dir .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme_dir .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme_dir .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme_dir .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme_dir .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme_dir .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme_dir .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme_dir .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme_dir .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme_dir .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme_dir .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme_dir .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme_dir .. "default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/chris/.config/awesome/themes/default/cool_monitor.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = theme_dir .. "default/layouts/fairhw.png"
theme.layout_fairv = theme_dir .. "default/layouts/fairvw.png"
theme.layout_floating  = theme_dir .. "default/layouts/floatingw.png"
theme.layout_magnifier = theme_dir .. "default/layouts/magnifierw.png"
theme.layout_max = theme_dir .. "default/layouts/maxw.png"
theme.layout_fullscreen = theme_dir .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = theme_dir .. "default/layouts/tilebottomw.png"
theme.layout_tileleft   = theme_dir .. "default/layouts/tileleftw.png"
theme.layout_tile = theme_dir .. "default/layouts/tilew.png"
theme.layout_tiletop = theme_dir .. "default/layouts/tiletopw.png"
theme.layout_spiral  = theme_dir .. "default/layouts/spiralw.png"
theme.layout_dwindle = theme_dir .. "default/layouts/dwindlew.png"

theme.awesome_icon = theme_dir .. "default/icons/awesome16.png"

return theme
