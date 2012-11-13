# Layout sublet file
# Created with sur-0.2.155
configure :layout do |s| # {{{
  s.cur_view = Subtlext::View.current.name.to_sym

  # Icon for modes
  s.modes = {
    :none        => Subtlext::Icon.new("tn.xbm"),
    :gravity     => Subtlext::Icon.new("tg.xbm"),
    :vertical    => Subtlext::Icon.new("tv.xbm"),
    :horzizontal => Subtlext::Icon.new("th.xbm"),
    :left        => Subtlext::Icon.new("tl.xbm"),
    :right       => Subtlext::Icon.new("tr.xbm"),
    :top         => Subtlext::Icon.new("tt.xbm"),
    :bottom      => Subtlext::Icon.new("tb.xbm")
  }

  # Options
  s.border = s.config[:border] || 2

  # Check and set default layout
  s.def_layout = s.config[:def_layout]
  s.def_layout.to_sym if(s.def_layout.is_a?(String))
  s.def_layout = :none unless(s.modes.keys.include?(s.def_layout))
  s.data       = s.modes[s.def_layout].to_s

  # Apply default layout to views
  s.view_mode = Hash[
    *Subtlext::View.all.collect { |v|
      [ v.name.to_sym, s.def_layout ]
    }.flatten
  ]
end # }}}

helper do |s| # {{{
  ## tile {{{
  # Do the actual tiling
  ##

  def tile
    clients = Subtlext::View[self.cur_view].clients

    unless(clients.empty?)
      geometry = Subtlext::Screen.current.geometry

      # Tiling now
      case self.view_mode[self.cur_view]
        when :gravity # {{{
          assoc = {}

          # Collect gravities
          clients.each do |c|
            if(assoc[c.gravity.id].is_a?(Array))
              assoc[c.gravity.id] << c
            else
              assoc[c.gravity.id] = [ c ]
            end
          end

          # Tile associated windows
          assoc.each do |k, v|
            gravity    = Subtlext::Gravity[k]
            x, y, w, h = gravity.geometry_for(Subtlext::Screen.current)
            width      = w / v.size
            fix        = w - v.size * width
            last       = v.pop

            # Set client sizes
            v.each do |c|
              c.geometry = [
                x, y, width - 2 * self.border, h - 2 * self.border
              ]

              x += width
            end

            # Add size fix
            last.geometry = [
              x, y, width + fix - 2 * self.border, h - 2 * self.border
            ]
          end # }}}
        when :vertical, :horzizontal # {{{
          g    = Subtlext::Geometry.new(geometry)
          last = clients.pop

          # Calculate width and height
          case self.view_mode[self.cur_view]
            when :vertical
              g.height = geometry.height / (clients.size + 1)
            when :horzizontal
              g.width  = geometry.width / (clients.size + 1)
          end

          # Update clients
          clients.each do |c|
            c.geometry = [
              g.x, g.y, g.width - 2 * self.border, g.height - 2 * self.border
            ]

            # Steps
            case self.view_mode[self.cur_view]
              when :vertical    then g.y += g.height
              when :horzizontal then g.x += g.width
            end
          end

          # Fix rounding
          case self.view_mode[self.cur_view]
            when :vertical
              g.height += geometry.height - (clients.size + 1) * g.height
            when :horzizontal
              g.width  += geometry.width - (clients.size + 1) * g.width
          end

          last.geometry = [
            g.x, g.y, g.width - 2 * self.border, g.height - 2 * self.border
          ]
          # }}}
        when :left, :right, :top, :bottom # {{{
          g     = Subtlext::Geometry.new(geometry)
          first = clients.shift
          size  = clients.size.zero? ? 1 : clients.size

          case self.view_mode[self.cur_view]
            when :left
              g.width = geometry.width / 2
              g.x     = geometry.x + g.width
              fix     = geometry.width - 2 * g.width #< Fix rounding
            when :right
              g.x     = geometry.x
              g.width = geometry.width / 2
              fix     = geometry.width - 2 * g.width #< Fix rounding
            when :top
              g.height = geometry.height / 2
              g.y      = geometry.y + g.height
              fix      = geometry.height - 2 * g.height #< Fix rounding
            when :bottom
              g.y      = geometry.y
              g.height = geometry.height / 2
              fix      = geometry.height - 2 * g.height #< Fix rounding
          end

          # Set first client
          first.geometry = [
            g.x, g.y, g.width - 2 * self.border, g.height - 2 * self.border
          ]

          case self.view_mode[self.cur_view]
            when :left
              g.x      = geometry.x
              g.height = geometry.height / size
              fix      = geometry.height - size * g.height #< Fix rounding
            when :right
              g.x      = geometry.x + g.width
              g.height = geometry.height / size
              fix      = geometry.height - size * g.height #< Fix rounding
            when :top
              g.y     = geometry.y
              g.width = geometry.width / size
              fix     = geometry.width - size * g.width #< Fix rounding
            when :bottom
              g.y     = geometry.y + g.height
              g.width = geometry.width / size
              fix     = geometry.width - size * g.width #< Fix rounding
          end

          # Update clients
          clients.each do |c|
            c.geometry = [
              g.x, g.y, g.width - 2 * self.border, g.height - 2 * self.border
            ]

            if(:left == self.view_mode[self.cur_view] or
                :right == self.view_mode[self.cur_view])
              g.y += g.height
            else
              g.x += g.width
            end
          end # }}}
      end
    end
  end # }}}

  ## select_layout # {{{
  # Select layout for view
  # @param [Fixnum]  dir  Direction
  ##

  def select_layout(dir = 1)
    idx = self.modes.keys.index(self.view_mode[self.cur_view])

    # Select next index
    if((idx + dir) >= self.modes.size)
      idx = 0
    elsif((idx + dir) < 0)
      idx = self.modes.size - 1
    else
      idx += dir
    end

    # Update view mode and icon
    self.view_mode[self.cur_view] = self.modes.keys[idx]
    self.data = self.modes[self.view_mode[self.cur_view]].to_s

    tile
  end # }}}

  ## set_layout # {{{
  # Set specific layout
  # @param [Fixnum]  idx  Layout index
  ##

  def set_layout(idx)
    # Update view mode and icon
    self.view_mode[self.cur_view] = self.modes.keys[idx]
    self.data = self.modes[self.view_mode[self.cur_view]].to_s

    tile
  end # }}}
end # }}}

on :mouse_down do |s, x, y, b| # {{{
  select_layout(1)
end # }}}

on :tile do |s| # {{{
  tile
end # }}}

on :view_jump do |s, v| # {{{
  s.cur_view = v.name.to_sym
  s.data     = s.modes[s.view_mode[s.cur_view]].to_s
end # }}}

on :view_create do |s, v| # {{{
  # Add view with default layout
  s.view_mode[v.name.to_sym] = s.def_layout
end # }}}

on :view_kill do |s, v| # {{{
  # Remove view from list
  s.view_mode.delete(v.name.to_sym)
end # }}}

grab :LayoutNext do |s| # {{{
  select_layout(1)
end # }}}

grab :LayoutPrev do |s| # {{{
  select_layout(-1)
end # }}}

# Create set layout grabs {{{
[
  :LayoutSetNone, :LayoutSetGravity, :LayoutSetVertical, :LayoutSetHorizontal,
  :LayoutSetLeft, :LayoutSetRight,   :LayoutSetTop,      :LayoutSetBottom
].each_with_index do |l, idx|
  grab l do |s|
    set_layout(idx)
  end
end # }}}
