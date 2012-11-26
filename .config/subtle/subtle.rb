# -*- encoding: utf-8 -*-
#
# Author::  stardiviner, Email: [numbchild A/T G/mail dot com]

#
# = Subtle default configuration
#
# This file will be installed as default and can also be used as a starter for
# an own custom configuration file. The system wide config usually resides in
# +/etc/xdg/subtle+ and the user config in +HOME/.config/subtle+, both locations
# are dependent on the locations specified by +XDG_CONFIG_DIRS+ and
# +XDG_CONFIG_HOME+.
#

# [ Contrib ] {{{
begin
  require "#{ENV["HOME"]}/compile/subtle-contrib/ruby/launcher.rb"
  require "#{ENV["HOME"]}/compile/subtle-contrib/ruby/selector.rb"

  Subtle::Contrib::Selector.font  = "xft:DejaVu Sans Mono:pixelsize=13"
  Subtle::Contrib::Launcher.fonts = [
    "xft:DejaVu Sans Mono:pixelsize=15",
    "xft:DejaVu Sans Mono:pixelsize=13"
  ]

  Subtle::Contrib::Launcher.browser_screen_num = 0
rescue LoadError
end
# }}}

# [ Options ] {{{
#
# Following options change behaviour and sizes of the window manager:
#

# Window move/resize steps in pixel per keypress
set :increase_step, 5

# Window screen border snapping
set :border_snap, 10

# Default starting gravity for windows. Comment out to use gravity of
# currently active client
set :default_gravity, :center

# Make dialog windows urgent and draw focus
set :urgent_dialogs, true

# Honor resize size hints globally
set :honor_size_hints, false

# Enable gravity tiling for all gravities
set :gravity_tiling, false

# Enable click-to-focus focus model
set :click_to_focus, false

# Skip pointer movement on e.g. gravity change
set :skip_pointer_warp, false

# Skip pointer movement to urgent windows
set :skip_urgent_warp, false

# Set the WM_NAME of subtle (Java quirk)
# set :wmname, "LG3D"
# }}}

# Environment {{{
iconpath = "#{ENV["HOME"]}/.config/subtle/icons"
# }}}

# [ Screen ] {{{
#
# comments {{{
#
# Generally subtle comes with two panels per screen, one on the top and one at
# the bottom. Each panel can be configured with different panel items and
# sublets screen wise. The default config uses top panel on the first screen
# only, it's up to the user to enable the bottom panel or disable either one
# or both.

# === Properties
#
# [*stipple*]    This property adds a stipple pattern to both screen panels.
#
#                Example: stipple "~/stipple.xbm"
#                         stipple Subtlext::Icon.new("~/stipple.xbm")
#
# [*top*]        This property adds a top panel to the screen.
#
#                Example: top [ :views, :title ]
#
# [*bottom*]     This property adds a bottom panel to the screen.
#
#                Example: bottom [ :views, :title ]

#
# Following items are available for the panels:
#
# [*:views*]     List of views with buttons
# [*:title*]     Title of the current active window
# [*:tray*]      Systray icons (Can be used only once)
# [*:keychain*]  Display current chain (Can be used only once)
# [*:sublets*]   Catch-all for installed sublets
# [*:sublet*]    Name of a sublet for direct placement
# [*:spacer*]    Variable spacer (free width / count of spacers)
# [*:center*]    Enclose items with :center to center them on the panel
# [*:separator*] Insert separator
#
# Empty panels are hidden.
#
# === Links
#
# http://subforge.org/projects/subtle/wiki/Multihead
# http://subforge.org/projects/subtle/wiki/Panel
#
# }}}

screen 1 do
  top    [
          :title, :spacer, :keychain,
          :center,
          :uptime,
          :separator, :clock,
          :separator, :maildir,
          :center,
          :views,
          # :separator, :keyboard,
          # :separator, :columns,
          :separator, :layout,
          :separator
         ]
  bottom [
          :separator, :mpd, :separator,
          :spacer,
          :separator, :cpu,
          # :separator, :cpuchart,
          :separator, :memory,
          # :separator, :membar,
          :separator, :nettraffic,
          # :separator, :netchart,
          # :separator, :arbi_net,
          # :separator, :arbi_eth0_wlan0,
          # :separator, :ipaddr,
          :separator, :temp,
          # :separator, :freq,
          # :separator, :weather,
          # :separator, :tasks,
          # :separator, :notify,
          # :separator, :betternotify,
          # :separator, :volume,
          # :separator, :tray,
          :separator
         ]
  view    0
end

# Example for a second screen:
screen 2 do
  top    [ :views, :title, :spacer ]
  bottom [ ]
end
# }}}

