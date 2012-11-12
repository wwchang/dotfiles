# -*- encoding: utf-8 -*-
# Arbi_net specification file
Sur::Specification.new do |s|
  s.name        = "Arbi_net"
  s.version     = "0.3"
  s.tags        = [ 'net', 'ethernet', 'wireless' ]
  s.files       = [ "arbi_net.rb" ]
  s.icons       = [
    'icons/net_down.xbm',
    'icons/net_up.xbm',
    'icons/wifi.xbm',
    'icons/wired.xbm'
  ]

  s.description = 'Show infos of selected interfaces'
  s.notes       = s.description.dup

  s.authors     = [ "shura" ]
  s.contact     = "shura1991@gmail.com"
  s.date        = "Tue Mar 15 08:45 CET 2011"

  s.config = [
    {
      :name        => "interfaces",
      :type        => "array",
      :description => "An array that contains the interfaces to be monitored",
      :def_value   => []
    }
  ]

  s.add_dependency("arbi", ">= 1.0.8.2")
  s.add_dependency("subtype", "> 0")
end
