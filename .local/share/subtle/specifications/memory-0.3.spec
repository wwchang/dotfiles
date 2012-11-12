# Memory specification file
# Created with sur-0.1
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Memory"
  s.version     = "0.3"
  s.tags        = [ "Proc", "Icon" ]
  s.files       = [ "memory.rb" ]
  s.icons       = [ "icons/memory.xbm" ]

  # Sublet authors
  s.authors     = [ "Christoph Kappel" ]
  s.date        = "Thu Apr 21 14:10 CET 2011"
  s.contact     = "unexist@dorfelite.net"

  # Sublet description
  s.description = "Show the memory usage"
  s.notes       = <<NOTES
This sublet just reads the memory usage from /proc/meminfo and displays the
amount of free and used memory.
NOTES
end