# [ Styles ] {{{
#
# comments {{{
#
# Styles can be "nested".
#
# Styles define various properties of styleable items in a CSS-like syntax.
#
# If no background color is given no color will be set. This will ensure a
# custom background pixmap won't be overwritten.
#
# Following properties are available for most the styles:
#
# [*foreground*] Foreground text color
# [*background*] Background color
# [*margin*]     Outer spacing
# [*border*]     Border color and size
# [*padding*]    Inner spacing
# [*font*]       Font string (xftontsel or xft)
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Styles
#
# Box model
#
#                                       Top
#      +-----------------------------------------------------------------+
#      |                              Margin                             |
#      |        +-----------------------------------------------+        |
#      |        |                     Border                    |        |
#      |        |        +-----------------------------+        |        |
#      |        |        |           Padding           |        |        |
#      |        |        |         +---------+         |        |        |
# Left | Margin | Border | Padding | Content | Padding | Border | Margin | Right
#      |        |        |         +---------+         |        |        |
#      |        |        |           Padding           |        |        |
#      |        |        +-----------------------------+        |        |
#      |        |                    Border                     |        |
#      |        +-----------------------------------------------+        |
#      |                             Margin                              |
#      +-----------------------------------------------------------------+
#                                    Bottom
#
#
# [ title ]
#   - ~   -- resize
#   - *   -- sticky mode
#   - ^   -- floating mode
#   - +   -- full screen mode
#   - =   -- zaphod mode
#   - !   -- fixed
#
# }}}

# :all {{{ Style for all style elements
style :all do
  icon        "#757575"
  foreground  "#757575"
  background  "#202020"
  border      "#303030", 0
  padding     0, 3
  font        "xft:DejaVu Sans Mono:pixelsize=15"
end
# }}}

# :views {{{ Style for the all views
style :views do
  foreground  "#757575"
  font        "xft:DejaVu Sans Mono:pixelsize=15"

  # Style for the active views
  style :focus do
    icon          "#5fd7ff"
    foreground  "#ffffff"
    background  "#1a1a1a"
    padding     1, 8, 0, 8
    border_bottom "#5fd7ff", 3
  end

  # Style for urgent window titles and views
  style :urgent do
    icon          "#DF8787"
    foreground  "#a8a8a8"
    background  "#1a1a1a"
    padding     1, 8, 0, 8
    border      0
    border_bottom "#DF8787", 3
  end

  # Style for occupied views (views with clients)
  style :occupied do
    icon          "#595959"
    foreground  "#a8a8a8"
    background  "#1a1a1a"
    padding     1, 8, 0, 8
    border_bottom "#595959", 3
  end
end
# }}}

# :title {{{ Style for focus window title
style :title do
  foreground  "#ffffff"
  background  "#1a1a1a"
  padding     2, 8
  border      "#1a1a1a", 0
  # font        "xft:DejaVu Sans Mono:pixelsize=14"
end
# }}}

# :clients {{{ Style for active/inactive windows
style :clients do
  active    "#595959", 2
  inactive  "#202020", 2
  margin    0
  width     50
end
# }}}

# :sublets {{{ Style for sublets
style :sublets do
  icon        "#757575"
  foreground  "#757575"
  font        "xft:DejaVu Sans Mono:pixelsize=14"

  style :clock do
    icon       "#757575"
    foreground "#afff00"
  end

  style :uptime do
    icon       "#ff9800"
    foreground "#ff9800"
  end

  maildir = "#{ENV["HOME"]}/Mails/INBOX/new"
  if Dir.entries( maildir ).size - 2 > 0
    style :maildir do
      icon       "#5fd7ff"
      foreground "#5fd7ff"
    end
  end

  style :mpd do
    icon       "#5fd7ff"
    foreground "#5fd7ff"
    # font      "xft:WenQuanYi Zen Hei Mono:pixelsize=15"
  end
end
# }}}

# :subtle {{{ Style for subtle
style :subtle do
  background  "#3d3d3d"
  stipple     "#757575"
  margin      0, 0, 0, 0
  panel       "#202020"
  panel_bottom "#202020"
end
# }}}

# :separator {{{ Style for separator
style :separator do
  foreground  "#757575"
  separator   "|"
end
# }}}
# }}}

# [ Gravities ] {{{
#
# comments {{{
#
# Gravities are predefined sizes a window can be set to. There are several ways
# to set a certain gravity, most convenient is to define a gravity via a tag or
# change them during runtime via grab. Subtler and subtlext can also modify
# gravities.
#
# A gravity consists of four values which are a percentage value of the screen
# size. The first two values are x and y starting at the center of the screen
# and he last two values are the width and height.
#
# === Example
#
# Following defines a gravity for a window with 100% width and height:
#
#   gravity :example, [ 0, 0, 100, 100 ]
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Gravity
#
#  }}}

# Top left
gravity :top_left,       [   0,   0,  50,  50 ]
gravity :top_left66,     [   0,   0,  50,  66 ]
gravity :top_left33,     [   0,   0,  50,  34 ]

# Top
gravity :top,            [   0,   0, 100,  50 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

# Top right
gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

# Left
gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

# Center
gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Right
gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,   0,  33, 100 ]

# Bottom left
gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]

# Bottom
gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

# Bottom right
gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]

# Gimp
gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

