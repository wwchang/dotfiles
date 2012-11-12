# -*- encoding: utf-8 -*-
# Uptime specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Uptime"
  s.version     = "0.1"
  s.tags        = [ "Proc" ]
  s.files       = [ "uptime.rb" ]
  s.icons       = [ "icons/off.xbm" ]

  # Sublet description
  s.description = "Show the system uptime"
  s.notes       = <<NOTES
This sublet displays the uptime of the system based on the values
from /proc/uptime.
NOTES

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Wed Apr 13 19:20 CEST 2011"
end
