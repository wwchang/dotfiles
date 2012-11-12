# Netchart specification file
# Created with sur-0.1.129
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Netchart"
  s.version     = "0.4"
  s.tags        = [ "Icon", "Chart", "Config" ]
  s.files       = [ "netchart.rb" ]
  s.icons       = [
    "icons/rx.xbm",
    "icons/tx.xbm"
  ]

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Mon Mar 01 00:53 CET 2010"

  # Sublet description
  s.description = "Show rx/tx data of given interface"
  s.notes       = <<NOTES
This sublet just displays the current rx/tx values of a given device
in a small chart.
NOTES

  # Sublet config
  s.config      = [
    {
      :name        => "interval",
      :type        => "integer",
      :description => "Update interval in seconds",
      :def_value   => "30"
    },
    {
      :name        => "device",
      :type        => "string",
      :description => "Name of the monitored device (like wlan0)",
      :def_value   => "eth0"
    },
    {
      :name        => "title",
      :type        => "string",
      :description => "Chart title prefix",
      :def_value   => ""
    },
    {
      :name        => "rx_color",
      :type        => "string",
      :description => "Chart rx color (#rrggbb)",
      :def_value   => "#ff0000"
    },
    {
      :name        => "tx_color",
      :type        => "string",
      :description => "Chart tx color (#rrggbb)",
      :def_value   => "#0000ff"
    },
    {
      :name        => "bg_color",
      :type        => "string",
      :description => "Chart background color (#rrggbb)",
      :def_value   => "Color of panel"
    },
    {
      :name        => "width",
      :type        => "integer",
      :description => "Chart width",
      :def_value   => "30"
    },
    {
      :name        => "height",
      :type        => "integer",
      :description => "Chart height",
      :def_value   => "10"
    }
  ]

  # Sublet requirements<
  s.required_version = "0.9.2634"
end