# Dia
gravity :dia_toolbox,    [   0,   0,  15, 100 ]
gravity :dia_diagram,    [  15,   0,  85, 100 ]
# }}}

# [ Grabs ] {{{
#
# comments {{{
#
# Grabs are keyboard and mouse actions within subtle, every grab can be
# assigned either to a key and/or to a mouse button combination. A grab
# consists of a chain and an action.
#
# === Finding keys
#
# The best resource for getting the correct key names is
# */usr/include/X11/keysymdef.h*, but to make life easier here are some hints
# about it:
#
# * Numbers and letters keep their names, so *a* is *a* and *0* is *0*
# * Keypad keys need *KP_* as prefix, so *KP_1* is *1* on the keypad
# * Strip the *XK_* from the key names if looked up in
#   /usr/include/X11/keysymdef.h
# * Keys usually have meaningful english names
# * Modifier keys have special meaning (Alt (A), Control (C), Meta (M),
#   Shift (S), Super (W))
#
# === Chaining
#
# Chains are a combination of keys and modifiers to one or a list of keys
# and can be used in various ways to trigger an action. In subtle, there are
# two ways to define chains for grabs:
#
#   1. *Default*: Add modifiers to a key and use it for a grab
#
#      *Example*: grab "W-Return", "urxvt"
#
#   2. *Chain*: Define a list of grabs that need to be pressed in order
#
#      *Example*: grab "C-y Return", "urxvt"
#
# ==== Mouse buttons
#
# [*B1*]  = Button1 (Left mouse button)
# [*B2*]  = Button2 (Middle mouse button)
# [*B3*]  = Button3 (Right mouse button)
# [*B4*]  = Button4 (Mouse wheel up)
# [*B5*]  = Button5 (Mouse wheel down)
# [*...*]
# [*B20*] = Button20 (Are you sure that this is a mouse and not a keyboard?)
#
# ==== Modifiers
#
# [*A*] = Alt key (Mod1)
# [*C*] = Control key
# [*M*] = Meta key (Mod3)
# [*S*] = Shift key
# [*W*] = Super/Windows key (Mod4)
# [*G*] = Alt Gr (Mod5)
#
# === Action
#
# An action is something that happens when a grab is activated, this can be one
# of the following:
#
# [*symbol*] Run a subtle action
# [*string*] Start a certain program
# [*array*]  Cycle through gravities
# [*lambda*] Run a Ruby proc
#
# === Common keys
#
# Space
# Tab
# Enter / Return
# F1 - F12
# Left, Down, Up, Right
# Next, Prior
# Page_Up, Page_Down
# Home, End
# Insert, Delete
# Add, Subtract, Multiply, Divide, Equal
# Decimal
# Num_Lock
# Escape
#
# === Example
#
# This will create a grab that starts a urxvt when Alt+Enter are pressed:
#
#   grab "A-Return", "urxvt"
#   grab "C-a c",    "urxvt"
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Grabs
#
# }}}

modkey = "W"

# [ Views/Screen ] {{{
(1..9).each do |i|
  # Switch current view
  grab modkey + "-#{i}", "ViewSwitch#{i}".to_sym
  # Jump to view1, view2, ...
  grab modkey + "-A-#{i}", "ViewJump#{i}".to_sym
  # Move mouse to screen1, screen2, ...
  grab modkey + "-F#{i}", "ScreenJump#{i}".to_sym
end

# Select next and prev view */
grab modkey + "-period",  :ViewNext
grab modkey + "-comma",   :ViewPrev
# }}}

# [ Windows ] {{{
# Move current window
grab modkey + "-B1", :WindowMove
# Resize current window
grab modkey + "-B3", :WindowResize
# Toggle floating mode of window
grab modkey + "-S-f", :WindowFloat
# Toggle fullscreen mode of window
grab modkey + "-S-space", :WindowFull
# Toggle sticky mode of window (will be visible on all views)
grab modkey + "-S-s", :WindowStick
# Toggle zaphod mode of window (will span across all screens)
# Zaphod mode:
#   This mode spans a window across all screens regardless if the window is normally visible there.
grab modkey + "-S-z", :WindowZaphod
# Raise window
grab modkey + "-S-r", :WindowRaise
# Lower window
grab modkey + "-S-l", :WindowLower
# Kill current window
grab modkey + "-S-k", :WindowKill
grab modkey + "-S-h", lambda { |c| c.retag }
# }}}

# Movement {{{
{
 WindowLeft: [ "Left", "h" ], WindowDown:  [ "Down",  "j" ],
 WindowUp:   [ "Up",   "k" ], WindowRight: [ "Right", "l" ]
}.each do |k, v|
  grab "%s-%s" % [ modkey, v.first ], k
  grab "%s-%s" % [ modkey, v.last  ], k
end
# Tabbing
grab modkey + "-Tab" do
  Subtlext::Client.recent[1].focus
end
# }}}

