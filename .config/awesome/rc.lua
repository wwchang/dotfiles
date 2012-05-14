-- {{{ Libraries
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- require("awful.remote") -- for awesome-client
-- Theme handling library
require("beautiful")
-- Load Debian menu entries
require("debian.menu")
-- widget required
require("vicious")
require("obvious")
-- Notification library
require("naughty")
-- maildir
require("maildir")
-- Calendar
require("calendar2")
-- scratch
require("scratch")
-- Load "run or raise"
require("aweror")
-- hideable minitray
require("minitray")
-- bash powerful widgets
require("bashets")
-- }}}

-- {{{ Variable definitions
local home = os.getenv("HOME")
local scripts_dir = awful.util.getdir("config") .. "/scripts"
local exec  = awful.util.spawn
local sexec = awful.util.spawn_with_shell
local scount = screen.count()
-- }}}

--[[
 {{{ 1,2,3,4,5 keys
 1 -- left click
 2 -- middle click
 3 -- right click
 4 -- middle up
 5 -- middle down
 }}}
--]]

-- {{{ functions
    -- {{{ blinkers
    -- use blinking(any_textbox_widget,blinking_interval_in_seconds). The call of blinking function toggles the blinking of text.
    blinkers = {}
    function blinking(tb,iv)
        if (tb==nil) then
            return
        end
        local fiv = iv or 1
        if blinkers[tb] then
            if blinkers[tb].timer.started then
                blinkers[tb].timer:stop()
            else
                blinkers[tb].timer:start()
            end
        else
            if (tb.text == nil) then
                return
            end
            blinkers[tb]= {}
            blinkers[tb].timer = timer({timeout=fiv})
            blinkers[tb].text = tb.text
            blinkers[tb].empty = 0

            blinkers[tb].timer:add_signal("timeout", function ()
                if (blinkers[tb].empty==1) then
                    tb.text = blinkers[tb].text
                    blinkers[tb].empty=0
                else
                    blinkers[tb].empty=1
                    tb.text = ""
                end
            end)

            blinkers[tb].timer:start()

        end
    end
    -- }}}
-- }}}

-- {{{ THEME
-- beautiful.init("/home/chris/.config/awesome/themes/linkinPark/theme.lua")
local configdir = awful.util.getdir ("config")
beautiful.init(configdir .. "/themes/black/theme.lua")
-- }}}

-- COLOURS {{{ TODO modify those colors
coldef    = "</span>"
cblack    = "<span color = '#000000'>" -- black
cred      = "<span color = '#FF5F87'>" -- red
cgreen    = "<span color = '#00FF00'>" -- green
cyellow   = "<span color = '#FFFF00'>" -- yellow
cbrown    = "<span color = '#FF8700'>" -- brown
cblue     = "<span color = '#00AFFF'>" -- blue
cmagenta  = "<span color = '#AF00FF'>" -- magenta
ccyan     = "<span color = '#00FFFF'>" -- cyan
cwhite    = "<span color = '#FFFFFF'>" -- white
cgrey     = "<span color = '#464646'>" -- grey
cdred     = "<span color = '#BB0000'>" -- dark-red
cdgreen   = "<span color = '#008700'>" -- dark-green
cdyellow  = "<span color = '#BBBB00'>" -- dark-yellow
cdbrown    = "<span color = '#FF5F00'>" -- dark-brown
cdblue    = "<span color = '#005FFF'>" -- dark-blue
cdmagenta = "<span color = '#BB00BB'>" -- dark-magenta
cdcyan    = "<span color = '#00BBBB'>" -- dark-cyan
cdgrey    = "<span color = '#4E4E4E'>" -- dark-grey
-- }}}

-- This is used later as the default terminal and editor to run.
-- terminal = "x-terminal-emulator"
terminal = "urxvtc" -- USE urxvtc for daemon urxvtd.
-- terminal = "gnome-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = "/usr/bin/firefox" -- browser = "chromium%-browser"
mail = "mutt" -- mail = "thunderbird"
--[[
Default modkey.
Usually, Mod4 is the key with a logo between Control and Alt.
If you do not like this or do not have such a key,
I suggest you to remap Mod4 to another key using xmodmap or other tools.
However, you can use another modifier like Mod1, but it may interact with others.
Mod1 -> Alt
Mod4 -> Windows key
--]]
altkey = "Mod1"
modkey = "Mod4"

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened! see ~/.xsession-errors",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- If you wish to change default settings, you can redefine any of the following fields. For details refer to luadoc.
naughty.config.default_preset.timeout          = 15
naughty.config.default_preset.screen           = 1
naughty.config.default_preset.position         = "top_left"
naughty.config.default_preset.margin           = 15
naughty.config.default_preset.height           = nil -- default = nil
naughty.config.default_preset.width            = 450
naughty.config.default_preset.gap              = 10
naughty.config.default_preset.ontop            = true
naughty.config.default_preset.font             = "Comic Sans MS 10"
-- naughty.config.default_preset.icon             = nil
-- naughty.config.default_preset.icon_size        = 16
naughty.config.default_preset.fg               = beautiful.fg_focus
naughty.config.default_preset.bg               = beautiful.bf_focus
naughty.config.presets.normal.border_color     = beautiful.border_focus
naughty.config.default_preset.border_width     = 1
naughty.config.default_preset.hover_timeout    = nil

-- -------------- Auto startup simple way  --------------------------
--[[
If you want to run your apps only once and not every time awesome is restarted, create this simple script:
    #! /bin/bash
    # Run program unless it's already running.
    if [ -z "`ps -Af | grep -o -w ".*$1" | grep -v grep | grep -v run-once`" ]; then
        $@
    fi
run_once in your $PATH and make it executable. then autostart
your apps like this:
awful.util.spawn_with_shell("run_once firefox")
Alternatively you can use the following to avoid an external script (this also ignore commands running as other users than yourself):
--]]
function run_once(prg)
    if not prg then
        do return nil end
    end
    awful.util.spawn_with_shell("pgrep -f -u $USER -x " .. prg .. " || (" .. prg .. ")")
end
--[[
-- [ examples ]
sexec("gnome-terminal --role=now -x wicd-curses")
sexec("urxvt -name ncmpcpp -e sh -c 'ncmpcpp play'")
sexec("videoBackground")
sexec("urxvt -name wiki -e sh -c 'vim +VimwikiIndex +Calendar' ")
sexec("urxvt -name session -e sh -c 'task shell'")
sexec("urxvt -name 9 -e sh -c 'tmux attach -t Daily'")
--]]

--sexec("urxvt -name 8 -e sh -c 'xrdb ~/.Xresources; sleep 30 ' ")
--sexec("urxvt -name 8 -e sh -c 'mplayer ~/Pictures/videos/XieLe.avi' ")
--sexec("evince '/media/tux/data/Computer/Python/Python\ Standard\ Library\ by\ Example.pdf'")

