# -*- encoding: utf-8 -*-
# cpuchart specification file
# Created with sur-0.2.155
Sur::Specification.new do |s|
  s.name        = "cpuchart"
  s.authors     = [ "Dominik Honnef" ]
  s.date        = "Tue Nov 22 11:26 CEST 2010"
  s.contact     = "dominikh@fork-bomb.org"
  s.description = "Shows cpu usage using a chart"
  s.version     = "0.3"
  s.tags        = [ "cpu", "chart" ]
  s.files       = [ "cpuchart.rb" ]
  s.icons       = [ ]
  s.add_dependency "subtle-graph", ">=0.0.3"
  s.subtlext_version = "0.9.1883"
end
