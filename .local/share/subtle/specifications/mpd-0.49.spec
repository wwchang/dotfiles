# Mpd specification file
# Created with sur-0.1
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Mpd"
  s.version     = "0.49"
  s.tags        = [ "Socket", "Icon", "Config", "Format", "Color", "Grab" ]
  s.files       = [ "mpd.rb" ]
  s.icons       = [
    "icons/play.xbm",
    "icons/pause.xbm",
    "icons/stop.xbm",
    "icons/prev.xbm",
    "icons/next.xbm",
    "icons/note.xbm",
    "icons/repeat.xbm",
    "icons/shuffle.xbm",
    "icons/diskette.xbm"
  ]

  # Sublet authors
  s.authors     = [ "Christoph Kappel", "Andrew Fricke", "Douglas Freed", "Dominik Honnef" ]
  s.contact     = "chkappel@gmail.com"
  s.date        = "Thu Jun 09 21:50 CET 2011"

  # Sublet description
  s.description = "Show the current track of mpd and some controls"
  s.notes       = <<NOTES
This sublet displays the current track playing in mpd along with control
buttons like play and stop and random and shuffle mode.

Dependent on the mpd version (>= 0.16), a running database update will be
indicated as well.

Format string
-------------

The output of the sublet can be customized by a format_string. Following
fields are allowed alongside all kind of text, icons and colors:

%note%   - Predefined icon
%artist% - Name of the artist
%album%  - Name of the album
%title%  - Name of the track
%track%  - Track number of current album
%id%     - mpd playlist id

Examples:

%note%%artist% - %album
%artist% :: %album% :: %title%

Actions
-------

Following actions are possible for pointer clicks and wheel up/wheel down:

play      - Start playback
pause 0   - Disable pause mode
pause 1   - Enable pause mode
toggle    - Toggle pause or start playback
stop      - Stop playback
previous  - Play previous track
next      - Play next track

Misc
----

Empty fields are just replaced by text that is configurable with blank_text.

[1] http://www.musicpd.org/doc/protocol/ch02.html#id555938
NOTES

  # Sublet config
  s.config      = [
    {
      :name        => "host",
      :type        => "string",
      :description => "Hostname to connect to (host@password)",
      :def_value   => "$MPD_HOST, localhost"
    },
    {
      :name        => "port",
      :type        => "integer",
      :description => "Port number",
      :def_value   => "$MPD_PORT, 6600"
    },
    {
      :name        => "def_action",
      :type        => "string",
      :description => "Default action on click",
      :def_value   => "toggle"
    },
    {
      :name        => "wheel_up",
      :type        => "string",
      :description => "Default action on wheel up",
      :def_value   => "next"
    },
    {
      :name        => "wheel_down",
      :type        => "string",
      :description => "Default action on wheel down",
      :def_value   => "previous"
    },
    {
      :name        => "format_string",
      :type        => "string",
      :description => "Output format string",
      :def_value   => "%note%%artist% - %album%"
    },
    {
      :name        => "show_icons",
      :type        => "boolean",
      :description => "Whether to show button icons",
      :def_value   => "true"
    },
    {
      :name        => "show_pause",
      :type        => "boolean",
      :description => "Show pause text when mpd is paused",
      :def_value   => "true"
    },
    {
      :name        => "show_colors",
      :type        => "boolean",
      :description => "Whether to use colors to enhance display",
      :def_value   => "false"
    },
    {
      :name        => "not_running_text",
      :type        => "string",
      :description => "Text to display when mpd is not running",
      :def_value   => "-- not running --"
    },
    {
      :name        => "stop_text",
      :type        => "string",
      :description => "Text to display when mpd is stopped",
      :def_value   => "mpd stopped"
    },
    {
      :name        => "pause_text",
      :type        => "string",
      :description => "Text to display when mpd is paused (requires show_pause = true)",
      :def_value   => "-- paused --"
    },
    {
      :name        => "blank_text",
      :type        => "string",
      :description => "Text to display when a field is missing.",
      :def_value   => "n/a"
    },
    {
      :name        => "note_color",
      :type        => "string",
      :description => "Note icon color",
      :def_value   => "#ffffff"
    },
    {
      :name        => "artist_color",
      :type        => "string",
      :description => "Artist color",
      :def_value   => "#757575"
    },
    {
      :name        => "album_color",
      :type        => "string",
      :description => "Album color",
      :def_value   => "#757575"
    },
    {
      :name        => "title_color",
      :type        => "string",
      :description => "Title color",
      :def_value   => "#757575"
    },
    {
      :name        => "track_color",
      :type        => "string",
      :description => "Track color",
      :def_value   => "#757575"
    },
    {
      :name        => "id_color",
      :type        => "string",
      :description => "mpd ID color",
      :def_value   => "#757575"
    },
    {
      :name        => "pause_color",
      :type        => "string",
      :description => "Pause text color",
      :def_value   => "#FECF35"
    },
    {
      :name        => "stop_color",
      :type        => "string",
      :description => "Stop text color",
      :def_value   => "#757575"
    }
  ]

  # Sublet grabs
  s.grabs = {
    :MpdPlay     => "Start playback",
    :MpdPause    => "Enable pause mode",
    :MpdToggle   => "Toggle pause or start playback",
    :MpdStop     => "Stop playback",
    :MpdPrevious => "Play previous track",
    :MpdNext     => "Play next track",
  }
end