run_once("urxvtd")
run_once("mpd")
run_once("mlnet")
run_once("nm-applet")
--run_once("anki")
-- run_once("xscreensaver","-no-splash")

-- run_once("wicd-gtk")
-- It is possible to set up Urxvt so that a single Daemon runs, and individual client windows connect to it, (urxvtd and urxvtc), the advantage of this is reduced
-- memory usage, although a crash would affect all windows.
-- run_once("urxvtd -q -o -f")

--[[
Or this slightly more advanced version which permits to use command line options
and to specify on which screen to launch your programs. It also allows for the
case when the name of the process is different from the name of the command used
to launch it (e.g. with wicd-client).
--]]
--[[
function run_once(prg,arg_string,pname,screen)
    if not prg then
        do return nil end
    end

    if not pname then
        pname = prg
    end

    if not arg_string then
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
    else
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
    end
end

run_once("xscreensaver","-no-splash")
run_once("empathy",nil,nil,2)
run_once("wicd-client",nil,"/usr/bin/python2 -O /usr/share/wicd/gtk/wicd-client.py")

-- }}}
--]]

--[[ random wallpapers {{{
-- seed and "pop a few"
math.randomseed( os.time())
for i=1,1000 do tmp=math.random(0,1000) end
x = 0
-- setup the timer
mytimer = timer { timeout = x }
mytimer:add_signal("timeout", function()
    -- tell awsetbg to randomly choose a wallpaper from your wallpaper directory
    -- os.execute("awsetbg -C -r /media/tux/Pictures/&")
    os.execute("feh --bg-center -r /media/tux/Pictures/anime/ &")
    -- stop the timer (we don't need multiple instances running at the same time)
    mytimer:stop()
    -- define the interval in which the next wallpaper change should occur in seconds
    -- (in this case anytime between 10 and 3 minutes)
    x = math.random( 600, 900)
    --restart the timer
    mytimer.timeout = x
    mytimer:start()
end)
-- initial start when rc.lua is first run
mytimer:start()

random xscreensaver
x= 0
-- setup the timer
mytimer = timer { timeout = x }
mytimer:add_signal("timeout", function()
    -- list the wallpaper you want to use (They can be found in /usr/lib/xscreensaver/) followed by any additional
    -- parameters you need in a separate array element
    back = { "atlantis", "-whalespeed 826 -size 3027 -count 15",  "substrate", "", "fliptext", "", "glmatrix", "-mode hex" }
    -- kill any screensaver from the list that might be running
    for i=1, table.getn(back),2 do
        os.execute("killall -I ".. back[i] .. " 2> /dev/null")
    end
    -- set the background colour to black (just in case, as sometimes the screensavers seem to keep whatever is in the videobuffer)
    os.execute("xsetroot -bg black")
    -- select a new screensaver
    y = math.random( 1, (table.getn(back)/2))-1
    os.execute( "/usr/lib/xscreensaver/" .. back[ (y*2) + 1] .. " -root " .. back[ (y*2) + 2] .. "&")
    -- define the interval in which the next wallpaper change should occur in seconds
    -- (in this case anytime between 10 and 20 minutes)
    x = math.random( 600, 1200)
    -- reset the timer
    mytimer:stop()
    mytimer.timeout = x
    mytimer:start()
end)
-- initial start on the first run
mytimer:start()
-- }}}
--]]



-- ----------------------- layouts -----------------------------------
-- Table of layouts to cover with awful.layout.inc, order matters.
-- you can comment or delete them if you do not want to use them forever.
layouts =
{
    awful.layout.suit.tile.left,        -- 1 left title
    awful.layout.suit.tile,             -- 2
    awful.layout.suit.tile.bottom,      -- 3
    awful.layout.suit.tile.top,         -- 4
    awful.layout.suit.max,              -- 5
    awful.layout.suit.fair,             -- 6
    awful.layout.suit.fair.horizontal,  -- 7
    awful.layout.suit.floating,         -- 8
    awful.layout.suit.spiral,           -- 9
    awful.layout.suit.spiral.dwindle,   -- 10
    awful.layout.suit.max.fullscreen,   -- 11
    awful.layout.suit.magnifier         -- 12 center popout
}

-- {{{ Tags
-- change the name and layout per tag
tags = {
  names  = { "1. shape ideas into text. ", "2. Read & Fuck", "3. session", "4. Design ", "5. Log ", "6. Media ", "7. www ", "8. Temp ", "9. Do It Now. "},
  layout = { layouts[11], layouts[2], layouts[5], -- tags: 1, 2, 3
             layouts[2], layouts[12], layouts[2], --       4, 5, 6
             layouts[2], layouts[2], layouts[6]  --       7, 8, 9
}}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
    --for i, t in ipairs(tags[s]) do
        --awful.tag.setproperty(t, "mwfact", i==5 and 0.13  or  0.5)
        --awful.tag.setproperty(t, "hide",  (i==5 or  i==6) and true)
    --end
end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   -- { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart awesome", awesome.restart },
   { "quit awesome", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}


-- ------------------------------------------------  widget ------------------------------------------------
-- Create a textclock widget
-- mytextclock = awful.widget.textclock({ align = "right" })
-- mytextclock = awful.widget.textclock({ align = "right" }, " %a %b %d, %H:%M ", 1)

dateicon = widget({ type = "imagebox" })
dateicon.image = image(beautiful.widget_date)
-- Calendar2
mytextclock = awful.widget.textclock({ align = "right" }, " %a %b %d [%H:%M:%S] ", 1)
-- Calendar widget to attach to the textclock
-- require('calendar2')
calendar2.addCalendarToWidget(mytextclock)

-- {{{ CPU widget
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
-- Initialize widgets
cpugraph  = awful.widget.graph()
-- Graph properties
cpugraph:set_width(50):set_height(18)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_gradient_angle(0):set_gradient_colors({
   beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
}) -- Register widgets
vicious.register(cpugraph,  vicious.widgets.cpu,      "$1")
tzswidget = widget({ type = "textbox" })
vicious.register(tzswidget, vicious.widgets.thermal, " $1C", 19, "thermal_zone0")

cputwidget = widget({ type = "textbox" })
	vicious.register(cputwidget, vicious.widgets.cpu,
	function (widget, args)
		if  args[1] >= 50 and args[1] <=75 then
			return "" .. cred .. " " .. coldef .. cred .. args[1] .. "%" .. coldef .. ""
		elseif args[1] >= 75 then
			return "" .. cdred .. " " .. coldef .. cdred .. args[1] .. "%" .. coldef .. ""
		else
			return "" .. cred .. " " .. coldef .. cred .. args[1] .. "%" .. coldef .. ""
		end
	end )
cputwidget:buttons(awful.util.table.join(awful.button({}, 1, function () awful.util.spawn ( terminal .. " -e htop --sort-key PERCENT_CPU") end ) ) )
-- }}}

-- CPU temperature widget
tempicon = widget({ type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)
tempwidget = widget({ type = "textbox" })
	vicious.register(tempwidget, vicious.widgets.thermal,
	function (widget, args)
		if  args[1] >= 65 and args[1] < 70 then
			return "" .. cyellow .. " " .. coldef .. cyellow .. args[1] .. "°C" .. coldef .. ""
		elseif args[1] >= 70 and args[1] < 75 then
			return "" .. cyellow .. " " .. coldef .. cred .. args[1] .. "°C" .. coldef .. ""
		elseif args[1] > 80 then
			naughty.notify({ title = "Temperature Warning", text = "Running hot! " .. args[1] .. "°C!\nTake it easy.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
			return "" .. cyellow .. " " .. coldef .. cred .. args[1] .. "°C" .. coldef .. ""
		else
			return "" .. cyellow .. " " .. coldef .. cdyellow .. args[1] .. "°C" .. coldef .. ""
		end
	end, 19, "thermal_zone0" )

-- RAM widget
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
memwidget = widget({ type = "textbox" })
	vicious.cache(vicious.widgets.mem)
	-- vicious.register(memwidget, vicious.widgets.mem, "" .. colwhi .. "Ram " .. coldef .. colbyel .. "$1% ($3M)" .. coldef .. "", 13)
	-- vicious.register(memwidget, vicious.widgets.mem, "" .. colblu .. "Ram " .. coldef .. colbblu .. "$1% ($6M)" .. coldef .. "", 13)
	vicious.register(memwidget, vicious.widgets.mem, "" .. cdbrown .. " " .. coldef .. cdbrown .. "$1% ($6M)" .. coldef .. "", 13)

-- RAM bar widget
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_vertical(true):set_ticks(true)
membar:set_height(18):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_gradient_colors({ beautiful.fg_widget,
   beautiful.fg_center_widget, beautiful.fg_end_widget
})
vicious.register(membar, vicious.widgets.mem, "$1", 13)

-- swap widget
-- swapwidget = widget({ type = "textbox" })
	-- vicious.cache(vicious.widgets.mem)
	-- vicious.register(swapwidget, vicious.widgets.mem, "" .. clblack .. "swap " .. coldef .. clblack .. "$5% ($6 M)" .. coldef .. "", 13)

-- Uptime
uptimeicon = widget({ type = "imagebox" })
uptimeicon.image = image(beautiful.widget_uptime)
uptimewidget = widget({ type = "textbox" })
-- vicious.register( uptimewidget, vicious.widgets.uptime, "uptime $2h:$3m")
vicious.register( uptimewidget, vicious.widgets.uptime, "" .. cdcyan .. " " .. coldef .. cdcyan .. " $2h:$3m" .. coldef .. "")

-- load average
loadavgicon = widget({ type = "imagebox" })
loadavgicon.image = image({beautiful.widget_loadavg})
loadavgwidget = widget({ type = "textbox" })
-- $4 for 1 minutes, $5 for 5 minutes, $6 for 15 minutes.
vicious.register( loadavgwidget, vicious.widgets.uptime, "" .. cgreen .. " " .. coldef .. cgreen .. " $4 $5 $6" .. coldef .. "")

-- operating system info
osinfowidget = widget({ type = "textbox"})
vicious.register( osinfowidget, vicious.widgets.os, "" .. cgrey .. "OS:" .. coldef .. cblack .. " $4" .. coldef .. "")

-- disk I/O
diowidget = widget({ type = "textbox"})
    vicious.cache(vicious.widgets.dio)
    vicious.register( diowidget, vicious.widgets.dio, "" .. cdcyan .. "I/O:" .. coldef .. ccyan .. " ${sda total_kb}k" .. coldef .. "")

-- {{{ file system
fsicon = widget({ type = "imagebox" })
fsicon.image = image(beautiful.widget_fs)
-- Initialize widgets
fs = {
  b = awful.widget.progressbar(), r = awful.widget.progressbar(),
  h = awful.widget.progressbar(), s = awful.widget.progressbar()
}
-- Progressbar properties
for _, w in pairs(fs) do
  w:set_vertical(true):set_ticks(true)
  w:set_height(18):set_width(7):set_ticks_size(2)
  w:set_border_color(beautiful.border_widget)
  w:set_background_color(beautiful.fg_off_widget)
  w:set_gradient_colors({ beautiful.fg_widget,
     beautiful.fg_center_widget, beautiful.fg_end_widget
  }) -- Register buttons
  w.widget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () exec("rox", false) end)
  ))
end -- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
vicious.register(fs.b, vicious.widgets.fs, "${/boot used_p}", 599)
vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",     599)
vicious.register(fs.h, vicious.widgets.fs, "${/home used_p}", 599)
vicious.register(fs.s, vicious.widgets.fs, "${/media/tux used_p}", 599)
-- }}}

-- OLD
--fswidget = widget({ type = "textbox"})
    --vicious.cache(vicious.widgets.fs)
    --vicious.register( fswidget, vicious.widgets.fs, "" .. cmagenta .. " " .. coldef .. cmagenta .. " ${/home avail_p}%" .. coldef .. "")

-- weather:
weathericon = widget({ type = "imagebox" })
weathericon.image = image(beautiful.widget_weather)
weatherwidget = widget({ type = "textbox" })
weather_t = awful.tooltip({ objects = { weatherwidget },})
vicious.register(weatherwidget, vicious.widgets.weather,
                function (widget, args)
                    weather_t:set_text("City: " .. args["{city}"] .. "\nWeather: " .. args["{weather}"] .. "\nTempc" .. args["{tempc}"] .. "°C" .. "\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"])
                    return " Weather: " .. args["{weather}"] .. " | " .. args["{tempc}"] .. "°C"
                end, 1800, "ZSHC")
                --'1800': check every 30 minutes.
                --'ZSHC': the Montreal ICAO code. (HangZhou China)

-- Create a systray
mysystray = widget({ type = "systray" })
-- myicon = widget({ type = "imagebox" })
-- myicon.image = image(awful.util.getdir("config") .. "/myicon.png")
-- creat a textbox
-- mytextbox = widget({ type = "textbox" })
-- mytextbox.text = '<span color="red" font="Evanescent 14">  [ EVan+escéncç † ]  </span> '

mytextword = widget({ type = "textbox" })
-- mytextword.text = "" .. cred .. "Programmers Shape ideas into text. » " .. coldef .. ""
mytextword.text = "" .. cred .. "  » " .. coldef .. ""

-- {{ separator
foursquare = widget({ type = "textbox" })
foursquare.text  = "<span color='#87AF00'> ⌘ </span>"
separator_sign = widget({ type = "textbox" })
separator_sign.text = "<span color='#151515'> | </span>"
separator_image = widget({ type = "imagebox" })
separator_image.image = image(beautiful.widget_sep)
-- }}}

-- Net widgets
dnicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_net)
upicon = widget({ type = "imagebox" })
upicon.image = image(beautiful.widget_netup)

-- eth
neteupwidget = widget({ type = "textbox" })
	vicious.cache(vicious.widgets.net)
	vicious.register(neteupwidget, vicious.widgets.net, "" .. cwhite .. " " .. coldef .. cwhite .. "${eth0 up_kb}k " .. coldef .. "")

netedownwidget = widget({ type = "textbox" })
	vicious.register(netedownwidget, vicious.widgets.net, "" .. cdblue .. " " ..coldef .. cred .. "${eth0 down_kb}k" .. coldef .. "")

-- wlan
netwupwidget = widget({ type = "textbox" })
	vicious.register(netwupwidget, vicious.widgets.net, "" .. cwhite .. " " .. coldef .. cwhite .. "${wlan0 up_kb}k " .. coldef .. "")

netwdownwidget = widget({ type = "textbox" })
	vicious.register(netwdownwidget, vicious.widgets.net, "" .. cdblue .. " " .. coldef .. cdblue .. "${wlan0 down_kb}k " .. coldef .. "")

wifiicon = widget({ type = "imagebox" })
wifiicon.image = image(beautiful.widget_wifi)
wifiwidget = widget({ type = "textbox" })
	vicious.register(wifiwidget, vicious.widgets.wifi,
	function (widget, args)
		if args["{link}"] == 0 then
			netwdownwidget.visible = false
			netwupwidget.visible = false
			return ""
		else
			netwdownwidget.visible = true
			netwupwidget.visible = true
            netedownwidget.visible = false
            neteupwidget.visible = false
			-- return "" .. colred .. "wifi " .. coldef .. colbred .. string.format("%s [%i%%]", args["{ssid}"], args["{link}"]/70*100) .. coldef .. ""
            -- return "" .. colred .. "wifi " .. coldef .. colbred .. string.format("%s [%iMB/s] %i%%", args["{ssid}"], args["{rate}"], args["{link}"]/70*100) .. coldef .. ""
            return "" .. cgrey .. "" .. coldef .. ccyan .. string.format(" %s %i%%", args["{ssid}"], args["{link}"]/70*100) .. coldef .. ""
		end
	end, refresh_delay, "wlan0" )

-- Wifi widget
-- wifiwidget = widget({ type = "textbox" })
-- vicious.register( wifiwidget, vicious.widgets.wifi, "wifi : ${ssid} rate: ${rate}MB/s link: ${link}/70", 5, "wlan0")

-- user's mail
-- mailbox = widget({type = "textbox", align = "right" })
-- mailbox.text = "mail 0"
-- mailbox_timer = timer({ timeout = 15 })
-- mailbox_timer:add_signal("timeout", function()
--     local mfile = io.popen( "python -c \"import mailbox\nprint len(mailbox.mbox(\'/var/spool/mail/chris\'))\"", "r")
--     mailbox.text = "mail "..mfile:read("*a")
--     end
-- )
-- mailbox_timer:start()

-- Mutt mail
local mdir = os.getenv("HOME") .. "/Mails/"
mailicon = widget({ type = "imagebox" })
mailicon.image = image(beautiful.widget_mail)
-- -- Initialize widget
maildirwidget = widget({ type = "textbox" })
-- -- Register widget
-- vicious.register(maildirwidget, vicious.widgets.maildir, { ["INBOX"]="Mail", ["Maildir-2"]="Name2" }, 150, mdir )
vicious.register(maildirwidget, vicious.widgets.maildir, { ["INBOX"]="Inbox", ["unsure"]="unsure" }, 150, mdir )
-- register button
maildirwidget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec("urxvt -e mutt") end), -- left click
   awful.button({ }, 4, function () exec("urxvt -e mutt") end), -- middle mouse up
   awful.button({ }, 5, function () exec("urxvt -e mutt") end) -- middle mouse down
))
-- maildirwidget:buttons(maildirwidget:buttons())

