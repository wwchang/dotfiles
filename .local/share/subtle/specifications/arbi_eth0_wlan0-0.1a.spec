# -*- encoding: utf-8 -*-
# Arbi_eth0_wlan0 specification file
# Created with sur-0.2.165
Sur::Specification.new do |s|
  s.name        = "Arbi_eth0_wlan0"
  s.authors     = [ "shura" ]
  s.date        = "Wed Sep 08 11:24 CEST 2010"
  s.contact     = "shura1991@gmail.com"
  s.description = "show eth0 and wlan0 infos"
  s.version     = "0.1a"
  s.tags        = [ "net", "eth0", "ethernet", "wlan0", "wireless" ]
  s.files       = [ "arbi_eth0_wlan0.rb" ]
  s.icons       = Dir.glob('icons/*.xbm')

  s.add_dependency('arbi', '1.0.5')
end
