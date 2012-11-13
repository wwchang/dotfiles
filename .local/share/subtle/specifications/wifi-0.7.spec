# Wifi specification file
# Created with sur-0.1
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Wifi"
  s.version     = "0.7"
  s.tags        = [ "Socket", "Proc", "Icon", "Config" ]
  s.files       = [ "wifi.rb" ]
  s.icons       = [ "icons/wifi.xbm" ]

  # Sublet authors
  s.authors     = [ "Christoph Kappel" ]
  s.contact     = "chkappel@gmail.com"
  s.date        = "Mon Jul 18 20:21 CET 2011"

  # Sublet description
  s.description = "Show the link quality of a wifi device"
  s.notes       = <<NOTES
This sublet just displays link quality of a given device (optimistically
assumed, that 100 is the highest possible quality) and the name of
the associated essid.
NOTES

  # Sublet config<
  s.config      = [
    {
      :name        => "device",
      :type        => "string",
      :description => "Name of the monitored device (like wlan0)",
      :def_value   => "wlan0"
    }
  ]
end
