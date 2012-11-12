# -*- encoding: utf-8 -*-
# Conky specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Conky"
  s.version     = "0.0"
  s.tags        = [ "data" ]
  s.files       = [ "conky.rb" ]
  s.icons       = [ ]

  # Sublet description
  s.description = "Display data from conky via subtler"
  s.notes       = <<NOTES
This sublet parses the output data from conky and displays it in the subtle
panel. In order for this to work, subtler needs to read the data from the pipe
and send it to subtle. This can be done with following shell command:

conky | subtler -sD conky -

Currently supported substitutions:

foreground (^fg)
image (^i)
NOTES

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Fri Apr 08 23:53 CEST 2011"

  # Sublet requirements
  s.required_version = "0.9.2771"
end