-- {{{ Mail subject
-- mailicon = widget({ type = "imagebox" })
-- mailicon.image = image(beautiful.widget_mail)
-- -- Initialize widget
-- mailwidget = widget({ type = "textbox" })
-- -- Register widget
-- vicious.register(mailwidget, vicious.widgets.mbox, "$1", 181, {home .. "/mail/Inbox", 15})
-- -- Register buttons
-- mailwidget:buttons(awful.util.table.join(
-- awful.button({ }, 1, function () exec("urxvt -T Alpine -e alpine.exp") end)
-- ))
-- }}}

-- Battery widget
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_bat)
batwidget = widget({ type = "textbox" })
	vicious.register(batwidget, vicious.widgets.bat,
	function (widget, args)
		if args[2] >= 30 and args[2] < 75 then
			return "" .. cyellow .. " " .. coldef .. cyellow .. args[2] .. "%" .. coldef .. ""
		elseif args[2] >= 20 and args[2] < 30 then
			return "" .. cdred .. " " .. coldef .. cdred .. args[2] .. "%" .. coldef .. ""
		elseif args[2] < 20 and args[1] == "-" then
			naughty.notify({ title = "Battery Warning", text = "Battery low! "..args[2].."% left!\nBetter get some power.", timeout = 10, position = "top_right", fg = beautiful.fg_urgent, bg = beautiful.bg_urgent })
			-- return "" .. cred .. " " .. coldef .. cred .. args[2] .. "%" .. coldef .. ""
            return blinking(batwidget, 1)
		elseif args[2] < 20 then
			return "" .. cred .. " " .. coldef .. cred .. args[2] .. "%" .. coldef .. ""
		else
			-- return "" .. colgrey .. "Bat " .. coldef .. colbgrey .. args[2] .. "%" .. coldef .. ""
            -- unecho Bat when on A/C, it is unnessery
            return "" .. cdyellow .. " A/C" .. coldef .. ""
		end
	end, 23, "BAT0"	)

