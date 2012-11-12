# Layout specification file
# Created with sur-0.2.155
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Layout"
  s.version     = "0.15"
  s.tags        = [ "Layout", "Tiling", "Automatic", "Icon", "Config", "Grab" ]
  s.files       = [ "layout.rb" ]
  s.icons       = [
    "icons/tn.xbm",
    "icons/tb.xbm",
    "icons/tf.xbm",
    "icons/tg.xbm",
    "icons/th.xbm",
    "icons/tl.xbm",
    "icons/tr.xbm",
    "icons/tt.xbm",
    "icons/tv.xbm"
  ]

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Thu Mar 24 20:50 CEST 2011"

  # Sublet description
  s.description = "Sublet for view based tiling layouts"
  s.notes       = <<NOTES
This sublet adds common automatic tiling capabilites to subtle for people who
cannot live without. All tiling layouts work view wise and can be changed
independently. It basically consists of an icon that shows a graphic of the
current active layout. Clicking on it cycles through all of them and there are
grabs availabe to change layouts via keys.

Following layouts are available in given order:
  none       = No automatic tiling (default)
  gravity    = Tile clients with same gravity
  vertical   = Vertical tiling
  horizontal = Horizontal tiling
  left       = Tile left, master right
  right      = Tile right, master left
  top        = Tile top, master bottom
  bottom     = Tile bottom, master top
NOTES

  # Sublet config
  s.config   = [
    {
      :name        => "border",
      :type        => "integer",
      :description => "Window border",
      :def_value   => "2"
    },
    {
      :name        => "def_layout",
      :type        => "string",
      :description => "Default layout",
      :def_value   => "none"
    }
  ]

  # Sublet grabs
  s.grabs    = {
    :LayoutNext          => "Select next layout",
    :LayoutPrev          => "Select previous layout",
    :LayoutSetNone       => "Select none layout",
    :LayoutSetGravity    => "Select gravity layout",
    :LayoutSetVertical   => "Select vertical layout",
    :LayoutSetHorizontal => "Select horizontal layout",
    :LayoutSetLeft       => "Select left layout",
    :LayoutSetRight      => "Select right layout",
    :LayoutSetTop        => "Select top layout",
    :LayoutSetBottom     => "Select bottom layout"
  }

  # Need specific version
  s.required_version = "0.9.2608"
end
