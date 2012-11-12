# Arbi_ram sublet file
# Created with sur-0.2.165
require 'arbi'

configure :arbi_ram do |s|
  s.interval = 4
  s.icon = Subtlext::Icon.new('ram.xbm')
end

on :run do |s|
    begin
        s.data = s.icon + " " + Arbi.get("ram")["used"]
    rescue e
        s.data = s.icon + " Error"
        p e
    end
end
