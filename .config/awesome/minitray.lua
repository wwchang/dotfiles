local capi = { screen = screen,
               mouse = mouse }
local wibox = require("wibox")

module("minitray")

local instance = {}

local function show()
   local geom = capi.screen[capi.mouse.screen].workarea
   instance.wibox.height = 20
   instance.wibox.width = instance.tray.width or 100
   instance.wibox:geometry({ x = geom.width - geom.x - instance.wibox.width,
                             y = geom.y })
   instance.wibox.visible = true
end

local function init()
   instance.wibox = wibox({})
   instance.wibox.ontop = true
   instance.layout = wibox.layout.align.horizontal()
   instance.tray = wibox.widget.systray()
   instance.layout:set_right(instance.tray)
   instance.wibox:set_widget(instance.layout)
end

local function hide()
   instance.wibox.visible = false
end

function toggle()
   if not instance.wibox then
      init()
   end

   if instance.wibox.visible then
      hide()
   else
      show()
   end
end
