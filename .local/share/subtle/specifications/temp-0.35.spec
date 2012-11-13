# Temp specification file
# Created with sur-0.1
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Temp"
  s.version     = "0.35"
  s.tags        = [ "Sys", "Icon", "Config" ]
  s.files       = [ "temp.rb" ]
  s.icons       = [ "icons/temp.xbm" ]

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Wed Mar 23 22:51 CET 2011"

  # Sublet description
  s.description = "Show the temperature"
  s.notes       = <<NOTES
This sublet displays the temperature data of the available hardware
monitors (hwmons) found /sys/class/hwmon. Each entry there represents
a specific monitor, identified by a name available in the name file.

When unconfigured, the sublet displays all found monitors, otherwise
just the specific monitors in the given order.
NOTES

  # Sublet config
  s.config      = [
    {
      :name        => "scale",
      :type        => "string",
      :description => "Temperature scale (scales: K, F, R, D, N, C)",
      :def_value   => "C"
    },
    {
      :name        => "show_name",
      :type        => "bool",
      :description => "Show names of the monitors",
      :def_value   => "true"
    },
    {
      :name        => "monitors",
      :type        => "string/array",
      :description => "Comma separated list or array of monitors",
      :def_value   => ""
    },
    {
      :name        => "separator",
      :type        => "string",
      :description => "Separator to put between each temperature",
      :def_value   => " "
    }
  ]

  # Sublet requirement
  s.required_version = "0.9.2739"
end