# Reload/Restart {{{
# Force reload of config and sublets
grab modkey + "-C-r", :SubtleReload
# Force restart of subtle
grab modkey + "-C-S-r", :SubtleRestart
# Quit subtle
grab modkey + "-C-q", :SubtleQuit
# }}}

# gravity {{{
# Cycle between given gravities
gravkeys1 = [ "q", "w", "e", "a", "s", "d", "z", "x", "c" ]
gravkeys2 = [ "KP_7", "KP_8", "KP_9", "KP_4", "KP_5", "KP_6", "KP_1", "KP_2", "KP_3" ]

gravities = [
  [:top_left, :top_left33, :top_left66],
  [:top, :top33, :top66, :top75],
  [:top_right, :top_right33, :top_right66],
  [:left, :left33, :left66],
  [:center, :center33, :center66],
  [:right, :right33, :right66],
  [:bottom_left, :bottom_left25, :bottom_left33, :bottom_left66],
  [:bottom, :bottom33, :bottom66],
  [:bottom_right, :bottom_right25, :bottom_right33, :bottom_right66]
]

gravities.each_index do |i|
  # Set gravities
  grab "%s-%s" % [ modkey, gravkeys1[i] ], gravities[i]
  grab "%s-%s" % [ modkey, gravkeys2[i] ], gravities[i]

  # Focus client with gravity
  grab "%s-S-%s" % [ modkey, gravkeys1[i] ], lambda { |cur|
    idx     = 0
    clients = Subtlext::Client.visible.select { |c|
      gravities[i].include?(c.gravity.name.to_sym)
    }

    # Cycle through clients with same gravity
    if clients.include?(cur)
      idx = clients.index(cur) + 1
      idx = 0 if idx >= clients.size
    end

    clients[idx].focus
  }
end
# }}}

# Multimedia keys {{{
grab "XF86AudioMute",        :VolumeToggle
grab "XF86AudioRaiseVolume", :VolumeRaise
grab "XF86AudioLowerVolume", :VolumeLower
grab "XF86AudioPlay",        :MpdToggle
grab "XF86AudioStop",        :MpdStop
grab "XF86AudioNext",        :MpdNext
grab "XF86AudioPrev",        :MpdPrevious
# }}}

# Functional grabs {{{
# terminal
# "x-terminal-emulator", "urxvt",
terminal = "urxvt"
grab modkey + "-Return", terminal
# browser
# "uzbl", "uzbl-tabbed", "luakit", "jumanji", "firefox", "chromium",
browser = "uzbl-tabbed"
grab modkey + "-b", browser
# Email
# "urxvt -name email -e sh -c 'mutt'", "thunderbird"
email = "urxvt -name email -e sh -c 'mutt'"
grab modkey + "-m", email
# }}}

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

# # move windows {{{ <W-S-Number>
# # This snippet adds nine grabs to move windows on the fly to nine defined views.
# # It uses tagging for this, creates tags based on the view names and applies
# # them when needed.

on :start do
  # Create missing tags
  views = Subtlext::View.all.map { |v| v.name }
  tags  = Subtlext::Tag.all.map { |t| t.name }

  views.each do |v|
    unless tags.include?(v)
      t = Subtlext::Tag.new(v)
      t.save
    end
  end
end

# # Add nine <W-S-Number> grabs
# (1..9).each do |i|
#   grab "W-S-%d" % [ i ] do |c|
#     views = Subtlext::View.all
#     names = views.map { |v| v.name }
#
#     # Sanity check
#     if i <= views.size
#       # Tag client
#       tags = c.tags.reject { |t| names.include?(t.name) or "default" == t.name }
#       tags << names[i - 1]
#
#       c.tags = tags
#
#       # Tag view
#       views[i - 1].tag(names[i - 1])
#     end
#   end
# end
# # }}}

# current view {{{
# This snippet works similar to the previous, it adds tags based on the view
# names. When there is an untagged window (a window with the default tag only)
# it adds the name of the current view as tag, which effectively moves the
# window to the current view.

# # Assign tags to clients
# on :client_create do |c|
#   view = Subtlext::View.current
#   tags = c.tags.map { |t| t.name }
#
#   # Add tag to view
#   view.tag(view.name) unless(view.tags.include?(view.name))
#
#   # Exclusive for clients with default tag only
#   if tags.include?("default") and 1 == tags.size
#     c.tags = [ view.name ]
#   end
# end

# # Tag a new client with the current view only if it has no other tags
# on :client_create do |c|
#   cur = Subtlext::View.current
#
#   # Check for empty tags
#   if (c.tags.empty?)
#     t = Subtlext::Tag[cur.name] rescue nil
#
#     # Create new tag
#     if (t.nil?)
#       t = Subtlext::Tag.new(cur.name)
#       t.save
#     end
#
#     c + t
#   end
# end

# }}}

# volume => W-[-/+] {{{
grab modkey + "-minus", "amixer set Master 2-"
grab modkey + "-plus", "amixer set Master 2+"
# grab modkey + "-minus", "amixer -q sset 'Master' 5%+"
# grab modkey + "-plus", "amixer -q sset 'Master' 5%-"
# }}}

