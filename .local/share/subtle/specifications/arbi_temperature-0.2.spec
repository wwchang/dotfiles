# -*- encoding: utf-8 -*-
# Arbi_temperature specification file
Sur::Specification.new do |s|
  s.name        = "Arbi_temperature"
  s.version     = "0.2"
  s.tags        = [ 'temperature' ]
  s.files       = [ "arbi_temperature.rb" ]
  s.icons       = [ 'icons/therm.xbm' ]

  s.description = "Show global temperature"
  s.notes       = s.description.dup

  s.authors     = [ "shura" ]
  s.contact     = "shura1991@gmail.com"
  s.date        = "Tue Mar 15 10:33 CET 2011"

  s.add_dependency("arbi", ">= 1.0.8.3")
end
