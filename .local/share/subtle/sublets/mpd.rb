# Mpd sublet file
# Created with sur-0.1
require "socket"
require "subtle/subtlext"

# Class Pointer {{{
class Pointer
  attr_accessor :value

  def initialize(value = nil)
    @value = value
  end

  def to_s
    value.to_s
  end
end # }}}

# Class Mpd {{{
class Mpd
  # Mpd state
  attr_accessor :state

  # Mpd options
  attr_accessor :repeat
  attr_accessor :random
  attr_accessor :database

  # Mpd socket
  attr_accessor :socket

  # Mpd current song
  attr_accessor :current_song

  ## initialize {{{
  # Create a new mpd object
  # @param [String]  host      Hostname
  # @param [Fixnum]  port      Port
  # @param [String]  password  Password
  ##

  def initialize(host, port, password = nil)
    @host         = host
    @port         = port
    @password     = password
    @socket       = nil
    @state        = :off
    @repeat       = false
    @random       = false
    @database     = false
    @current_song = {}
  end # }}}

  ## connect {{{
  # Open connection to mpd
  # @return [Bool] Whether connection succeed
  ##

  def connect
    begin
      # Check socket type
      if(File.socket?(@host))
        @socket = UNIXSocket.new(@host)
      else
        @socket = TCPSocket.new(@host, @port)
      end

      # Handle SIGPIPE
      trap "PIPE" do
        @socket = nil
        disconnect
      end

      # Wait for mpd header
      safe_read(1)

      # Send password if any
      unless(@password.nil?)
        safe_write("password #{@password}")
        return false unless(get_ok(1))
      end

      parse_status
      parse_current
      idle
    rescue Errno::ECONNREFUSED
      puts "mpd not running"
    rescue
    end

    !@socket.nil?
  end # }}}

  ## disconnect {{{
  # Send close and shutdown
  ###

  def disconnect
    safe_write("close") unless(@socket.nil?)

    @socket = nil
    @state  = :off
  end # }}}

  ## action # {{{
  # Send action to mpd
  # @param [String]  command  Mpd action
  ##

  def action(command)
    noidle
    safe_write(command)
  end # }}}

  ## update {{{
  # Update mpd
  # @return [Bool] Whether update was successful
  ##

  def update
    get_ok(1)
    parse_status
    parse_current
    idle

    !@socket.nil?
  end # }}}

  private

  ## safe_read {{{
  # Read data from socket
  # @param [Fixnum]  timeout  Timeout in seconds
  # @return [String] Read data
  ##

  def safe_read(timeout = 0)
    line = ""

    unless(@socket.nil?)
      begin
        sets = select([ @socket ], nil, nil, timeout)
        line = @socket.readline unless(sets.nil?) #< No nil is a socket hit
      rescue EOFError
        puts "mpd read: EOF"
        @socket = nil
        disconnect
      rescue
        disconnect
      end
    end

    line
  end # }}}

  ## safe_write {{{
  # Write dats to socket
  # @param [String]  str  String to write
  ##

  def safe_write(str)
    return if(str.nil? or str.empty?)

    unless(@socket.nil?)
      begin
        @socket.write("%s\n" % [ str ])
      rescue
        disconnect
      end
    end
  end # }}}

  ## idle {{{
  # Send idle command
  ##

  def idle
    safe_write("idle player options update") unless(@socket.nil?)
  end # }}}

  ## noidle {{{
  # Send noidle command
  ###

  def noidle
    safe_write("noidle")
    get_ok(1)
  end # }}}

  ## get_ok {{{
  # Get ok or error
  # @param [Fixnum]  timeout  Timeout in seconds
  # @return [Bool] Whether mpd return ok
  ##

  def get_ok(timeout = 0)
    unless(@socket.nil?)
      line = safe_read(timeout)
      line = safe_read(timeout) if(line.match(/^changed/)) #< Skip changed message

      # Check result
      if(line.match(/^OK/))
        true
      elsif((match = line.match(/^ACK \[(.*)\] \{(.*)\} (.*)/)))
        disconnect

        # Probably non-recoverable
        puts "mpd %s error: %s" % [ match[2], match[3] ]

        false
      end
    end
  end # }}}

  ## get_reply {{{
  # Send command and return reply as hash
  # @oaran [String]  command  Command to send
  # return [Hash] Data hash
  ###

  def get_reply(command)
    hash = {}

    unless(@socket.nil?)
      begin
        safe_write(command)

        while
          line = safe_read(1)

          # Check response
          if(line.match(/^OK/))
            break
          elsif((match = line.match(/^ACK \[(.*)\] \{(.*)\} (.*)/)))
            disconnect

            # Probably non-recoverable
            puts "mpd %s error: %s" % [ match[2], match[3] ]

            raise #< Exit loop
          elsif((match = line.match(/^(\w+): (.+)$/)))
            hash[match[1].downcase] = match[2]
          end
        end
      rescue
        hash = {}
      end
    end

    hash
  end # }}}

  ## parse_status {{{
  # Parse mpd status
  ###

  def parse_status
    unless(@socket.nil?)
      status = get_reply("status")

      # Convert state
      @state = case status["state"]
        when "play"  then :play
        when "pause" then :pause
        when "stop"  then :stop
        else :off
      end

      # Set modes
      @repeat   = (0 == status["repeat"].to_i) ? false : true
      @random   = (0 == status["random"].to_i) ? false : true
      @database = !status["updating_db"].nil?
    end
  end # }}}

  ## parse_current {{{
  # Parse mpd current song
  ##

  def parse_current
    unless(@socket.nil?)
      @current_song = get_reply("currentsong")
    else
      @current_song = {}
    end
  end # }}}
