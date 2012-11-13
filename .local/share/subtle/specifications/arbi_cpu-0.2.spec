# -*- encoding: utf-8 -*-
# Arbi_cpu specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  s.name        = "Arbi_cpu"
  s.version     = "0.2"
  s.tags        = [ 'CPU' ]
  s.files       = [ "arbi_cpu.rb" ]
  s.icons       = [ 'icons/cpu.xbm' ]

  s.description = "Show your cpu(s) load"
  s.notes       = s.description.dup

  s.authors     = [ "shura" ]
  s.contact     = "shura1991@gmail.com"
  s.date        = "Mon Mar 14 15:25 CET 2011"

  s.add_dependency("arbi", ">= 1.0.8.2")
end