# Scratchpad => W-y {{{
grab "W-y" do
  if (c = Subtlext::Client.first("scratch"))
    c.toggle_stick
    c.focus
  elsif (c = Subtlext::Client.spawn("urxvt -name scratch"))
    c.tags  = []
    c.flags = [ :stick ]
  end
end
# }}}

# MPD ncmpcpp => W-p, W-[, W-] {{{
grab modkey + "-p", "ncmpcpp toggle"
grab modkey + "-bracketleft", "ncmpcpp prev"
grab modkey + "-bracketright", "ncmpcpp next"
# }}}

# sdcv+xsel => W-t {{{
begin
  grab modkey + "-t" do
    # code
  end
end
# }}}

# contrib => W-A-[r/s] {{{
begin
  grab modkey + "-A-r" do
    Subtle::Contrib::Launcher.run
  end

  grab modkey + "-A-s" do
    Subtle::Contrib::Selector.run
  end
rescue Error
end
# }}}
# }}}

# [ Tags ] {{{
#
# comments {{{
#
# Tags are generally used in subtle for placement of windows. This placement is
# strict, that means that - aside from other tiling window managers - windows
# must have a matching tag to be on a certain view. This also includes that
# windows that are started on a certain view will not automatically be placed
# there.
#
# There are to ways to define a tag:
#
# === Simple
#
# The simple way just needs a name and a regular expression to just handle the
# placement:
#
# Example:
#
#  tag "terms", "terms"
#
# === Extended
#
# Additionally tags can do a lot more then just control the placement - they
# also have properties than can define and control some aspects of a window
# like the default gravity or the default screen per view.
#
# Example:
#
#  tag "terms" do
#    match   "xterm|[u]?rxvt"
#    gravity :center
#  end
#
# === Default
#
# Whenever a window has no tag it will get the default tag and be placed on the
# default view. The default view can either be set by the user with adding the
# default tag to a view by choice or otherwise the first defined view will be
# chosen automatically.
#
# === Properties
#
# [*borderless*] This property enables the borderless mode for tagged clients.
#
#                Example: borderless true
#                Links:    http://subforge.org/projects/subtle/wiki/Tagging#Borderless
#                          http://subforge.org/projects/subtle/wiki/Clients#Borderless
#
# [*fixed*]      This property enables the fixed mode for tagged clients.
#
#                Example: fixed true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Fixed
#                         http://subforge.org/projects/subtle/wiki/Clients#Fixed
#
# [*float*]      This property enables the float mode for tagged clients.
#
#                Example: float true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Float
#                         http://subforge.org/projects/subtle/wiki/Clients#Float
#
# [*full*]       This property enables the fullscreen mode for tagged clients.
#
#                Example: full true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Fullscreen
#                         http://subforge.org/projects/subtle/wiki/Clients#Fullscreen
#
# [*geometry*]   This property sets a certain geometry as well as floating mode
#                to the tagged client, but only on views that have this tag too.
#                It expects an array with x, y, width and height values whereas
#                width and height must be >0.
#
#                Example: geometry [100, 100, 50, 50]
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Geometry
#
# [*gravity*]    This property sets a certain to gravity to the tagged client,
#                but only on views that have this tag too.
#
#                Example: gravity :center
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Gravity
#
# [*match*]      This property adds matching patterns to a tag, a tag can have
#                more than one. Matching works either via plaintext, regex
#                (see man regex(7)) or window id. Per default tags will only
#                match the WM_NAME and the WM_CLASS portion of a client, this
#                can be changed with following possible values:
#
#                [*:name*]      Match the WM_NAME
#                [*:instance*]  Match the first (instance) part from WM_CLASS
#                [*:class*]     Match the second (class) part from WM_CLASS
#                [*:role*]      Match the window role
#                [*:type*]      Match the window type
#
#                Examples: match instance: "urxvt"
#                          match [:role, :class] => "test"
#                          match "[xa]+term"
#                Link:     http://subforge.org/projects/subtle/wiki/Tagging#Match
#
# [*position*]   Similar to the geometry property, this property just sets the
#                x/y coordinates of the tagged client, but only on views that
#                have this tag, too. It expects an array with x and y values.
#
#                Example: position [ 10, 10 ]
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Position
#
# [*resize*]     This property enables the float mode for tagged clients. When set,
#                subtle honors size hints, that define various size constraints like
#                sizes for columns and rows of a terminal.
#
#                Example: resize true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Resize
#                         http://subforge.org/projects/subtle/wiki/Clients#Resize
#
# [*stick*]      This property enables the stick mode for tagged clients. When set,
#                clients are visible on all views, even when they don't have matching
#                tags. On multihead, sticky clients keep the screen they are assigned
#                on.
#
#                Supported values are either true or a number to specify a screen.
#
#                Example: stick true
#                         stick 1
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         http://subforge.org/projects/subtle/wiki/Clients#Stick
#
# [*type*]       This property sets the tagged client to be treated as a specific
#                window type though as the window sets the type itself. Following
#                types are possible:
#
#                [*:normal*]   Treat as normal window
#                [*:desktop*]  Treat as desktop window (_NET_WM_WINDOW_TYPE_DESKTOP)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Desktop
#                [*:dock*]     Treat as dock window (_NET_WM_WINDOW_TYPE_DOCK)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Dock
#                [*:toolbar*]  Treat as toolbar windows (_NET_WM_WINDOW_TYPE_TOOLBAR)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Toolbar
#                [*:splash*]   Treat as splash window (_NET_WM_WINDOW_TYPE_SPLASH)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Splash
#                [*:dialog*]   Treat as dialog window (_NET_WM_WINDOW_TYPE_DIALOG)
#                              Link: http://subforge.org/projects/subtle/wiki/Clients#Dialog
#
#                Example: type :desktop
#                Link:    http://subforge.org/projects/subtle/wiki/Tagging#Type
#
# [*urgent*]     This property enables the urgent mode for tagged clients. When set,
#                subtle automatically sets this client to urgent.
#
#                Example: urgent true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Stick
#                         http://subforge.org/projects/subtle/wiki/Clients#Urgent
#
# [*zaphod*]     This property enables the zaphod mode for tagged clients. When set,
#                the client spans across all connected screens.
#
#                Example: zaphod true
#                Links:   http://subforge.org/projects/subtle/wiki/Tagging#Zaphod
#                         http://subforge.org/projects/subtle/wiki/Clients#Zaphod
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#
# }}}