end # }}}

configure :mpd do |s| # {{{
  # Icons
  s.icons = {
    :play     => Subtlext::Icon.new("play.xbm"),
    :pause    => Subtlext::Icon.new("pause.xbm"),
    :stop     => Subtlext::Icon.new("stop.xbm"),
    :prev     => Subtlext::Icon.new("prev.xbm"),
    :next     => Subtlext::Icon.new("next.xbm"),
    :note     => Subtlext::Icon.new("note.xbm"),
    :repeat   => Subtlext::Icon.new("repeat.xbm"),
    :random   => Subtlext::Icon.new("shuffle.xbm"),
    :database => Subtlext::Icon.new("diskette.xbm")
  }

  # Options
  s.def_action       = s.config[:def_action]
  s.wheel_up         = s.config[:wheel_up]
  s.wheel_down       = s.config[:wheel_down]
  s.format_string    = s.config[:format_string]    || "%note%%artist% - %title%"
  s.not_running_text = s.config[:not_running_text] || "-- not running --"
  s.stop_text        = s.config[:stop_text]        || "-- stopped --"
  s.pause_text       = s.config[:pause_text]       || "-- paused --"
  s.blank_text       = s.config[:blank_text]       || "n/a"
  s.show_icons       = s.config[:show_icons].nil? ? true : s.config[:show_icons]
  s.show_pause       = s.config[:show_pause].nil? ? true : s.config[:show_pause]

  # Colors
  if(s.config[:show_colors])
    s.colors = {
      :note  => "#ffffff", :artist => "#757575",
      :album => "#757575", :title  => "#757575",
      :track => "#757575", :id     => "#757575",
      :pause => "#FECF35", :stop   => "#757575",
    }

    s.colors.each do |k, v|
      s.colors[k] = Subtlext::Color.new(s.config["#{k}_color".to_sym] || v)
    end
  else
    s.colors = {}
  end

  # Sanitize actions
  valid = [ "play", "pause 0", "pause 1", "toggle", "stop", "previous", "next" ]

  s.def_action = "toggle"   unless(valid.include?(s.def_action))
  s.wheel_up   = "next"     unless(valid.include?(s.wheel_up))
  s.wheel_down = "previous" unless(valid.include?(s.wheel_down))

  # Parse format string once
  fields = [ "note", "artist", "album", "title", "track", "id" ]

  s.format_values = {}

  s.format_string.gsub!(/%([^%]+)%/) do
    field = $1
    out   = ""

    # Add colors before fields
    if(s.colors.has_key?(field.to_sym))
      s.format_values["#{field}_color"] = Pointer.new(s.colors[field.to_sym])

      out << "%s"
    end

    # Add fields
    if(fields.include?(field))
      if("note" == field)
        s.format_values[field] = self.icons[:note]
      else
        s.format_values[field] = Pointer.new
      end

      out << "%s"
    end

    out
  end

  # Create mpd object
  host, password = (s.config[:host] || ENV["MPD_HOST"] || "localhost").split("@")
  port           = s.config[:port]  || ENV["MPD_PORT"] || 6600

  s.mpd = Mpd.new(host, port, password)

  watch(s.mpd.socket) if(s.mpd.connect)

  update_status
