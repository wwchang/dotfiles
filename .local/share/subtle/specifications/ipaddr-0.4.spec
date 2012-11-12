# -*- encoding: utf-8 -*-
# Ipaddr specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  s.name        = "ipaddr"
  s.authors     = [ "Kyle Sexton" ]
  s.date        = "Mon Dec 31 14:41 CST 2010"
  s.contact     = "Kyle Sexton"
  s.description = "Displays your current internal and external IP address"
  s.notes       = <<NOTES
Displays the current internal IP address of your system.  To get your external IP
mouse over the sublet.
NOTES
  s.version     = "0.4"
  s.tags        = [ "net", "watch" ]
  s.files       = [ "ipaddr.rb" ]
  s.icons       = [ ]

end