-- Volume widget
--volwidget = widget({ type = "textbox" })
    --vicious.register(volwidget, vicious.widgets.volume,
        --function (widget, args)
            --if args[1] == 0 or args[2] == "♩" then
                --return "" .. cgrey .. "♪ " .. coldef .. cred .. "mute" .. coldef .. ""
            --else
                --return "" .. ccyan .. "♪ " .. coldef .. ccyan .. args[1] .. "%" .. coldef .. ""
            --end
        --end, 2, "Master" )
-- 	)

-- {{{ Volume level
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)
-- Initialize widgets
volbar    = awful.widget.progressbar()
volwidget = widget({ type = "textbox" })
-- Progressbar properties
volbar:set_vertical(true):set_ticks(true)
volbar:set_height(18):set_width(8):set_ticks_size(2)
volbar:set_background_color(beautiful.fg_off_widget)
volbar:set_gradient_colors({ beautiful.fg_widget,
   beautiful.fg_center_widget, beautiful.fg_end_widget
}) -- Enable caching
vicious.cache(vicious.widgets.volume)
-- Register widgets ( you can replace "PCM" with "Master"
vicious.register(volbar,    vicious.widgets.volume,  "$1",  2, "Master")
vicious.register(volwidget, vicious.widgets.volume, " $1%", 2, "Master")
-- Register buttons
volbar.widget:buttons(awful.util.table.join(
   awful.button({ }, 1, function () exec("urxvt -e alsamixer") end), -- middle click to open alsamixer in terminal
   -- FIXME mute will mute all channels in alsamixer, but unmute only work on Master channel.
   awful.button({ }, 1, function () exec("amixer -q set Master mute") end), -- middle click to MUTE.
   awful.button({ }, 3, function () exec("amixer -q set Master unmute") end), -- right click to UNMUTE.
   awful.button({ }, 4, function () exec("amixer -q set Master 2dB+", false) end), -- middle mouse up
   awful.button({ }, 5, function () exec("amixer -q set Master 2dB-", false) end) -- middle mouse down
)) -- Register assigned buttons
volwidget:buttons(volbar.widget:buttons())
-- }}}

