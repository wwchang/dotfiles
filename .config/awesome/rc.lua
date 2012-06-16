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

-- {{{ variable definitions
    local home = os.getenv("HOME")
    local scripts_dir = awful.util.getdir("config") .. "/scripts"
    local exec  = awful.util.spawn
    local sexec = awful.util.spawn_with_shell
    local scount = screen.count()
-- }}}

-- {{{ [ functions ]
    -- {{{ blinkers
    -- use blinking(any_textbox_widget,blinking_interval_in_seconds).
    -- The call of blinking function toggles the blinking of text.
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

-- {{{ [ Theme ]
    -- beautiful.init("/home/chris/.config/awesome/themes/linkinPark/theme.lua")

    local configdir = awful.util.getdir ("config")
    beautiful.init(configdir .. "/themes/black/theme.lua")
-- }}}

-- {{{ [ Colors ]
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

-- [ settings ] {{{
    -- terminal = "x-terminal-emulator"
    -- terminal = "gnome-terminal"
    terminal = "urxvt" -- USE urxvtc for daemon urxvtd.
    editor = os.getenv("EDITOR") or "vim"
    editor_cmd = terminal .. " -e " .. editor
    browser = "/usr/bin/firefox" -- browser = "chromium%-browser"
    mail = "mutt" -- mail = "thunderbird"

    --[[ Mod key.
        Usually, Mod4 is the key with a logo between Control and Alt.  If you do
        not like this or do not have such a key, I suggest you to remap Mod4 to
        another key using xmodmap or other tools.  However, you can use another
        modifier like Mod1, but it may interact with others.

        Mod1 -> Alt
        Mod4 -> Windows key
    --]]
    altkey = "Mod1"
    modkey = "Mod4"

    --[[
    {{{ 1,2,3,4,5 keys means
        1 -- left click
        2 -- middle click
        3 -- right click
        4 -- middle up
        5 -- middle down
    }}}
    --]]

-- }}}

-- {{{ Error handling
    -- Check if awesome encountered an error during startup and fell back to
    -- another config (This code will only ever execute for the fallback config)
    if awesome.startup_errors then
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, there were errors during startup!",
                         text = awesome.startup_errors })
    end

    -- handle runtime errors after startup
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

-- {{{ naughty notify settings
    naughty.config.default_preset.timeout          = 10
    naughty.config.default_preset.screen           = 1
        -- top_left, top_right, bottom_left, bottom_right.
    naughty.config.default_preset.position         = "top_left"
    naughty.config.default_preset.margin           = 20
    naughty.config.default_preset.height           = nil -- default = nil
    naughty.config.default_preset.width            = 450
    naughty.config.default_preset.gap              = 10
    naughty.config.default_preset.ontop            = true
    naughty.config.default_preset.font             = beautiful.font
    naughty.config.default_preset.icon             = beautiful.notify_icon
    naughty.config.default_preset.icon_size        = 40
    naughty.config.default_preset.fg               = beautiful.fg_focus
    naughty.config.default_preset.bg               = beautiful.bf_focus
    naughty.config.presets.normal.border_color     = beautiful.border_focus
    naughty.config.default_preset.border_width     = 1
    naughty.config.default_preset.hover_timeout    = nil
-- }}}

-- {{{ -------------- Auto startup simple way  --------------------------
    --[[
    If you want to run your apps only once and not every time awesome is
    restarted, create this simple script:
        #! /bin/bash
        # Run program unless it's already running.
        if [ -z "`ps -Af | grep -o -w ".*$1" | grep -v grep | grep -v run-once`" ]; then
            $@
        fi
    run_once in your $PATH and make it executable. then autostart
    your apps like this:
    awful.util.spawn_with_shell("run_once firefox")
    Alternatively you can use the following to avoid an external script (this
    also ignore commands running as other users than yourself):
    --]]

--[[ sexec examples
    sexec(terminal .. "-name ncmpcpp -e sh -c 'ncmpcpp play'")
    sexec(terminal .. "-name wiki -e sh -c 'vim +VimwikiIndex +Calendar' ")
    sexec(terminal .. "-name 8 -e sh -c 'xrdb ~/.Xresources; sleep 30 ' ")
--]]

--[[
function run_once(prg)
    if not prg then
        do return nil end
    end
    awful.util.spawn_with_shell("pgrep -f -u $USER -x " .. prg .. " || (" .. prg .. ")")
end
--]]

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

run_once("urxvtd -q -o -f")
run_once("mpd")
run_once("mlnet")
run_once("nm-applet")

-- TODO what does this screen argument means.
-- run_once("luakit", nil, nil, 6)
-- run_once("xscreensaver","-no-splash")
-- run_once("wicd-gtk")
-- run_once("wicd-client",nil,"/usr/bin/python2 -O /usr/share/wicd/gtk/wicd-client.py")
-- }}}

-- {{{ [ Layout ]
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
-- }}}

-- {{{ [ Tags ]
tags = {
    names  = { " 1. shape ideas into code ", "2. Read & Fuck", "3. session",
               "4. Design ", "5. Log ", "6. Media ",
               "7. www ", "8. Temp ", "9. Do It Now. "
            },
    layout = { layouts[11], layouts[2], layouts[5], -- tags: 1, 2, 3
               layouts[2], layouts[12], layouts[2], --       4, 5, 6
               layouts[2], layouts[2], layouts[2]   --       7, 8, 9
            }
}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ [ Menu ]
    -- create a laucher widget and a main menu
    myawesomemenu = {
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
        { "restart awesome", awesome.restart },
        { "quit awesome", awesome.quit }
    }

    mymainmenu = awful.menu({
        items = {
            { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "Debian", debian.menu.Debian_menu.Debian },
            { "open terminal", terminal }
        }
    })

    mylauncher = awful.widget.launcher({
        image = image(beautiful.awesome_icon),
        menu = mymainmenu
    })
-- }}}

-- {{{ [ widgets ]

-- textclock widget
    -- mytextclock = awful.widget.textclock({ align = "right" })
    -- mytextclock = awful.widget.textclock({ align = "right" }, " %a %b %d, %H:%M ", 1)

-- Calendar2 {{{
    dateicon = widget({ type = "imagebox" })
    dateicon.image = image(beautiful.widget_date)
    datetext = widget({ type = "textbox" })
    datetext.text = "" .. cwhite .. " Date " .. coldef .. ""

    datewidget = awful.widget.textclock({ align = "right" }, " %a %b %d [%H:%M:%S] ", 1)
    -- calendar2.addCalendarToWidget(datewidget)
    calendar2.addCalendarToWidget(
        datewidget,
        "<span color='#FF8700' font='Ubuntu bold 14'> %s </span>"
    )
-- }}}

-- sentence {{{
    mytextword = widget({ type = "textbox" })
    -- mytextword.text = "" .. ccyan .. "九州 - 海上牧云记 » " .. coldef .. cred .. " 牧云笙 " .. coldef .. ""

    statements_file = io.open(configdir .. "/statements.txt", "r")
    mytimer = timer({ timeout = 5 })
    mytimer:add_signal("timeout", function()
        text_line = statements_file:read("*line")
        if text_line then
            mytextword.text =  "" .. cred .. "九州 - 海上牧云记 » " .. coldef .. ccyan .. text_line .. coldef .. ""
        else
            statements_file:seek("set")
            -- "set": begin of file, "cur": current line, "end": end of file.
        end
        if mpdwidget.visible == true then
            mytextword.visible = false
            musictext.visible = true
        elseif mpdwidget.visible == false then
            mytextword.visible = true
            musictext.visible = false
        end
    end)
    mytimer:start()
-- }}}

-- CPU {{{
    cpuicon = widget({ type = "imagebox" })
    cpuicon.image = image(beautiful.widget_cpu)
    cputext = widget({ type = "textbox" })
    cputext.text = "" .. cdgreen .. " cpu " .. coldef .. ""
    -- Initialize widgets
    cpugraph  = awful.widget.graph()
    -- Graph properties
    cpugraph:set_width(50):set_height(18)
    cpugraph:set_background_color(beautiful.fg_off_widget)
    cpugraph:set_gradient_angle(0):set_gradient_colors({
        beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
    })
    -- Register widgets
    vicious.register(cpugraph, vicious.widgets.cpu, "$1")
    tzswidget = widget({ type = "textbox" })
    vicious.register(tzswidget, vicious.widgets.thermal, "$1C", 19, "thermal_zone0")

    cputwidget = widget({ type = "textbox" })
        vicious.register(cputwidget, vicious.widgets.cpu,
        function (widget, args)
            if  args[1] >= 70 and args[1] <=85 then
                return "" .. cred .. args[1] .. "%" .. coldef .. ""
            elseif args[1] >= 85 then
                return "" .. cdred .. args[1] .. "%" .. coldef .. ""
            else
                return "" .. cgreen .. args[1] .. "%" .. coldef .. ""
            end
        end)

    cputwidget:buttons(
        awful.util.table.join(
            awful.button({}, 1,
                function ()
                    awful.util.spawn(terminal .. " -e htop --sort-key PERCENT_CPU")
                end
            )
        )
    )
-- }}}

-- CPU temperature {{{
    tempicon = widget({ type = "imagebox" })
    tempicon.image = image(beautiful.widget_temp)
    temptext = widget({ type = "textbox" })
    temptext.text = "" .. cdyellow .. " temp " .. coldef .. ""
    tempwidget = widget({ type = "textbox" })

    vicious.register(tempwidget, vicious.widgets.thermal,
    function (widget, args)
        if  args[1] >= 65 and args[1] < 70 then
            return "" .. cyellow .. args[1] .. "°C" .. coldef .. ""
        elseif args[1] >= 70 and args[1] < 75 then
            return "" .. cred .. args[1] .. "°C" .. coldef .. ""
        elseif args[1] > 80 then
            naughty.notify({
                title = "Temperature Warning",
                text = "Running hot! " .. args[1] .. "°C!\nTake it easy.",
                timeout = 10, position = "top_right",
                fg = beautiful.fg_urgent, bg = beautiful.bg_urgent
            })
            return "" .. cred .. args[1] .. "°C" .. coldef .. ""
        else
            return "" .. cdyellow .. args[1] .. "°C" .. coldef .. ""
        end
    end,
    19, "thermal_zone0")
-- }}}

-- RAM {{{
    memicon = widget({ type = "imagebox" })
    memicon.image = image(beautiful.widget_mem)
    memtext = widget({ type = "textbox" })
    memtext.text = "" .. cdblue .. " mem " .. coldef .. ""
    memwidget = widget({ type = "textbox" })

    vicious.cache(vicious.widgets.mem)
    vicious.register(
        memwidget, vicious.widgets.mem,
        "" .. cblue .. "$1% ($6M)" .. coldef .. "",
        13)

    -- RAM bar
    membar = awful.widget.progressbar()
    -- Pogressbar properties
    membar:set_vertical(true):set_ticks(true)
    membar:set_height(18):set_width(8):set_ticks_size(2)
    membar:set_background_color(beautiful.fg_off_widget)
    membar:set_gradient_colors({ beautiful.fg_widget,
       beautiful.fg_center_widget, beautiful.fg_end_widget
    })

    vicious.register(membar, vicious.widgets.mem, "$1", 13)
-- }}}

--[[
-- swap {{{
    swapwidget = widget({ type = "textbox" })
    vicious.cache(vicious.widgets.mem)
    vicious.register(
        swapwidget, vicious.widgets.mem,
        "" .. clblack .. "swap " .. coldef .. clblack .. "$5% ($6 M)" .. coldef .. "",
        13)
-- }}}
--]]

-- uptime {{{
    uptimeicon = widget({ type = "imagebox" })
    uptimeicon.image = image(beautiful.widget_uptime)
    uptimetext = widget({ type = "textbox" })
    uptimetext.text = "" .. cwhite .. " uptime " .. coldef .. ""
    uptimewidget = widget({ type = "textbox" })

    vicious.register(
        uptimewidget, vicious.widgets.uptime,
        "" .. cdcyan .. " $2h:$3m" .. coldef .. ""
        )
-- }}}

-- load average {{{
    loadavgicon = widget({ type = "imagebox" })
    loadavgicon.image = image({beautiful.widget_loadavg})
    loadavgtext = widget({ type = "textbox" })
    loadavgtext.text = "" .. cdcyan .. " avg " .. coldef .. ""
    loadavgwidget = widget({ type = "textbox" })

    -- $4 for 1 minutes, $5 for 5 minutes, $6 for 15 minutes.
    vicious.register(
        loadavgwidget, vicious.widgets.uptime,
        "" .. ccyan .. " $4 $5 $6" .. coldef .. ""
        )
-- }}}

-- OS {{{
    ostext = widget({ type = "textbox" })
    ostext.text = "" .. cdcyan .. " os " .. coldef .. ""
    osinfowidget = widget({ type = "textbox"})

    vicious.register(
        osinfowidget, vicious.widgets.os,
        "" .. cwhite .. " $4" .. coldef .. ""
        )
-- }}}

-- disk I/O {{{
    diotext = widget({ type = "textbox" })
    diotext.text = "" .. cdcyan .. " I/O " .. coldef .. ""
    diowidget = widget({ type = "textbox"})

    vicious.cache(vicious.widgets.dio)
    vicious.register(
        diowidget, vicious.widgets.dio,
        "" .. ccyan .. " ${sda total_kb}k" .. coldef .. ""
        )
-- }}}

-- filesystem {{{
    fsicon = widget({ type = "imagebox" })
    fsicon.image = image(beautiful.widget_fs)
    fstext = widget({ type = "textbox" })
    fstext.text = "" .. cdbrown .. " fs " .. coldef .. ""

    -- simple version
    fswidget = widget({ type = "textbox"})
        vicious.cache(vicious.widgets.fs)
        vicious.register(
            fswidget, vicious.widgets.fs,
            "" .. cmagenta .. " ${/home avail_p}%" .. coldef .. ""
        )

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
    })
    -- Register buttons
    w.widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () exec("rox", false) end)
    ))
    end

    -- Enable caching
    vicious.cache(vicious.widgets.fs)

    -- Register widgets
    -- FIXME add percent number for / root and /home tec.
    vicious.register(fs.b, vicious.widgets.fs, "${/boot used_p}", 599)
    vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",     599)
    vicious.register(fs.h, vicious.widgets.fs, "${/home used_p}", 599)
    vicious.register(fs.s, vicious.widgets.fs, "${/media/tux used_p}", 599)
-- }}}

-- weather {{{
    weathericon = widget({ type = "imagebox" })
    weathericon.image = image(beautiful.widget_weather)
    weathertext = widget({ type = "textbox" })
    weathertext.text = "" .. cwhite .. " weather " .. coldef .. ""

    weatherwidget = widget({ type = "textbox" })

    weather_t = awful.tooltip({ objects = { weatherwidget },})

    vicious.register(
        weatherwidget, vicious.widgets.weather,
        function (widget, args)
            weather_t:set_text(
                "City: " .. args["{city}"] ..
                "\nWeather: " .. args["{weather}"] ..
                "\nTempc" .. args["{tempc}"] .. "°C" ..
                "\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] ..
                "\nSky: " .. args["{sky}"] ..
                "\nHumidity: " .. args["{humid}"]
            )
            return " Weather: " .. args["{weather}"] .. " | " .. args["{tempc}"] .. "°C"
        end,
        3600, "ZSHC"
    )
    --'3600': check per 1 hour.
    --'ZSHC': the Montreal ICAO code. (HangZhou China)
-- }}}

-- separator {{{
    foursquare = widget({ type = "textbox" })
    foursquare.text  = "<span color='#87AF00'> ⌘ </span>"
    separator_sign = widget({ type = "textbox" })
    separator_sign.text = "<span color='#151515'> | </span>"
    separator_image = widget({ type = "imagebox" })
    separator_image.image = image(beautiful.widget_sep)
-- }}}

-- network {{{
    -- icon {{{
    dnicon = widget({ type = "imagebox" })
    dnicon.image = image(beautiful.widget_net)

    upicon = widget({ type = "imagebox" })
    upicon.image = image(beautiful.widget_netup)

    dntext = widget({ type = "textbox" })
    dntext.text = "" .. cblue .. " dn " .. coldef .. ""

    uptext = widget({ type = "textbox" })
    uptext.text = "" .. cred .. " up " .. coldef .. ""

    wifiicon = widget({ type = "imagebox" })
    wifiicon.image = image(beautiful.widget_wifi)

    wifitext = widget({ type = "textbox" })
    wifitext.text = "" .. ccyan .. " wifi " .. coldef .. ""
    -- }}}

    -- eth {{{
    neteupwidget = widget({ type = "textbox" })

    vicious.cache(vicious.widgets.net)
    vicious.register(
        neteupwidget, vicious.widgets.net,
        "" .. cred .. "${eth0 up_kb}k " .. coldef .. ""
        )

    netedownwidget = widget({ type = "textbox" })
    vicious.register(
        netedownwidget, vicious.widgets.net,
        "" .. cblue .. "${eth0 down_kb}k" .. coldef .. ""
        )
    -- }}}

    -- wlan {{{
    netwupwidget = widget({ type = "textbox" })

    vicious.register(
        netwupwidget, vicious.widgets.net,
        "" .. cred .. "${wlan0 up_kb}k " .. coldef .. ""
        )

    netwdownwidget = widget({ type = "textbox" })
    vicious.register(
        netwdownwidget, vicious.widgets.net,
        "" .. cdblue .. "${wlan0 down_kb}k " .. coldef .. ""
        )
    -- }}}

    -- wifi {{{
    wifiwidget = widget({ type = "textbox" })
    vicious.register(
        wifiwidget, vicious.widgets.wifi,
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
                return "" .. cgrey .. "" .. coldef .. ccyan ..
                string.format(
                    " %s %i%%",
                    args["{ssid}"],
                    args["{rate}"],
                    args["{link}"]/70*100
                    )
                .. coldef .. ""
            end
        end,
        refresh_delay, "wlan0"
    )
    -- }}}
-- }}}

-- Mail {{{
    -- Mutt {{{
    local mdir = os.getenv("HOME") .. "/Mails/"

    mailicon = widget({ type = "imagebox" })
    mailicon.image = image(beautiful.widget_mail)
    mailtext = widget({ type = "textbox" })
    mailtext.text = "" .. cdred .. " Mail " .. coldef .. ""

    -- Initialize widget
    maildirwidget = widget({ type = "textbox" })

    -- Register widget
    -- update every N seconds. {["maildir1"="name1", ["maildir2"]="name2"]}
    vicious.register(
        maildirwidget, vicious.widgets.maildir,
        { ["INBOX"]="Inbox", ["unsure"]="unsure" }, 3600, mdir
        )

    -- register button
    maildirwidget:buttons(awful.util.table.join(
       awful.button({ }, 1, function () exec(terminal .. "-e mutt") end),
       awful.button({ }, 4, function () exec(terminal .. "-e mutt") end),
       awful.button({ }, 5, function () exec(terminal .. "-e mutt") end)
    ))
    maildirwidget:buttons(maildirwidget:buttons())
    -- }}}
-- }}}

-- Battery {{{
    baticon = widget({ type = "imagebox" })
    baticon.image = image(beautiful.widget_bat)
    battext = widget({ type = "textbox" })
    battext.text = "" .. cdbrown .. " Bat " .. coldef .. ""
    batwidget = widget({ type = "textbox" })

	vicious.register(
        batwidget, vicious.widgets.bat,
        function (widget, args)
            if args[2] >= 30 and args[2] < 75 then
                return "" .. cyellow .. args[2] .. "%" .. coldef .. ""
            elseif args[2] >= 20 and args[2] < 30 then
                return "" .. cdred .. args[2] .. "%" .. coldef .. ""
            elseif args[2] < 20 and args[1] == "-" then
                naughty.notify({
                    title = "Battery Warning",
                    text = "Battery low! " .. args[2] ..
                    "% left!\nBetter get some power.",
                    timeout = 10, position = "top_right",
                    fg = beautiful.fg_urgent, bg = beautiful.bg_urgent
                })
                return blinking(batwidget, 1)
            elseif args[2] < 20 and args[2] > 0 then
                return "" .. cred .. args[2] .. "%" .. coldef .. ""
            else
                return "" .. cdbrown .. " A/C" .. coldef .. ""
            end
        end, 23, "BAT0"
    )
-- }}}

-- Volume {{{
    --[[ simple version
    volwidget = widget({ type = "textbox" })

    vicious.register(
        volwidget, vicious.widgets.volume,
        function (widget, args)
            if args[1] == 0 or args[2] == "♩" then
                return "" .. cgrey .. "♪ " .. coldef ..
                cred .. "mute" .. coldef .. ""
            else
                return "" .. ccyan .. "♪ " .. coldef ..
                ccyan .. args[1] .. "%" .. coldef .. ""
            end
        end, 2, "Master"
    )
    --]]

    -- Volume level
    volicon = widget({ type = "imagebox" })
    volicon.image = image(beautiful.widget_vol)
    voltext = widget({ type = "textbox" })
    voltext.text = "" .. cgrey .. " Vol " .. coldef .. ""

    -- Initialize widgets
    volbar    = awful.widget.progressbar()
    volwidget = widget({ type = "textbox" })

    -- Progressbar properties
    volbar:set_vertical(true):set_ticks(true)
    volbar:set_height(18):set_width(8):set_ticks_size(2)
    volbar:set_background_color(beautiful.fg_off_widget)
    volbar:set_gradient_colors({ beautiful.fg_widget,
       beautiful.fg_center_widget, beautiful.fg_end_widget
    })

    -- Enable caching
    vicious.cache(vicious.widgets.volume)

    -- Register widgets
    -- "PCM", "Master"
    vicious.register(volbar,    vicious.widgets.volume,  "$1",  2, "Master")
    vicious.register(volwidget, vicious.widgets.volume, " $1%", 2, "Master")

    -- Register buttons
    volbar.widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () exec(terminal .. "-e alsamixer") end),
        awful.button({ }, 2, function () exec("amixer -q set Master mute") end),
        awful.button({ }, 3, function () exec("amixer -q set Master unmute") end),
        awful.button({ }, 4, function () exec("amixer -q set Master 2dB+", false) end),
        awful.button({ }, 5, function () exec("amixer -q set Master 2dB-", false) end)
    ))

    -- Register assigned buttons
    volwidget:buttons(volbar.widget:buttons())
-- }}}

-- MPD {{{
    musicicon = widget({ type = "imagebox" })
    musicicon.image = image(beautiful.widget_music)
    musictext = widget({ type = "textbox" })
    musictext.text = "" .. cdgreen .. " mpd " .. coldef .. ""
    mpdwidget = widget({ type = 'textbox' })

    -- add tooltip for mpdwidget
    vicious.register(
        mpdwidget, vicious.widgets.mpd,
        function (widget, args)
            if args["{state}"] == "Stop" then
                mpdwidget.visible = false
                return "" .. cblack .. "Stop" .. coldef .. ""
            elseif args["{state}"] == "Play" then
                mpdwidget.visible = true
                return "" .. cblue .. args["{Title}"] .. " - " ..
                args["{Artist}"] .. coldef .. ""
            elseif args["{state}"] == "Pause" then
                mpdwidget.visible = false
                return "" .. cdgrey .. "Pause" .. coldef .. ""
            end
        end)

    mpdwidget:buttons(
        awful.util.table.join(
            awful.button({}, 1, function () exec("mpc toggle", false) end),
                -- here false can avoid cursor switch busy mode
            awful.button({}, 3, function () exec(terminal .. " -e ncmpcpp") end),
            awful.button({}, 4, function () exec("mpc prev", false) end),
            awful.button({}, 5, function () exec("mpc next", false) end)
        )
    )
-- }}}

-- Bashets MPD cover art {{{
    local coverart_nf
    function coverart_show()
        -- destroy old popup, needed when bound to a key
        coverart_hide()
        local img = awful.util.pread(scripts_dir .. "/coverart.sh")
        local ico = image(img)
        local txt = awful.util.pread(scripts_dir .. "/musicinfo.sh")
        -- set desired position of popup during creation
        coverart_nf = naughty.notify({
            icon = ico, icon_size = 100, text = txt, position = "bottom_left"
        })
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

    bashets.register(
        scripts_dir .. "/mpd.sh",
        {
            widget = mpdw, format = '$1 | $2',
            update_time = 1, separator = '|',
            callback = mpd_callback
        }
    )
-- }}}

-- systray {{{
mysystray = widget({ type = "systray" })
-- }}}

-- }}}

-- [ wibox ] {{{
    -- Create a wibox for each screen and add it
    mywibox = {}

    mypromptbox = {}

    mylayoutbox = {}

    -- taglist {{{
    mytaglist = {}
    mytaglist.buttons = awful.util.table.join(
        awful.button({ }, 1, awful.tag.viewonly),
        awful.button({ modkey }, 1, awful.client.movetotag),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, awful.client.toggletag),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    )
    -- }}}

    -- tasklist {{{
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
        end)
    )
    -- }}}

    for s = 1, screen.count() do
        -- create a promptbox for each screen
        mypromptbox[s] = awful.widget.prompt({
            layout = awful.widget.layout.horizontal.leftright
        })
        -- create an imagebox widget which will contains an icon indicating
        -- which layout we're using.
        -- We need one layoutbox per screen.
        mylayoutbox[s] = awful.widget.layoutbox(s)
        mylayoutbox[s]:buttons(
            awful.util.table.join(
                awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
            )
        )

        -- taglist widget {{{
        -- create tasklist widget
        mytaglist[s] = awful.widget.taglist(
            s, awful.widget.taglist.label.all, mytaglist.buttons
        )

        -- create a tasklist widget
        mytasklist[s] = awful.widget.tasklist(
            function(c)
                -- original
                -- return awful.widget.tasklist.label.currenttags(c, s)
                -- remove tasklist icon without modifying tasklist.lua
                local tmptasklist = { awful.widget.tasklist.label.currenttags(c, s) }
                return tmptasklist[1], tmptasklist[2], tmptasklist[3], nil
            end, mytasklist.buttons
        )
        -- }}}

        -- top wibox {{{
        mywibox[s] = awful.wibox({ position = "top", height = "20", screen = s })

        -- add widgets to the wibox - order matters
        mywibox[s].widgets = {
            {
                foursquare,
                mylauncher,
                mytaglist[s], separator_sign,
                mypromptbox[s], separator_sign,
                layout = awful.widget.layout.horizontal.leftright
            },
            foursquare,
            mylayoutbox[s], separator_sign,  -- layout style pic
            s == 1 and mysystray or nil, separator_sign, -- systray
                -- remove systray here
                -- s == 1 and nil, separator_sign, -- systray
            -- mytextbox,
            mytasklist[s], -- tasklist
            layout = awful.widget.layout.horizontal.rightleft
        }
        -- }}}

        -- bottom wibox {{{
        mywibox[s] = awful.wibox({ position = "bottom", height = "20", screen = s })

        -- add widgets to the wibox - order matters
        mywibox[s].widgets = {
            {
                foursquare,
                mytextword,
                musictext, mpdwidget,
                -- osinfowidget,
                -- mailbox, separator_sign,
                layout = awful.widget.layout.horizontal.leftright
            },
            foursquare,
            datewidget, datetext, separator_sign,
            -- weatherwidget, weathertext, separator_sign,
            volwidget, voltext,
            separator_sign,
            -- fs.b.widget, fs.r.widget, fs.h.widget, fs.s.widget, fstext,
            fswidget, fstext, separator_sign,
            tempwidget, temptext, separator_sign,
            uptimewidget, uptimetext, separator_sign,
            batwidget, battext, separator_sign,
            netedownwidget, dntext, neteupwidget, uptext, separator_sign,
            -- wifiwidget, wifitext,
            netwdownwidget, netwupwidget,
            memwidget, memtext, separator_sign,
            -- diowidget, separator_sign,
            loadavgwidget, loadavgtext, separator_sign,
            cputwidget, cputext, separator_sign,
            -- cpugraph.widget,
            maildirwidget, separator_sign,
            layout = awful.widget.layout.horizontal.rightleft
        }
        -- }}}
    end
-- }}}

