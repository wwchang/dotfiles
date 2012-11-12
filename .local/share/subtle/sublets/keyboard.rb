# Keyboard sublet file
# Created with sur-0.2

# Keyboard class {{{
class Keyboard < Subtlext::Window
  # Known keymaps (<> = separator for blank keys)
  KEYMAP = {
    :qwertz => {
      :norm => [
        %w(q w e r t <> <> 7 8 9 <> <> z u i o p),
        %w(a s d f g <> <> 4 5 6 <> <> h j k l Ret),
        %w(Shift y x c v ! <> 1 2 3 <> ? b n m Bksp Shift),
        %w(Ctrl Super Space Space Alt , <> 0 Esc Tab <> . AltGr Space Space Super Hide)
      ],
      :shift => [
        %w(Q W E R T $ / [ ^ ] \\ ~ Z U I O P),
        %w(A S D F G & - < @ > _ \ # H J K L Ret),
        %w(Shift Y X C V ( " { v } ' ) B N M Bksp Shift),
        %w(Ctrl Super Space Space Alt ; + * Esc Tab = : AltGr Space Space Super Hide)
      ]
    }
  }

  # Translation list for special keysyms including modifier
  TRANSLATION = {
    # Syms
    "!"  => "S-exclam",     "?"  => "S-question",     ","  => "comma",
    "."  => "period",       "%"  => "S-percent",      "$"  => "S-dollar",
    "/"  => "S-slash",      "["  => "G-bracketleft",  "]"  => "G-bracketright",
    "\\" => "G-backslash",  "~"  => "G-asciitilde",   "&"  => "S-ampersand",
    "-"  => "minus",        "<"  => "less",           "@"  => "G-at",
    ">"  => "S-greater",    "_"  => "S-underscore",   "("  => "S-parenleft",
    "\"" => "S-quotedbl",   "{"  => "G-braceleft",    "}"  => "G-braceright",
    "'"  => "S-apostrophe", ")"  => "S-parenright",   ";"  => "S-semicolon",
    "+"  => "plus",         "*"  => "S-asterisk",     "="  => "S-equal",
    ":"  => "S-colon",      "#"  => "numbersign",

    # Special
    "Ret"   => "Return", "Esc"   => "Escape",
    "Tab"   => "Tab",    "Bksp"  => "BackSpace",
    "Space" => "space",  "AltGr" => "ISO_Level3_Shift"
  }

  # Translation for arrow keys
  ARROWS = { "^" => "Up", ">" => "Right", "v" => "Down", "<" => "Left" }

  # Translation for modifier keys
  MODIFIER = {
    "Shift" => "S-", "Alt"   => "A-", "Ctrl" => "C-",
    "Super" => "W-", "AltGr" => "G-"
  }

  # Translation for keypad numbers
  NUMBERS = Hash[*(0..9).map { |v| ["#{v}", "KP_#{v}"] }.flatten]

  ## initialize {{{
  # Init keyboard
  # @param [Symbol]  keymap    Selected keymap
  # @param [Hash]    geometry  Window geometry
  # @param [Hash]    colors    Colors hash
  ##

  def initialize(keymap, geometry, colors = {})
    @map        = KEYMAP[keymap]
    @mode       = :norm
    @modifier   = ""
    @key_width  = geometry[:width] / @map[@mode][0].size
    @key_height = geometry[:height] / @map[@mode].size

    # Colors
    @button_shadow = colors[:button_shadow]
    @button_fg     = colors[:button_fg]
    @button_bg     = colors[:button_bg]
    @button_alt    = colors[:button_alt]

    super(geometry)

    # Config
    self.name         = "Keyboard"
    self.foreground   = colors[:background]
    self.background   = colors[:background]
    self.border_size  = 0

    # Add event handler
    on :draw, method(:redraw)
    on :mouse_down, method(:mouse_down)
  end # }}}

  ## redraw {{{
  # Redraw keyboard
  # @param  [Window]  w  Window instance
  ###

  def redraw(w)
    clear
    y = 0

    @map[@mode].each_with_index do |row, ridx|
      x = 0

      row.each_with_index do |key, kidx|
        last   = (kidx == row.size - 1)
        width  = @key_width
        height = @key_height

        # Check for empty keys
        if("<>" != key)
          # Check for double keys
          if(key == row[kidx + 1])
            next
          elsif(0 < kidx and key == row[kidx - 1])
            width *= 2
          end

          # Stretch last key on row and whole last row
          width  += w.geometry.width - (x + width) - 1 if(last)
          height += w.geometry.height - (y + height) - 1 if(ridx == @map[@mode].size - 1)

          draw_key(x, y, width, height, key, ("<>" == @map[:norm][ridx][kidx] or "Shift" == key))
        end

        x += width
      end

      y += @key_height
    end
  end # }}}

  ## mouse_down {{{
  # Handle pointer down events
  # @param [Fixnum]  x  Event x
  # @param [Fixnum]  y  Event y
  # @return [True, False] Whether to continue loop
  ##

  def mouse_down(x, y)
    ret = true

    # Find key
    posx = x / @key_width
    posy = y / @key_height
    key  = @map[@mode][posy][posx]

    # Special keys
    case key
      # Modifier keys
      when *MODIFIER.keys
        # Toggle modes
        if("Shift" == key)
          @mode = case @mode
            when :norm    then :shift
            when :shift   then :norm
          end
          redraw(self)
        end

        @modifier << MODIFIER[key]
        key        = nil

      # Arrow keys
      when *ARROWS.keys
        if(:shift == @mode)
          key       = ARROWS[key] 
          @modifier = ""
        end

      # Special keys
      when "Hide"
        ret = false
        key = nil

      # Numbers
      when *NUMBERS.keys then key = NUMBERS[key]


      # Translate other keys
      else
        if(TRANSLATION.has_key?(key))
          key       = TRANSLATION[key]
          @modifier = "" #< Unset modifier list
        end
    end

    # Finally send key
    unless(key.nil?)
      focus = Subtlext::Client.current
      key   = "%s%s" % [ @modifier, 1 == key.size ? key.downcase : key ]

      focus.send_key(key)

      # Reset mode after send key
      if(:norm != @mode)
        @mode     = :norm
        redraw(self)
      end

      @modifier = ""
    end

    ret
  end # }}}

  ## draw_key {{{
  # Draw key
  # @param [Fixnum]       x    X position
  # @param [Fixnum]       y    Y position
  # @param [Fixnum]       w    Key width
  # @param [Fixnum]       h    Key height
  # @param [String]       key  Key label
  # @param [True, False]  alt  Whether to use alt color
  ##

  def draw_key(x, y, w, h, key, alt = false)
    # Draw drop shadow, key and text
    draw_rect(x + 4, y + 4, w - 6, h - 6, @button_shadow, true)
    draw_rect(x + 3, y + 3, w - 6, h - 6, alt ? @button_shift : @button_bg, true)
    draw_text(x + w / 4, y + h / 2, key, @button_fg)
  end # }}}
end # }}}

configure :keyboard do |s| # {{{
  s.icon = Subtlext::Icon.new("ab.xbm")
  s.data = s.icon.to_s

  geom = Subtlext::Screen.current.geometry

  # Config
  width  = s.config[:width]  || geom.width
  height = s.config[:height] || 200
  layout = s.config[:layout].to_sym rescue :qwertz

  # Colors
  colors = {}
  colors[:button_fg]     = Subtlext::Color.new((s.config[:button_fg]     || "#b8b8b8"))
  colors[:button_bg]     = Subtlext::Color.new((s.config[:button_bg]     || "#757575"))
  colors[:button_alt]    = Subtlext::Color.new((s.config[:button_alt]    || "#3d3d3d"))
  colors[:button_shadow] = Subtlext::Color.new((s.config[:button_shadow] || "#b8b8b8"))
  colors[:background]    = Subtlext::Color.new((s.config[:background]    || "#202020"))

  s.keyboard = Keyboard.new(:qwertz,
    { x: 0, y: geom.height - height, width: width, height: height },
    colors
  )
end # }}}

on :mouse_down do |s| # {{{
  s.keyboard.show
  s.keyboard.hide
end # }}}