-- MPD widget
musicicon = widget({ type = "imagebox" })
musicicon.image = image(beautiful.widget_music)
mpdwidget = widget({ type = 'textbox' })
-- TODO add tooltip for mpdwidget
	vicious.register(mpdwidget, vicious.widgets.mpd,
		function (widget, args)
			if args["{state}"] == "Stop" then
				return "" .. ccyan .. " " .. coldef .. cblack .. "Stop" .. coldef .. ""
			elseif args["{state}"] == "Play" then
				return "" .. ccyan .. " " .. coldef .. cblue .. args["{Title}"] .. " - " .. args["{Artist}"] .. coldef .. ""
			elseif args["{state}"] == "Pause" then
				return "" .. ccyan .. " " .. coldef .. cdgrey .. "Pause" .. coldef .. ""
			end
        end)
mpdwidget:buttons(
	awful.util.table.join(
		awful.button({}, 1, function () exec("mpc toggle", false) end), -- here false can avoid cursor switch busy mode
		awful.button({}, 3, function () exec(terminal .. " -e ncmpcpp")   end),
		awful.button({}, 4, function () exec("mpc prev", false) end),
		awful.button({}, 5, function () exec("mpc next", false) end)
	)
)
-- Bashets MPD cover art
    local coverart_nf
    function coverart_show()
        -- destroy old popup, needed when bound to a key
        coverart_hide()
        local img = awful.util.pread(scripts_dir .. "/coverart.sh")
        local ico = image(img)
        local txt = awful.util.pread(scripts_dir .. "/musicinfo.sh")
        -- set desired position of popup during creation
        coverart_nf = naughty.notify({icon = ico, icon_size = 100, text = txt, position = "bottom_left"})
    end

    function coverart_hide()
        if coverart_nf ~= nil then
            naughty.destroy(coverart_nf)
        end
    end

    mpdwidget:add_signal("mouse::enter", function()
        coverart_show()
    end)
    mpdwidget:add_signal("mouse::leave", function()
        coverart_hide()
    end)

    ctitle = ""
    function mpd_callback(data)
        if data[1] ~= ctitle then
        --here "1" may be "3" or "2", or any other number of your variable
            ctitle = data[1]
            coverart_show()
        end
    end
    bashets.register(scripts_dir .. "/mpd.sh", {widget = mpdw, format = '$1 | $2', update_time = 1, separator = '|', callback = mpd_callback})

---- {{{ Org-mode agenda
--orgicon = widget({ type = "imagebox" })
--orgicon.image = image(beautiful.widget_org)
---- Initialize widget
--orgwidget = widget({ type = "textbox" })
---- Configure widget
--local orgmode = {
  --files = { home.."/.org/computers.org",
    --home.."/.org/index.org", home.."/.org/personal.org",
  --},
  --color = {
    --past   = '<span color="'..beautiful.fg_urgent..'">',
    --today  = '<span color="'..beautiful.fg_normal..'">',
    --soon   = '<span color="'..beautiful.fg_widget..'">',
    --future = '<span color="'..beautiful.fg_netup_widget..'">'
--}} -- Register widget
--vicious.register(orgwidget, vicious.widgets.org,
  --orgmode.color.past..'$1</span>-'..orgmode.color.today .. '$2</span>-' ..
  --orgmode.color.soon..'$3</span>-'..orgmode.color.future.. '$4</span>', 601,
  --orgmode.files
--) -- Register buttons
--orgwidget:buttons(awful.util.table.join(
  --awful.button({ }, 1, function () exec("emacsclient --eval '(org-agenda-list)'") end),
  --awful.button({ }, 3, function () exec("emacsclient --eval '(make-remember-frame)'") end)
--))
---- }}}


-- -------------------------------------------  wibox  ---------------------------------------------------
-- Create a wibox for each screen and add it
mywibox = {}

mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                            -- original
                                              -- return awful.widget.tasklist.label.currenttags(c, s)
                                            -- remove tasklist icon without modifying the original
                                            -- tasklist.lua file
                                              local tmptasklist = { awful.widget.tasklist.label.currenttags(c, s) }
                                              return tmptasklist[1], tmptasklist[2], tmptasklist[3], nil
                                          end, mytasklist.buttons)
    --  do not show icon on tasklist
    -- mytasklist_template = { { item = "title", bg_resize = true}, layout = layout.horizontal.leftright }
    -- mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons, nil, mytasklist_template)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "25", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            foursquare,
            mylauncher,
            mytaglist[s], separator_image,
            mypromptbox[s], separator_image,
            layout = awful.widget.layout.horizontal.leftright
        },
        foursquare,
        mylayoutbox[s], separator_image,  -- layout style pic
        s == 1 and mysystray or nil, separator_image, -- systray
        -- remove systray here
        -- s == 1 and nil, separator_image, -- systray
        -- mytextbox, -- code Evanescene
        mytasklist[s], -- task list
        layout = awful.widget.layout.horizontal.rightleft
    }
    -- create a bottom wibox
    mywibox[s] = awful.wibox({ position = "bottom", height = "20", screen = s })
        -- TODO for conky bar.
        -- comment bellowing mywibox[s].widgets = { for conky.
        -- mystatusbar = awful.wibox({ position = "bottom", screen = 1, ontop = false, width = 1, height = 16 })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            foursquare,
            mytextword,
            musicicon, mpdwidget,
            -- osinfowidget,
            -- mailbox, separator_image,
            layout = awful.widget.layout.horizontal.leftright
        },
        foursquare,
        mytextclock, dateicon, separator_image,
        --weatherwidget, weathericon, separator_image,
        volwidget, volbar.widget, volicon,
        separator_image,
        fs.b.widget, fs.r.widget, fs.h.widget, fs.s.widget, fsicon, separator_image,
        tempwidget, tempicon, separator_image,
        uptimewidget, uptimeicon, separator_image,
        batwidget, baticon, separator_image,
        netedownwidget, dnicon, neteupwidget, upicon, separator_image,
        -- wifiwidget, wifiicon,
        netwdownwidget, netwupwidget,
        memwidget, membar.widget, memicon, separator_image,
        -- diowidget, separator_image,
        loadavgwidget, loadavgicon, separator_image,
        cputwidget, cpuicon, separator_image,
        -- cpugraph.widget,
        maildirwidget, mailicon, separator_image,
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- ------------------------------------------  mouse bindings  ------------------------------------------
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- -------------------------------------------  key bindings  --------------------------------------------
-- {{{ Key bindings
globalkeys = awful.util.table.join(

    -- for "run or raise"
    -- globalkeys, aweror.genkeys(modkey),
    aweror.genkeys(modkey),

    -- toggle client floating
    awful.key({ modkey, "Shift" }, "f",  awful.client.floating.toggle ),

    -- toggle titlebar visiblity
    awful.key({ modkey, "Shift" }, "t", function (c)
        if   c.titlebar then awful.titlebar.remove(c)
        else awful.titlebar.add(c, { modkey = modkey }) end
    end),

    -- for minitray.lua
    awful.key({ modkey, "Control" }, "t",   function()  minitray.toggle() end ),

    -- screen saver lock  [ Mod4+Ctrl+l ]
    awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("xscreensaver-command -lock") end),
    -- xlock
    -- awful.key({ modkey }, "F7", function () awful.util.spawn("xlock") end)
    -- awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("xlock") end)

    -- client lists that minimized windows cycle/restore, press "Mod4"+" ; "
    awful.key( { modkey }, ";", function()
        awful.menu.clients({ width = 250 }, { keygrabber = true } )
    end ),
    -- Mod+shift+n unminimize all windows on current tag.
    awful.key({ modkey, "Shift"   }, "n",
    function()
        local tag = awful.tag.selected()
        for i=1, #tag:clients() do
            tag:clients()[i].minimized=false
            tag:clients()[i]:redraw()
        end
    end),
    -- screenshot key "Prt Src"
    -- grab key through $ xev . then press keyboard. display name "Print"
     awful.key({ }, "Print", function ()
         awful.util.spawn("scrot -e 'mv $f ~ 2>/dev/null'")
         os.execute("sleep 0.5")
         naughty.notify({ title="Screenshot", text="The focused window captured" })
     end),
     -- modkey + Shift + Pageup/Pagedown > SoundLow or SoundHigh or mute
     awful.key({ modkey, "Shift" }, "Up",  function ()
         awful.util.spawn("amixer set Master 2+", false)
     end),
     awful.key({ modkey, "Shift" }, "Down",  function ()
         awful.util.spawn("amixer set Master 2-", false)
     end),
     awful.key({ modkey, "Shift" }, "Left",  function ()
         awful.util.spawn("amixer set Master toggle", false)
     end),
     awful.key({ modkey, "Shift" }, "Right",  function ()
         awful.util.spawn("amixer set Master toggle", false)
     end),
     -- modkey + ./, to play next/previouse ncmpcpp song.
     awful.key({ modkey }, "period",  function ()
         awful.util.spawn("mpc next", false)
     end),
     awful.key({ modkey }, "comma",  function ()
         awful.util.spawn("mpc prev", false)
     end),


-- {{{ TODO naughty dict prompt
-- keybinding({ modkey}, "e", function () -- english dict
--     info = true
--     awful.prompt.run({ fg_cursor = "black",bg_cursor="orange", prompt = "<span color='#008DFA'>Dict:</span> " },
--     mypromptbox[mouse.screen],
--     function(word)
--         local f = io.popen("dict -d wn " .. word .. " 2>&1")
--         local fr = ""
--         for line in f:lines() do
--             fr = fr .. line .. '\n'
--         end
--         f:close()
--         naughty.notify({ text = '<span font_desc="Monospace 7">'..fr..'</span>', timeout = 0, width = 400 })
--     end,
--     nil, awful.util.getdir("cache") .. "/dict")
-- end):add(),
-- }}}


    -- {{{ sdcv/stardict
awful.key({ modkey }, "d", function ()
    local f = io.popen("xsel -o")
    local new_word = f:read("*a")
    f:close()

    if frame ~= nil then
        naughty.destroy(frame)
        frame = nil
        if old_word == new_word then
            return
        end
    end
    old_word = new_word

    local fc = ""
    -- cancel -n --non-interactive to let sdcv display exactly word, but relately words
        -- local f  = io.popen("sdcv -n --utf8-output -u '朗道汉英字典5.0' -u 'WordNet' "..cinword)
        --local f  = io.popen("sdcv -n --utf8-output -u '牛津英汉双解美化版' "..cinword)
        -- look up word in multiple dicts
        -- local f  = io.popen("sdcv -n --utf8-output --data-dir '/usr/share/stardict/dic' "..new_word)
        -- local f  = io.popen("sdcv -n --utf8-output --data-dir '/usr/share/stardict/dic' "..cinword)
    -- FIXME if selected word is not english word, use chinese-english dictionary instead.
    --if new_word:match("[^a-zA-Z]") then
    if new_word:find("%a") then
        --f  = io.popen("sdcv -n --utf8-output -u 'WordNet' -u '牛津英汉双解美化版' "..new_word)
        f  = io.popen("sdcv -n --utf8-output -u 'WordNet' -u '朗道英汉字典5.0' "..new_word)

        for line in f:lines() do
            fc = fc .. line .. '\n'
        end
        f:close()

        frame = naughty.notify({ title = '<span color="blue" font="DejaVu Sans Mono bold 12">' ..new_word.. '</span>', text = '<span font="DejaVu Sans Mono bold 9">' ..fc..'</span>', timeout = 30, position = "top_left", width = 700, fg = "black", bg = "white" })

        awful.util.spawn_with_shell( "sleep 0.6 ; echo \""..new_word.."\" | espeak -v en " )
    else
        f  = io.popen("sdcv -n --utf8-output -u '朗道汉英字典5.0' "..new_word)

        for line in f:lines() do
            fc = fc .. line .. '\n'
        end
        f:close()

        frame = naughty.notify({ title = '<span color="blue" font="DejaVu Sans Mono bold 12">' ..new_word.. '</span>', text = '<span font="DejaVu Sans Mono bold 9">' ..fc..'</span>', timeout = 30, position = "top_left", width = 700, fg = "black", bg = "white" })

        awful.util.spawn_with_shell( "sleep 0.6 ; echo \""..new_word.."\" | espeak -v zh " )
    end

    --[[
    for line in f:lines() do
        fc = fc .. line .. '\n'
    end
    f:close()
    --]]
    -- frame = naughty.notify({ title = '<span color="red" font="Droid Sans bold 10">' ..new_word.. '</span>', text = '<span font="WenQuanYi Micro Hei 9">' ..fc..'</span>', timeout = 30, width = 450, fg = "black", bg = "white" })
    --frame = naughty.notify({ title = '<span color="blue" font="DejaVu Sans Mono bold 12">' ..new_word.. '</span>', text = '<span font="DejaVu Sans Mono bold 9">' ..fc..'</span>', timeout = 30, position = "top_left", width = 700, fg = "black", bg = "white" })
        -- {{{ TTS
        -- using spawn_with_shell because of the pipe ;)
        -- awful.util.spawn_with_shell( "echo \""..new_word.."\" | festival --tts" )
        --awful.util.spawn_with_shell( "sleep 0.6 ; echo \""..new_word.."\" | pronounce.sh " )
        -- awful.util.spawn_with_shell( "ncmpcpp pause ; echo \""..new_word.."\" | espeak" )
        -- }}}
end),
awful.key({ modkey, "Shift" }, "d", function ()
    awful.prompt.run({prompt = "Dict: "}, mypromptbox[mouse.screen].widget, function(cinword)
        naughty.destroy(frame)
        if cinword == "" then
            return
        end

        local fc = ""
    -- cancel -n --non-interactive to let sdcv display exactly word, but relately words
        if cinword:find("%a") then
            f  = io.popen("sdcv -n --utf8-output -u 'WordNet' -u '朗道英汉字典5.0' "..cinword)

            for line in f:lines() do
                fc = fc .. line .. '\n'
            end
            f:close()

            frame = naughty.notify({ title = '<span color="blue" font="WenQuanYi Micro Hei Mono bold 12">' ..cinword.. '</span>', text = '<span font="DejaVu Sans Mono bold 9">' ..fc..'</span>', timeout = 30, position = "top_left", width = 700, fg = "black", bg = "white" })

            awful.util.spawn_with_shell( "sleep 0.6 ; echo \""..cinword.."\" | espeak -v en " )
        else
            f  = io.popen("sdcv -n --utf8-output -u '朗道汉英字典5.0' "..cinword)

            for line in f:lines() do
                fc = fc .. line .. '\n'
            end
            f:close()

            frame = naughty.notify({ title = '<span color="blue" font="WenQuanYi Micro Hei Mono bold 12">' ..cinword.. '</span>', text = '<span font="DejaVu Sans Mono bold 9">' ..fc..'</span>', timeout = 30, position = "top_left", width = 700, fg = "black", bg = "white" })

            awful.util.spawn_with_shell( "sleep 0.6 ; echo \""..cinword.."\" | espeak -v zh " )
        end

        --[[
        for line in f:lines() do
            fc = fc .. line .. '\n'
        end
        f:close()
        --]]
        -- frame = naughty.notify({ text = fc, timeout = 30, width = 320 })
    -- frame = naughty.notify({ title = '<span color="red" font="Droid Sans bold 12">' ..cinword.. '</span>', text = '<span font="WenQuanYi Micro Hei 9">' ..fc..'</span>', timeout = 30, width = 450, fg = "black", bg = "white" })
    --frame = naughty.notify({ title = '<span color="red" font="DejaVu Sans Mono bold 12">' ..cinword.. '</span>', text = '<span font="DejaVu Sans Mono bold 9">' ..fc..'</span>', timeout = 30, position = "top_left", width = 700, fg = "black", bg = "white" })
        -- {{{ TTS
        -- using spawn_with_shell because of the pipe ;)
        -- awful.util.spawn_with_shell( "echo \""..cinword.."\" | festival --tts" )
        --awful.util.spawn_with_shell( "sleep 0.6 ; echo \""..cinword.."\" | pronounce.sh " )
        -- awful.util.spawn_with_shell( "ncmpcpp pause ; echo \""..new_word.."\" | espeak" )
        -- }}}
    end, nil, awful.util.getdir("cache").."/dict")
end),
-- }}}

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    -- XXX awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- toggle ncmpcpp play
    awful.key({ modkey,           }, "p",
        function ()
            awful.util.spawn_with_shell( "ncmpcpp toggle" )
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- You can use the awful.client.moveresize function. The following clientkeys example will move floaters with "Mod4 + Arrow keys" and resize them with "Mod4 + PgUP/DN"
    awful.key({ modkey }, "Next",  function () awful.client.moveresize( 20,  20, -40, -40) end),
    awful.key({ modkey }, "Prior", function () awful.client.moveresize(-20, -20,  40,  40) end),
    awful.key({ modkey }, "Down",  function () awful.client.moveresize(  0,  20,   0,   0) end),
    awful.key({ modkey }, "Up",    function () awful.client.moveresize(  0, -20,   0,   0) end),
    awful.key({ modkey }, "Left",  function () awful.client.moveresize(-20,   0,   0,   0) end),
    awful.key({ modkey }, "Right", function () awful.client.moveresize( 20,   0,   0,   0) end),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
awful.key({ modkey },            "r",     function ()
    awful.util.spawn("dmenu_run -i -p 'Run command:' -nb '" ..
 		beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
		"' -sb '" .. beautiful.bg_focus ..
		"' -sf '" .. beautiful.fg_focus .. "'")
	end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


-- Set keys
root.keys(globalkeys)
-- }}}