# Placement {{{
tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim"
  resize true
end

tag "gravity" do
  gravity :center
end
# }}}

# Modes {{{
tag "stick" do
  match "MPlayer"
  stick true
end

tag "float" do
  match "display"
  float true
end

tag "stickandfloat" do
  match  "dialog|subtly|python|gtk.rb|display|pychrom|skype|xev|exe|<unknown>|plugin-container"
  stick  true
  float  true
end
# }}}

# tags {{{
# terminal & terminal multiplexer {{{
tag "terminal" do
  match "xterm|[u]?rxvt"
  gravity :right
  resize  false
end

tag "TerminalMultiplexer" do
  match   "Tmux:.*|^screen$"
  gravity :right
  stick   true
  resize  false
end
# }}}

tag "code" do
  match "VIM:\ .*"
  gravity :center
  resize  true
end

tag "browser" do
  match "uzbl|luakit|jumanji|firefox|opera|navigator|(google\-)?chrom[e|ium]"
  gravity :left
end

# Design {{{
# Gimp
tag "Gimp" do
  match role: "gimp.*"

  on_match do |c|
    c.gravity = ("gimp_" + c.role.split("-")[1]).to_sym
  end
end
# Dia
tag "Dia" do
  match "dia"

  on_match do |c|
    c.gravity = ("dia_" + c.role.split("_").first).to_sym
  end
end
# Darktable
tag "Darktable" do
  match [:class, :instance] => "[Dd]arktable"
end
# Inkscape
tag "Inkscape" do
  match [:class, :instance] => "[Ii]nkscape"
end
# }}}

tag "read" do
  match [:class, :instance] => "[Ee]vince|[Zz]athura"
  gravity :left
end

tag "multimedia" do
  match   :class  => "MPlayer|vlc"
  gravity :float
  gravity :top_right33
  resize  true
  stick   true
end

tag "image" do
  match "feh|gpicview"
  gravity :float
  gravity :top_right
  resize  true
  stick   true
end

tag "irc" do
  match :instance => "weechat-curses|irssi", :class => "URxvt"
  gravity :bottom_right
end
# }}}
# }}}

# [ Views ] {{{
#
# comments {{{
#
# Views are the virtual desktops in subtle, they show all windows that share a
# tag with them. Windows that have no tag will be visible on the default view
# which is the view with the default tag or the first defined view when this
# tag isn't set.
#
# Like tags views can be defined in two ways:
#
# === Simple
#
# The simple way is exactly the same as for tags:
#
# Example:
#
#   view "terms", "terms"
#
# === Extended
#
# The extended way for views is also similar to the tags, but with fewer
# properties.
#
# Example:
#
#  view "terms" do
#    match "terms"
#    icon  "/usr/share/icons/icon.xbm"
#  end
#
# === Properties
#
# [*match*]      This property adds a matching pattern to a view. Matching
#                works either via plaintext or regex (see man regex(7)) and
#                applies to names of tags.
#
#                Example: match "terms"
#
# [*dynamic*]    This property hides unoccupied views, views that display no
#                windows.
#
#                Example: dynamic true
#
# [*icon*]       This property adds an icon in front of the view name. The
#                icon can either be path to an icon or an instance of
#                Subtlext::Icon.
#
#                Example: icon "/usr/share/icons/icon.xbm"
#                         icon Subtlext::Icon.new("/usr/share/icons/icon.xbm")
#
# [*icon_only*]  This property hides the view name from the view buttons, just
#                the icon will be visible.
#
#                Example: icon_only true
#
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Tagging
#
# }}}

