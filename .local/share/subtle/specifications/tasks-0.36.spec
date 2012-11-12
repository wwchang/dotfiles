# Tasks specification file
# Created with sur-0.1
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Tasks"
  s.version     = "0.36"
  s.tags        = [ "Mouse", "Config" ]
  s.files       = [ "tasks.rb" ]
  s.icons       = [ ]

  # Sublet authors
  s.authors     = [ "Christoph Kappel" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Tue Dec 1 23:00 CET 2009"

  # Sublet description
  s.description = "Show visible clients"
  s.notes       = <<NOTES
This sublet displays all visible clients in a tasklist like fashion. Current
client is highlighted and a click on a client name will focus it.
NOTES

  # Sublet config
  s.config      = [
    {
      :name        => "color_active",
      :type        => "string",
      :description => "Color of active window (#rrggbb)",
      :def_value   => "focus_fg"
      },
      {
      :name        => "color_inactive",
      :type        => "string",
      :description => "Color of inactive window (#rrggbb)",
      :def_value   => "views_fg"
      },
      {
      :name        => "color_separator",
      :type        => "string",
      :description => "Color of separator (#rrggbb)",
      :def_value   => "sublets_fg"
      },
      {
      :name        => "separator",
      :type        => "string",
      :description => "Separator between windows",
      :def_value   => " | "
      },
      {
      :name        => "modes",
      :type        => "bool",
      :description => "Display client modes like float",
      :def_value   => "true"
    }
  ]

  # Sublet requirements
  s.required_version = "0.9.2500"
end
