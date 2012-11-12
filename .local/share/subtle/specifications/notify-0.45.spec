# Notify specification file
# Created with sur-0.2.168
Sur::Specification.new do |s|
  # Sublet information
  s.name             = "Notify"
  s.version          = "0.45"
  s.tags             = [ "FFI", "DBus", "Icon", "Window", "Config" ]
  s.files            = [ "notify.rb" ]
  s.icons            = [ "icons/info.xbm" ]

  # Sublet description
  s.description      = "Display libnotify messages"
  s.notes            = <<NOTES
This sublet replaces the current libnotify handler, it collects messages and
basically consists of an icon and a message window. Once a message is received
the icon changes its color to the highlight color. By pointing the mouse on the
sublet, the message window will be visible beneath the sublet and the messages
can be read. When the mouse leaves the sublet the message window disappears
again and all messages are discarded.

(Max. length of a message is 50 characters)
NOTES

  # Sublet authors
  s.authors          = [ "unexist" ]
  s.contact          = "unexist@subforge.org"
  s.date             = "Tue Jul 10 17:20 CET 2012"

  # Sublet config
  s.config           = [
    {
      :name        => "font",
      :type        => "string",
      :description => "Window font",
      :def_value   => "-*-fixed-*-*-*-*-10-*-*-*-*-*-*-*",
    },
    {
      :name        => "foreground",
      :type        => "string",
      :description => "Foreground color of the window (#rrggbb)",
      :def_value   => "sublets_fg",
    },
    {
      :name        => "background",
      :type        => "string",
      :description => "Background color of the window (#rrggbb)",
      :def_value   => "sublets_bg",
    },
    {
      :name        => "highlight",
      :type        => "string",
      :description => "Highlight color of the icon (#rrggbb)",
      :def_value   => "focus_fg",
      }
  ]

  # Sublet requirements
  s.required_version = "0.10.3205"
  s.add_dependency("ffi", ">=0.5.4")
end