view "1. shape ideas into code" do
  icon Subtlext::Icon.new("#{iconpath}/terminal.xbm")
  icon_only false
  match "code|programming|TerminalMultiplexer|terminal"
  dynamic false
end

view "2. read" do
  icon Subtlext::Icon.new("#{iconpath}/pencil.xbm")
  dynamic false
  match "read"
end

view "3. design" do
  icon Subtlext::Icon.new("#{iconpath}/paint.xbm")
  dynamic false
  match "design|Gimp|Darktable|Inkscape|Dia"
end

view "4. www" do
  icon Subtlext::Icon.new("#{iconpath}/world.xbm")
  dynamic false
  match "www|browser"
end

view "5. Ruby" do
  icon Subtlext::Icon.new("#{iconpath}/ruby.xbm")
  dynamic false
  match "Ruby"
  gravity :center
end

view "6. default" do
  icon Subtlext::Icon.new("#{iconpath}/quote.xbm")
  dynamic true
  match "default"
  gravity :center
end

# space = {
#   :terminal  => Subtlext::Icon.new("#{iconpath}/terminal.xbm"),
#   :design    => Subtlext::Icon.new("#{iconpath}/paint.xbm"),
#   :editor    => Subtlext::Icon.new("#{iconpath}/pencil.xbm"),
#   :ruby      => Subtlext::Icon.new("#{iconpath}/ruby.xbm"),
#   :bug       => Subtlext::Icon.new("#{iconpath}/bug.xbm"),
#   :www       => Subtlext::Icon.new("#{iconpath}/world.xbm"),
#   :shelter   => Subtlext::Icon.new("#{iconpath}/shelter.xbm"),
#   :cannon    => Subtlext::Icon.new("#{iconpath}/cannon.xbm"),
#   :ufo       => Subtlext::Icon.new("#{iconpath}/ufo.xbm"),
#   :void      => Subtlext::Icon.new("#{iconpath}/invader.xbm")
# }
#
# on :view_focus do |v|
#   views = Hash[*Subtlext::Screen.all.map { |s|
#     [ s.view.name.to_sym, space[space.keys[s.id]] ] }.flatten
#   ]
#
#   Subtlext::View.all.each do |va|
#     sym = va.name.to_sym
#
#     if views.keys.include?(sym)
#       va.icon.copy_area(views[sym])
#     else
#       va.icon.copy_area(space[va.name.to_sym])
#     end
#   end
#
#   Subtlext::Subtle.render
# end
# }}}

# [ Stacking ] {{{
# There are four stacking layers, ordered from top to bottom:
#   - Fullscreen
#   - Floating
#   - Gravity
#   - Desktop type
# }}}

# [ Sublets ] {{{
#
# comments {{{
#
# Sublets are Ruby scripts that provide data for the panel and can be managed
# with the sur script that comes with subtle.
#
# === Example
#
#  sur install clock
#  sur uninstall clock
#  sur list
#
# === Configuration
#
# All sublets have a set of configuration values that can be changed directly
# from the config of subtle.
#
# There are three default properties, that can be be changed for every sublet:
#
# [*interval*]    Update interval of the sublet
# [*foreground*]  Default foreground color
# [*background*]  Default background color
#
# === sur (subtle user repository)
# sur can also give a brief overview about properties:
#
# ~/.local/share/subtle/
# Usage:
#   - sur install clock
#   - sur uninstall clock
#   - sur notes clock
#   - sur config clock
#
#   - sur template hello
#
# === Example
#
#   sur config clock
#
# The syntax of the sublet configuration is similar to other configuration
# options in subtle:
#
# === Example
#
#  sublet :clock do
#    interval      30
#    foreground    "#eeeeee"
#    background    "#000000"
#    format_string "%H:%M:%S"
#  end
#
#  === Link
#
# http://subforge.org/projects/subtle/wiki/Sublets
#

#
# == Hooks
#
# And finally hooks are a way to bind Ruby scripts to a certain event.
#
# Following hooks exist so far:
#
# [*:client_create*]    Called whenever a window is created
# [*:client_configure*] Called whenever a window is configured
# [*:client_focus*]     Called whenever a window gets focus
# [*:client_kill*]      Called whenever a window is killed
#
# [*:tag_create*]       Called whenever a tag is created
# [*:tag_kill*]         Called whenever a tag is killed
#
# [*:view_create*]      Called whenever a view is created
# [*:view_configure*]   Called whenever a view is configured
# [*:view_jump*]        Called whenever the view is switched
# [*:view_kill*]        Called whenever a view is killed
#
# [*:tile*]             Called on whenever tiling would be needed
# [*:reload*]           Called on reload
# [*:start*]            Called on start
# [*:exit*]             Called on exit
#
# === Example
#
# This hook will print the name of the window that gets the focus:
#
#   on :client_focus do |c|
#     puts c.name
#   end
#
# === Link
#
# http://subforge.org/projects/subtle/wiki/Hooks
#
# }}}

