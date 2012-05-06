---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) Maildir Biff Widget, Fredrik Ax
---------------------------------------------------

-- {{{ Grab environment
local os = { getenv = os.getenv }
local io = { popen = io.popen, stderr = io.stderr }
local maildir = os.getenv("HOME") .. "/Maildir/"
local pairs = pairs
local string = string
local tonumber = tonumber
local setmetatable = setmetatable

module("vicious.widgets.maildir")

local function get_num_files(directory)
   local f = io.popen('/bin/ls -U1 '.. directory .. ' |wc -l', 'r')
   local result = f:read()
   f:close()
   return tonumber( result )
end


local function worker( maildirs, warg )
   if warg then
      maildir = warg
   end
   io.stderr:write("Maildir is: " .. maildir .. "\r\n" )
      
   local text = ""
   for dir,name in pairs(maildirs) do
      io.stderr:write("Checking  " .. dir .. "\r\n" )      
      local num = get_num_files( maildir .. dir .. "/new/" )
      io.stderr:write("Found   " .. num .. " new emails.\r\n" )            
      if num > 0 then
	 text = text .. "," .. name .. ":" .. string.format("%i",num)
      end
   end

   io.stderr:write("Seeting text to   " .. text .. "\r\n" )   
   if string.len(text) > 0 then -- remove leading comma
      return string.sub(text,2,-1)
   end
   return "M=0"
end
setmetatable(_M, { __call = function(_, ...) return worker(...) end })
