---------------------------
-- Default awesome theme --
---------------------------

-- colors list 
-- #000000  black
-- #b23535  red 
-- #60801f  green 
-- #be6e00  yellow
-- #00CFFF  blue 
-- #8f46b2  magenta
-- #73afb4  cyan 
-- #b2b2b2  white 
-- #555555  bright black
-- #ff4b4b  bright red 
-- #9bcd32  bright green 
-- #d79b1e  bright yellow
-- #12A2C5  bright green 
-- #cd64ff  bright magenta
-- #9bcdff  bright cyan 
-- #ffffff  bright white

-- Example:
theme = {}

-- font list -------------------
-- theme.font          = "Comic Sans MS bold 8"
theme.font          = "ubuntu bold 8"

theme.bg_normal     = "#FFFFFF" 
theme.bg_focus      = "#000000" 
theme.bg_urgent     = "#CC0000" 
theme.bg_minimize   = "#626262" 

theme.fg_normal     = "#000000" 
theme.fg_focus      = "#FFFFFF" 
theme.fg_urgent     = "#000000" 
theme.fg_minimize   = "#FFFFFF" 

-- border 
theme.border_width  = "2"
theme.border_normal = "#000000" 
theme.border_focus  = "#00AF00" -- pink
theme.border_marked = "#CC0000" 

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]

-- taglist 
theme.taglist_font      = "ubuntu bold 8"
theme.taglist_bg_focus  = "#FF5F87"  -- pink
theme.taglist_bg_normal = "#FFFFFF" 
theme.taglist_bg_urgent = "#CC0000" 

theme.taglist_fg_focus  = "#000000" 
theme.taglist_fg_normal = "#000000" 
theme.taglist_fg_urgent = "#000000" 

-- tasklist
-- theme.tasklist_font      = "Comic Sans MS 8"
theme.tasklist_font      = "ubuntu bold 8"
theme.tasklist_bg_focus  = "#FFFFFF" 
theme.tasklist_bg_normal = "#FFFFFF" 
theme.tasklist_bg_urgent = "#CC0000" 

theme.tasklist_fg_focus  = "#000000" 
theme.tasklist_fg_normal = "#000000" 
theme.tasklist_fg_urgent = "#000000" 


-- Display the taglist squares
theme.taglist_squares_sel   = "~/.config/awesome/themes/white/taglist/squarefw.png"
theme.taglist_squares_unsel = "~/.config/awesome/themes/white/taglist/squarew.png"

-- white bird on tasklist icon 
-- theme.tasklist_floating_icon = "~/.config/awesome/themes/white/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = "~/.config/awesome/themes/white/submenu.png"
theme.menu_height = "20"
theme.menu_width  = "120"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/white/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/white/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/white/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "~/.config/awesome/themes/white/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/white/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "~/.config/awesome/themes/white/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/white/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/white/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/white/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "~/.config/awesome/themes/white/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/white/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "~/.config/awesome/themes/white/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/white/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "~/.config/awesome/themes/white/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/white/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/white/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/white/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/white/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
-- theme.wallpaper_cmd = { "feh --bg-fill /home/chris/.config/awesome/themes/white/background/office_4019.jpg" }
theme.wallpaper_cmd = { "awsetbg -c /home/chris/.config/awesome/themes/white/background/office_4019.jpg" }
-- random wallpaper 
-- XXX you can just { $ cd .config/awesome/.. ; ln -s /media/tux/Pictures . }
-- theme.wallpaper_cmd = { "awsetbg -c -r ~/.config/awesome/themes/white/background/" }
-- theme.wallpaper_cmd = { "awsetbg -c -r /media/tux/Private/Pictures/wallpapers/" }

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/white/layouts/fairhw.png"
theme.layout_fairv = "~/.config/awesome/themes/white/layouts/fairvw.png"
theme.layout_floating  = "~/.config/awesome/themes/white/layouts/floatingw.png"
theme.layout_magnifier = "~/.config/awesome/themes/white/layouts/magnifierw.png"
theme.layout_max = "~/.config/awesome/themes/white/layouts/maxw.png"
theme.layout_fullscreen = "~/.config/awesome/themes/white/layouts/fullscreenw.png"
theme.layout_tilebottom = "~/.config/awesome/themes/white/layouts/tilebottomw.png"
theme.layout_tileleft   = "~/.config/awesome/themes/white/layouts/tileleftw.png"
theme.layout_tile = "~/.config/awesome/themes/white/layouts/tilew.png"
theme.layout_tiletop = "~/.config/awesome/themes/white/layouts/tiletopw.png"
theme.layout_spiral  = "~/.config/awesome/themes/white/layouts/spiralw.png"
theme.layout_dwindle = "~/.config/awesome/themes/white/layouts/dwindlew.png"

-- awesome icon 
theme.awesome_icon = "~/.config/awesome/themes/white/icons/awesome-icon.png"

-- ------------------ Addes ------------------------------
-- theme.widget_net = "~/.config/awesome/themes/white/icons/down.png"
-- theme.widget_netup = "~/.config/awesome/themes/white/icons/up.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