-- [ mouse bindings ] {{{
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- [ key binds ] {{{
    globalkeys = awful.util.table.join(
        -- for "run or raise"
        -- globalkeys, aweror.genkeys(modkey),
        aweror.genkeys(modkey),

        -- toggle client floating [ Mod4-Shift-f ]
        awful.key({ modkey, "Shift" }, "f",  awful.client.floating.toggle ),

        -- toggle titlebar visiblity [ Mod4-Shift-T ]
        awful.key({ modkey, "Shift" }, "t",
            function (c)
                if c.titlebar then awful.titlebar.remove(c)
                else awful.titlebar.add(c, { modkey = modkey }) end
            end
        ),

        -- minitray.lua [ Mod4-CTRL-L ] {{{
        awful.key({ modkey, "Control" }, "t",   function()  minitray.toggle() end ),
        -- }}}

        -- Screensaver lock  [ Mod4-CTRL-l ] {{{
        awful.key({ modkey, "Control" }, "l",
            function ()
                awful.util.spawn("xscreensaver-command -lock")
            end
        ),

        -- xlock
        -- awful.key({ modkey }, "F7", function () awful.util.spawn("xlock") end)
        -- awful.key({ modkey, "Control" }, "l", function () awful.util.spawn("xlock") end)
        -- }}}

        -- client lists that minimized windows cycle/restore, [ Mod4-; ] {{{
        awful.key( { modkey }, ";", function()
            awful.menu.clients({ width = 250 }, { keygrabber = true } )
        end ),
        -- }}}

        -- unminimize all windows on current tag. [ Mod4-Shift-N ] {{{
        awful.key({ modkey, "Shift" }, "n",
        function()
            local tag = awful.tag.selected()
            for i=1, #tag:clients() do
                tag:clients()[i].minimized=false
                tag:clients()[i]:redraw()
            end
        end),
        -- }}}

        -- Screenshot [Prt Src] {{{
        -- grab key through $ xev . then press keyboard. display name "Print"
        awful.key({ }, "Print", function ()
            awful.util.spawn("scrot -e 'mv $f ~ 2>/dev/null'")
            os.execute("sleep 0.5")
            naughty.notify({ title="Screenshot", text="The focused window captured" })
        end),
        -- }}}

        -- volume [ Mod4-(PageUp/PageDown) ] {{{
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
        -- }}}

        -- ncmpcpp & MPD {{{
        -- toggle ncmpcpp play [ Mod4-p ]
        awful.key({ modkey,           }, "p",
        function ()
            awful.util.spawn_with_shell( "ncmpcpp toggle" )
        end),
        -- [ Mod4-(,/.) ] play previouse/next ncmpcpp song.
        awful.key({ modkey }, "period",  function ()
            awful.util.spawn("mpc next", false)
        end),
        awful.key({ modkey }, "comma",  function ()
            awful.util.spawn("mpc prev", false)
        end),
        -- }}}

        -- sdcv/stardict [ Mod4-(d/Shift-d) ] {{{
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
                -- sdcv options:
                    -- remove "-n" option to disable display relative words.
                    -- --data-dir '~/.stardict/dir' to search through all dicts.
                    -- -u '朗道汉英字典5.0', '牛津英汉双解美化版'
            -- XXX if selected word is not english word, use chinese-english dictionary instead.
            -- if new_word:match("[^a-zA-Z]") then
            if new_word:find("%a") then
                f  = io.popen(
                    "sdcv -n --utf8-output -u 'WordNet' -u '朗道英汉字典5.0' "
                    ..  new_word
                )

                for line in f:lines() do
                    fc = fc .. line .. '\n'
                end
                f:close()

                frame = naughty.notify({
                    title = '<span color="blue" font="DejaVu Sans Mono bold 12">'
                    .. new_word .. '</span>',
                    text = '<span font="DejaVu Sans Mono bold 9">'
                    .. fc .. '</span>',
                    timeout = 30, position = "top_left", width = 700,
                    fg = "black", bg = "white"
                })

                awful.util.spawn_with_shell(
                    "sleep 0.6 ; echo \""..new_word.."\" | espeak -v en "
                )
            else
                f  = io.popen(
                    "sdcv -n --utf8-output -u '朗道汉英字典5.0' "
                    .. new_word
                )

                for line in f:lines() do
                    fc = fc .. line .. '\n'
                end
                f:close()

                frame = naughty.notify({
                    title = '<span color="blue" font="DejaVu Sans Mono bold 12">'
                    .. new_word .. '</span>',
                    text = '<span font="DejaVu Sans Mono bold 9">'
                    .. fc .. '</span>',
                    timeout = 30, position = "top_left", width = 700,
                    fg = "black", bg = "white"
                })

                awful.util.spawn_with_shell(
                    "sleep 0.6 ; echo \""..new_word.."\" | espeak -v zh "
                )
            end

        end),

        awful.key({ modkey, "Shift" }, "d", function ()
            awful.prompt.run(
                {prompt = "Dict: "},
                mypromptbox[mouse.screen].widget,
                function(cinword)
                    naughty.destroy(frame)
                    if cinword == "" then
                        return
                    end

                    local fc = ""
                    if cinword:find("%a") then
                        f  = io.popen(
                            "sdcv -n --utf8-output -u 'WordNet' -u '朗道英汉字典5.0' "
                            .. cinword
                        )

                        for line in f:lines() do
                            fc = fc .. line .. '\n'
                        end
                        f:close()

                        frame = naughty.notify({
                            title = '<span color="blue" font="WenQuanYi Micro Hei Mono bold 12">'
                            .. cinword .. '</span>',
                            text = '<span font="DejaVu Sans Mono bold 9">'
                            .. fc .. '</span>',
                            timeout = 30, position = "top_left", width = 700,
                            fg = "black", bg = "white"
                        })

                        awful.util.spawn_with_shell(
                            "sleep 0.6 ; echo \""..cinword.."\" | espeak -v en "
                        )
                    else
                        f  = io.popen(
                            "sdcv -n --utf8-output -u '朗道汉英字典5.0' "
                            .. cinword
                        )

                        for line in f:lines() do
                            fc = fc .. line .. '\n'
                        end
                        f:close()

                        frame = naughty.notify({
                            title = '<span color="blue" font="WenQuanYi Micro Hei Mono bold 12">'
                            .. cinword .. '</span>',
                            text = '<span font="DejaVu Sans Mono bold 9">'
                            .. fc .. '</span>',
                            timeout = 30, position = "top_left", width = 700,
                            fg = "black", bg = "white"
                        })

                        awful.util.spawn_with_shell(
                            "sleep 0.6 ; echo \""..cinword.."\" | espeak -v zh "
                        )
                    end

                end,
                nil, awful.util.getdir("cache").."/dict"
            )
        end),
        -- }}}

        -- tag manipulation {{{
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
        -- }}}

        -- client manipulation [ Mod4-(j/k/u/Tab) ] [ Mod4-(Shift/Control)-(j/k) ] {{{
        awful.key({ modkey,           }, "j",
            function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
            end
        ),
        awful.key({ modkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
            end
        ),
        awful.key({ modkey,           }, "u",
            awful.client.urgent.jumpto
        ),
        awful.key({ modkey,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end
        ),

        awful.key({ modkey, "Shift"   }, "j",
            function () awful.client.swap.byidx(  1)
            end
        ),
        awful.key({ modkey, "Shift"   }, "k",
            function () awful.client.swap.byidx( -1)
            end
        ),
        awful.key({ modkey, "Control" }, "j",
            function () awful.screen.focus_relative( 1)
            end
        ),
        awful.key({ modkey, "Control" }, "k",
            function () awful.screen.focus_relative(-1)
            end
        ),
        -- }}}

        -- Awesome (window/layout) manipulation {{{
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
        -- }}}

        -- prompt {{{

        -- default prompt
        -- awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),

        -- dmenu prompt
        awful.key({ modkey }, "r",
            function ()
                awful.util.spawn("dmenu_run -i -p 'Run command:' \
                -nb '" .. beautiful.bg_normal .. "' \
                -nf '" .. beautiful.fg_normal .. "' \
                -sb '" .. beautiful.bg_focus .. "' \
                -sf '" .. beautiful.fg_focus .. "' \
                -fn '" .. beautiful.font .. "' \
                ")
            end
        ),

        awful.key({ modkey }, "x",
            function ()
                awful.prompt.run({ prompt = "Run Lua code: " },
                mypromptbox[mouse.screen].widget,
                awful.util.eval, nil,
                awful.util.getdir("cache") .. "/history_eval")
            end
        )
        -- }}}
    )

    -- client {{{
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
    -- }}}

    -- Compute the maximum number of digit we need, limited to 9
    keynumber = 0
    for s = 1, screen.count() do
        keynumber = math.min(9, math.max(#tags[s], keynumber));
    end

    -- Bind all key numbers to tags {{{
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
    -- }}}

    -- Set keys
    root.keys(globalkeys)

-- }}}

-- [ rules ] {{{
    -- $ xprop | grep WM_CLASS  ( put the cursor on App )

    -- All clients will match this rule.
    --      WM_CLASS(STRING) = "smplayer", "Smplayer"
    --                      |           |
    --                      |           |--- class
    --                      |
    --                      |--- instance

    --  WM_NAME(STRING) = "SMPlayer"
    --                     |
    --                     |--- name

    -- rules: class, name, instance,

    -- [ rule ] {{{
        -- class = ""
        -- instance = ""
        -- role = ""
    -- }}}
    -- [ properties ] {{{
        -- maximized_horizontal = false, maximized_vertical = false,
        -- tag = tagobject, tag = tags[1][4],
        -- switchtotag = true,
        -- floating = true,
        -- ontop = true,
        -- x = 200, y = 400,
        -- width = 100, height = 500,
        -- sticky = true -- for Conky, gkrellm, etc to be available on every tag.
        -- border_width = 0,
        -- skip_taskbar = true
    -- }}}

    -- [ Examples ]
    -- Set Akregator to tag 8 of the last screen and add a titlebar trough callback
    --  { rule = { class = "Akregator" },properties = {tag = tags[screen.count()][8]}, callback = awful.titlebar.add},
    -- Set Xterm to multiple tags on screen 1
    -- { rule = { class = "XTerm" }, callback = function(c) c:tags({tags[1][5], tags[1][6]}) end},
    -- Set ROX-Filer to tag 2 of the currently selected and active screen
    -- { rule = { class = "ROX-Filer" }, callback = function(c) awful.client.movetotag(tags[mouse.screen][2], c) end},
    -- Set Xterm as floating with a fixed position
    -- { rule = { class = "XTerm" }, properties = {floating = true}, callback = function(c) c:geometry({x=0, y=0}) end},

    -- FIXME let tmux and screen window available on many tags.
    -- { rule = { class = "XTerm" }, callback = function(c) c:tags({tags[1][5], tags[1][6]}) end},

    awful.rules.rules = {
        {
            rule = { },
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = true,
                keys = clientkeys,
                size_hints_honor = false, -- remove gaps between windows
                buttons = clientbuttons
            }
        },

        {
            rule = { class = "MPlayer" },
            properties = {
                floating = true,
                ontop = true
            }
        },

        {
            rule = { class = "Darktable", instance = "darktable" },
            properties = {
                maximized_horizontal = true,
                maximized_vertical = true,
                floating = false,
                tag = tags[1][4],
            }
        },

        {
            rule = { class = "Inkscape", instance = "inkscape" },
            properties = {
                maximized_horizontal = true,
                maximized_vertical = true,
                floating = false,
                tag = tags[1][4],
            }
        },

        {
            rule = { class = "Screenkey", instance = "screenkey" },
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

        -- key-mon, for 1920x1080 screen size
        {
            rule = { class = "Key-mon", instance = "key-mon" },
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

        -- libreoffice
        {
            rule = { class = "VCLSalFrame", instance = "libreoffice-writer" },
            properties = {
                maximized_horizontal = true,
                maximized_vertical = true,
                floating = false,
                tag = tags[1][2],
                switchtotag = true
            }
        },

        -- Firefox
        {
            rule = { class = "Firefox", instance = "Navigator" },
            properties = {
                maximized_horizontal = true,
                maximized_vertical = true,
                floating = false,
                tag = tags[1][7],
            }
        },
        -- Chromium
        {
            rule = { class = "Chromium-browser", instance = "chromium-browser" },
            properties = {
                maximized_horizontal = true,
                maximized_vertical = true,
                floating = false,
                tag = tags[1][7],
            }
        },
        -- Opera
        {
            rule = { class = "Opera", instance = "opera" },
            properties = {
                maximized_horizontal = true,
                maximized_vertical = true,
                floating = false,
                tag = tags[1][7],
                switchtotag = true
            }
        },

    }

-- }}}

-- [ signals ] {{{
    -- Signal function to execute when a new client appears.
    client.add_signal("manage", function (c, startup)
        -- add a titlebar
        -- awful.titlebar.add(c, { modkey = modkey })

        -- enable sloppy focus
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

            -- put windows in smart way, only if they does not set an initial position
            if not c.size_hints.user_position and not c.size_hints.program_position then
                awful.placement.no_overlap(c)
                awful.placement.no_offscreen(c)
            end
        end
    end)

    client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- vim: foldmethod=marker shiftwidth=4