end # }}}

helper do |s| # {{{
  def current_song # {{{
    # Replace empty values by blank text
    self.format_values.each do |k, v|
      if(self.mpd.current_song.has_key?(k))
        v.value = (self.mpd.current_song[k].nil? or
          self.mpd.current_song[k].empty? ? self.blank_text :
            self.mpd.current_song[k])
      # Set field to blank text
      elsif(v.is_a?(Pointer) and !k.end_with?("_color"))
        v.value = self.blank_text
      end
    end

    # Assemble format
    self.format_string % self.format_values.values
  end # }}}

  def update_status # {{{
    mesg  = self.not_running_text
    icon  = :play
    modes = ""

    unless(self.mpd.socket.nil?)
      # Modes
      modes << self.icons[:repeat]   if(self.mpd.repeat)
      modes << self.icons[:random]   if(self.mpd.random)
      modes << self.icons[:database] if(self.mpd.database)
      modes = " %s" % [ modes ] unless(modes.empty?)

      # Assemble data based on state
      case(self.mpd.state)
        when :play
          mesg = current_song
          icon = :pause
        when :pause
          if(self.show_pause)
            mesg = "%s%s" % [ self.colors[:pause] || "", self.pause_text ]
          else
            mesg = current_song
          end

          icon = :play
        when :stop
          mesg = "%s%s" % [ self.colors[:stop] || "", self.stop_text ]
          icon = :play
      end
    end

    # Add some icons
    if(self.show_icons)
      mesg = "%s%s%s%s%s %s" % [
        self.icons[icon], self.icons[:stop],
        self.icons[:prev], self.icons[:next],
        modes, mesg
      ]
    end

    self.data = mesg
  end # }}}

  def toggle_state(force = false) # {{{
    if(force or "toggle" == self.def_action)
      case self.mpd.state
        when :stop  then "play"
        when :pause then "pause 0"
        when :play  then "pause 1"
      end
    else
      self.def_action
    end
  end # }}}

  def send_action(action) # {{{
    # Reconnect if necessary
    if(self.mpd.socket.nil?)
      watch(self.mpd.socket) if(self.mpd.connect)
      update_status
    else
      self.mpd.action(action)
    end
  end # }}}
end # }}}

on :mouse_down do |s, x, y, b| # {{{
  # Handle clicks based on x coord and state
  if(s.show_icons)
    action = case b
      when 1
        case x
          when  0..15 then toggle_state(true)
          when 16..31 then "stop"
          when 32..47 then "previous"
          when 48..63 then "next"
          else toggle_state
        end
      when 4 then s.wheel_up
      when 5 then s.wheel_down
    end
  else
    action = case b
      when 1 then toggle_state
      when 4 then s.wheel_up
      when 5 then s.wheel_down
    end
  end

  # Send to socket
  send_action(action)
end # }}}

on :watch do |s| # {{{
  unwatch unless(s.mpd.update)
  update_status
end # }}}

# Grabs

grab :MpdToggle do |s| # {{{
  send_action(toggle_state)
end # }}}

# Other grabs {{{
{
  :MpdPlay => "play",  :MpdPause    => "pause 1",
  :MpdStop => "stop",  :MpdPrevious => "previous",
  :MpdNext => "next"
}.each do |k, v|
  grab k do |s|
    send_action(v)
  end
end # }}}