-- ---------------------------------------  rules  ------------------------------------------------
awful.rules.rules = {
    -- All clients will match this rule.
--      WM_CLASS(STRING) = "smplayer", "Smplayer"
    --                      |           |
    --                      |           |--- class
    --                      |
    --                      |--- instance
--
--  WM_NAME(STRING) = "SMPlayer"
--                     |
--                     |--- name
    -- $ xprop | grep WM_CLASS  ( put the cursor on App )
    -- rules: class, name, instance,
    -- maximized_horizontal, maximized_vertical,
    -- switchtotag, tag = tagobject, floating,
    -- class = { "MPlayer", "openshot" },
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     size_hints_honor = false, -- remove gaps between windows
                     buttons = clientbuttons
                 } },
                 --sticky = true -- for Conky, gkrellm, DockApps etc to be available on every tag..
    -- Set Akregator to tag 8 of the last screen and add a titlebar trough callback
    --  { rule = { class = "Akregator" },properties = {tag = tags[screen.count()][8]}, callback = awful.titlebar.add},
    -- Set Xterm to multiple tags on screen 1
    -- { rule = { class = "XTerm" }, callback = function(c) c:tags({tags[1][5], tags[1][6]}) end},
    -- Set ROX-Filer to tag 2 of the currently selected and active screen
    -- { rule = { class = "ROX-Filer" }, callback = function(c) awful.client.movetotag(tags[mouse.screen][2], c) end},
    -- Set Xterm as floating with a fixed position
    -- { rule = { class = "XTerm" }, properties = {floating = true}, callback = function(c) c:geometry({x=0, y=0}) end},
    -- TODO let tmux and screen window available on many tags.
    -- { rule = { class = "XTerm" }, callback = function(c) c:tags({tags[1][5], tags[1][6]}) end},
    -- remove gaps between windows
    { rule = { class = "MPlayer" },
        properties = {
            floating = true,
            ontop = true
        }
    },

    --[[
    { rule = { class = "Gimp", instance = "gimp", role = "gimp-image-window" },
        properties = {
            tag = tags[1][4],
            floating = true,
            switchtotag = true,
            x = 260,
            y = 30,
            width = 1300,
            height = 1000,
            ontop = true
        }
    },
    { rule = { class = "Gimp", instance = "gimp", role = "gimp-toolbox" },
        properties = {
            tag = tags[1][4],
            floating = true,
            switchtotag = true,
            x = 10,
            y = 30,
            width = 240,
            height = 1000,
            ontop = true
        }
    },
    { rule = { class = "Gimp", instance = "gimp", role = "gimp-doc" },
        properties = {
            tag = tags[1][4],
            switchtotag = true,
            floating = true,
            x = 1600,
            y = 30,
            width = 300,
            height = 1000,
            ontop = true
        }
    },
    --]]

    { rule = { class = "Darktable", instance = "darktable" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][4],
            switchtotag = true
        }
    },
    { rule = { class = "Inkscape", instance = "inkscape" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][4],
            switchtotag = true
        }
    },

    { rule = { class = "Screenkey", instance = "screenkey" },
        properties = {
            sticky = true,
            floating = true,
            ontop = true
        },
        callback = function(c)
            c:tags({
                tags[1][1], tags[1][2], tags[1][3],
                tags[1][4], tags[1][5], tags[1][6],
                tags[1][7], tags[1][8], tags[1][9]
            })
        end
    },
    -- for 1024x768 10' screen
    --[[
    { rule = { class = "Key-mon", instance = "key-mon" },
        properties = {
            x = 745,
            y = 545,
            sticky = true,
            floating = true,
            ontop = true
        },
        callback = function(c)
            c:tags({
                tags[1][1], tags[1][2], tags[1][3],
                tags[1][4], tags[1][5], tags[1][6],
                tags[1][7], tags[1][8], tags[1][9]
            })
        end
    },
    --]]
    -- for 1920x1080 screen
    { rule = { class = "Key-mon", instance = "key-mon" },
        properties = {
            x = 1625,
            y = 1015,
            sticky = true,
            floating = true,
            ontop = true
        },
        callback = function(c)
            c:tags({
                tags[1][1], tags[1][2], tags[1][3],
                tags[1][4], tags[1][5], tags[1][6],
                tags[1][7], tags[1][8], tags[1][9]
            })
        end
    },
    { rule = { class = "Calibre", instance = "calibre" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][8],
            switchtotag = true
        }
    },
    { rule = { class = "VCLSalFrame", instance = "libreoffice-writer" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][2],
            switchtotag = true
        }
    },
    { rule = { class = "Devhelp", instance = "devhelp" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][1],
            switchtotag = true
        }
    },
    { rule = { class = "VirtualBox" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][5],
            switchtotag = true
        }
    },
    -- for Conky, gkrellm, DockApps, etc
    { rule = { name = "gkrellm" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = true,
            ontop = true,
            sticky = true,
            border_width = 0,
            skip_taskbar = true
        },
        callback = function(c)
            c:tags({
                tags[1][1], tags[1][2], tags[1][3],
                tags[1][4], tags[1][5], tags[1][6],
                tags[1][7], tags[1][8], tags[1][9]
            })
        end
    },
    { rule = { class = "Firefox", instance = "Navigator" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][7],
            switchtotag = true
        }
    },
    { rule = { class = "Chromium-browser", instance = "chromium-browser" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][7],
            switchtotag = true
        }
    },
    { rule = { class = "Opera", instance = "opera" },
        properties = {
            maximized_horizontal = true,
            maximized_vertical = true,
            floating = false,
            tag = tags[1][7],
            switchtotag = true
        }
    },
    { rule = { class = "Empathy", instance = "empathy", role = "contact_list" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = true,
            x = 1600,
            y = 50,
            width = 300,
            height = 800,
            tag = tags[1][6],
            switchtotag = true
        }
    },
    { rule = { class = "Empathy", instance = "empathy-chat", role = "chat" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = true,
            x = 150,
            y = 150,
            width = 900,
            height = 800,
            tag = tags[1][6],
            switchtotag = true
        }
    },
    { rule = { class = "Zathura", instance = "zathura" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = false,
            tag = tags[1][2],
            switchtotag = true
        }
    },
    { rule = { class = "Evince", instance = "evince" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = false,
            tag = tags[1][2],
            switchtotag = true
        }
    },
    { rule = { class = "Chmsee", instance = "chmsee" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = false,
            tag = tags[1][2],
            switchtotag = true
        }
    },
    { rule = { class = "Anki", instance = "anki" },
        properties = {
            maximized_horizontal = false,
            maximized_vertical = false,
            floating = false,
            tag = tags[1][2],
            switchtotag = true
        }
    },


    --  ----------------------------------------------------
    -- for urxvt and gnome-terminal auto startup
    { rule = { instance = "1", role = "1" },
      properties = { tag = tags[1][1], switchtotag = true
    } },
    { rule = { instance = "2", role = "1" },
      properties = { tag = tags[1][2], switchtotag = true
    } },
    { rule = { instance = "3", role = "1" },
      properties = { tag = tags[1][3], switchtotag = true
    } },
    { rule = { instance = "4", role = "1" },
      properties = { tag = tags[1][4], switchtotag = true
    } },
    { rule = { instance = "5", role = "1" },
      properties = { tag = tags[1][5], switchtotag = true
    } },
    { rule = { instance = "6", role = "1" },
      properties = { tag = tags[1][6], switchtotag = true
    } },
    { rule = { instance = "7", role = "1" },
      properties = { tag = tags[1][7], switchtotag = true
    } },
    { rule = { instance = "8", role = "1" },
      properties = { tag = tags[1][8], switchtotag = true
    } },
    { rule = { instance = "9", role = "1" },
      properties = { tag = tags[1][9], switchtotag = true
    } },

