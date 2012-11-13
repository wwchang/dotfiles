# -*- encoding: utf-8 -*-
# Keyboard specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Keyboard"
  s.version     = "0.1"
  s.tags        = [ "Icon", "Config", "Virtual" ]
  s.files       = [ "keyboard.rb" ]
  s.icons       = [ "icons/ab.xbm" ]

  # Sublet description
  s.description = "Virtual keyboard based on subtlext"
  s.notes       = <<NOTES
Simple virtual keyboard based on subtlext.

Limitation: While the keyboard is running it blocks and pressed
grabs are executed _after_ you hide the keyboard. This is due to the
single thread design of subtle and subtlext.
NOTES

  # Sublet authors
  s.authors     = [ "Christoph Kappel" ]
  s.contact     = "chkappel@subforge.org"
  s.date        = "Wed Aug 17 15:20 CEST 2011"

  # Sublet config
  s.config = [
    {
      :name        => "layout",
      :type        => "string",
      :description => "Keymap of the keyboard",
      :def_value   => "qwertz"
    },
    {
      :name        => "width",
      :type        => "integer",
      :description => "Width of the keyboard",
      :def_value   => "Width of screen"
    },
    {
      :name        => "height",
      :type        => "integer",
      :description => "Height of the keyboard",
      :def_value   => "200"
    },
    {
      :name        => "button_fg",
      :type        => "string",
      :description => "Foreground color of buttons",
      :def_value   => "#000000"
    },
    {
      :name        => "button_bg",
      :type        => "string",
      :description => "Background color of buttons",
      :def_value   => "#ffffff"
    },
    {
      :name        => "button_shadow",
      :type        => "string",
      :description => "Shadow color of buttons",
      :def_value   => "#a8a8a8"
    },
    {
      :name        => "button_alt",
      :type        => "string",
      :description => "Alternate color of buttons (Shift)",
      :def_value   => "#cdcdcd"
    },
    {
      :name        => "background",
      :type        => "string",
      :description => "Background color of the window",
      :def_value   => "#d0d0d0"
    }
  ]

  # Sublet requirements
  s.required_version = "0.10.3006"
end