sublet :layout do
  style   :layout
  border  2
  def_layout  "none"
end

sublet :clock do
  interval      60
  style         :clock2
  format_string "%H:%M"
end

sublet :keyboard do
  interval 600
  style :keyboard
  layout "qwertz"
  # width "integer" "Width of screen"
  height 200
  button_fg "#000000"
  button_bg "#ffffff"
  button_shadow "#a8a8a8"
  button_alt "#cdcdcd"
  background "#d0d0d0"
end

sublet :arbi_cpu do
  interval 60
  style   :arbi_cpu
end

sublet :cpuchart do
  interval 180
  style :cpuchart
end

sublet :memory do
  interval 60
  style :memory
end

sublet :arbi_ram do
  interval 60
  style   :arbi_ram
end

sublet :arbi_temperature do
  interval 600
  style :arbi_temperature
end

sublet :membar do
  interval 120
  style   :membar
  width   50
  height  10
  # font   "FONT"
end

sublet :loadavg do
  interval 120
  style :loadavg
end

sublet :uptime do
  interval 300
  style :uptime
end

# temperature
sublet :temp do
  interval 600
  style :temp
  scale "C"
  show_name true
  # monitors string/array
  separator "|"
end

sublet :freq do
  interval 600
  style :freq
end

sublet :battery do
  interval 600
  style :battery
  # path "/sys/class/power_supply/B*"
  # colors {hash}
  color_icon true
  color_text true
end

sublet :nettraffic do
  interval 60
  style :nettraffic
  iface_name  "ppp0"
end

sublet :netchart do
  interval 60
  style :netchart
  device "ppp0"
  # title ""
  rx_color "#ff0000"
  tx_color "#0000ff"
  # bg_color "Color of panel"
  width 30
  height 10
end

sublet :arbi_net do
  interval 60
  style :arbi_net
  interfaces ["ppp0", "wlan0"]
end

sublet :arbi_eth0_wlan0 do
  interval 60
  style :arbi_eth0_wlan0
end

sublet :wifi do
  interval 180
  style :wifi
  device "wlan0"
end

sublet :ipaddr do
  interval 600
  style :ipaddr
end

sublet :columns do
  interval 120
  style :columns
  border 2
end

# note: $ sudo modprobe snd_mixer_oss
# you'd better add this line into a initial file.
sublet :volume do
  interval 120
  style :volume
  step 5
end

sublet :mpd do
  interval 60
  style :mpd
  host "localhost"
  port 6600
  def_action  "toggle"
  wheel_up  "next"
  wheel_down "previous"
  # format_string "%note%%artist% - %album%"
  format_string "%title% - %artist%"
  show_icons  true
  show_pause true
  show_colors true
  not_running_text "-- not running --"
  stop_text "mpd stopped"
  pause_text "-- paused --"
  blank_text "n/a"
  note_color "#ffffff"
  artist_color "#757575"
  album_color "#757575"
  title_color "#757575"
  track_color "#757575"
  id_color "#757575"
  pause_color "#757575"
  stop_color "#757575"
end

sublet :maildir do
  interval 300
  style :maildir
  dir "#{ENV["HOME"]}/Mails/INBOX/new"
  label "Mail"
end

sublet :notify do
  interval 120
  style :notify
  font "-*-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
  foreground "sublets_fg"
  background "sublets_bg"
  highlight "focus_fg"
end

sublet :betternotify do
  interval 60
  style :betternotify
  font "-*-fixed-*-*-*-*-10-*-*-*-*-*-*-*"
  foreground "sublets_fg"
  background "sublets_bg"
  highlight  "focus_fg"
end

sublet :tasks do
  interval 120
  style :tasks
  color_active "focus_fg"
  color_inactive "views_fg"
  color_separator "sublets_fg"
  separator "|"
  modes true
end

sublet :conky do
  interval 60
  style :conky
end

sublet :weather do
  interval 7200
  style :weather
  locale "cn"
  units "f"
  location "Zhe-Jiang"
  direction "right"
  forecast_length 3
  hide_current false
  current_label "Now"
  temp_suffix ''
  sep '/'
  day_color "#757575"
  temp_color "#B8B8B8"
  sep_color "#FECF35"
end

sublet :weather_mod do
  interval 7200
  style :weather_mod
  locale "cn"
  units "f"
  location "Zhe-Jiang"
  direction "right"
  forecast_length 3
  hide_current false
  current_label "Now"
  temp_suffix '°C'
  sep '/'
  day_color "#757575"
  temp_color "#B8B8B8"
  sep_color "#FECF35"
end
# }}}

# [ startup/autostart ] {{{
on :start do
  Subtlext::Client.spawn "mpd"
  Subtlext::Client.spawn "nm-applet"
  Subtlext::Client.spawn "mlnet"
  Subtlext::Client.spawn "firefox"
end
# }}}

# vim:et:ts=2:sw=2:fdm=marker:fmr={{{,}}}