-- }}}

    -- set terminal visible in several tags ( VimWiki let you record your knowledge )
--     { rule = { instance = "VimWiki" },
--     properties = { floating = false, sticky = true }, -- sticky will make client avaliable on all tags
--     callback = function(c)
--         c:tags({tags[1][1], tags[1][2], tags[1][3], tags[1][4], tags[1][5], tags[1][7], tags[1][8], tags[1][9] })
--     end
--     },
    ----------------------------
--     { rule = { instance = "VimWiki" },
--     properties = { floating = false, sticky = true }, -- sticky will make client avaliable on all tags
--     tag = tags[1][9], switchtotag = true
--     },

}
-- }}}

-- -- list of matches
-- myapps = { { name = "code" }, { name = "view" }, { name = "IRC" }, { name = "Game" }, { name = "Down" }, { name = "media" }, { name = "Temp" }, { name = "www" }, { name = "now" } }
-- -- generate list of additional rules
-- for index, value in ipairs(myapps) do
--    myrules[index] = { rule = value,
--    properties = { tag = tags[1][index],
--    switchtotag = true, floating = false }
-- }
-- end
-- -- add generate rules to global rules table
-- awfule.rules.rules = awful.util.table.join(awful.rules.rules, myrules)

-- ---------------------------------------------------  signals  ----------------------------------------------------
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
