# -*- encoding: utf-8 -*-
# Membar specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  s.name             = "Membar"
  s.authors          = [ "unexist" ]
  s.date             = "Mon Dec 20 20:57 CET 2010"
  s.contact          = "unexist@dorfelite.net"
  s.description      = "Display memory usage"
  s.notes            = <<NOTES
This sublet provides information about the used system memory via a kind of
progressbar meters. It consists of a default bar, that displays the overall
used memory and a small popup window. The popup is visible while the pointer
is over the sublet and contains more bars about caches and buffers as well as
swap.
NOTES
  s.config           = [
    { :name => "width",  :type => "integer", :description => "Width of the bars" },
    { :name => "height", :type => "integer", :description => "Height of the bars" },
    { :name => "font",   :type => "string",  :description => "Font for popup window" }
  ]
  s.version          = "0.0"
  s.tags             = [ "Proc", "Bar", "Window" ]
  s.files            = [ "membar.rb" ]
  s.icons            = [ ]
  s.subtlext_version = "0.9.2432"
end
