# -*- encoding: utf-8 -*-
# Arbi_ram specification file
# Created with sur-0.2.165
Sur::Specification.new do |s|
  s.name        = "Arbi_ram"
  s.authors     = [ "shura" ]
  s.date        = "Wed Sep 08 10:08 CEST 2010"
  s.contact     = "shura1991@gmail.com"
  s.description = "Show used ram"
  s.version     = "0.1b"
  s.tags        = [ "RAM" ]
  s.files       = [ "arbi_ram.rb" ]
  s.icons       = [ "icons/ram.xbm" ]

  s.add_dependency('arbi', '1.0.6')
end
