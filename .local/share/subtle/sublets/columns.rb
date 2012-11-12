# Columns sublet file
# Created with sur-0.2

# Column class
class Column # {{{
  # Clients in column
  attr_accessor :clients

  ## border= {{{
  # Set border width
  # @param [Fixnum]  border  Border width
  ##

  def self.border=(border)
    @@border = border
  end # }}}

  ## initialize {{{
  # Initialize class
  # @param [Array]  clients  Array of clients
  ##

  def initialize(clients = [])
    @x       = 0
    @y       = 0
    @width   = 0
    @height  = 0
    @clients = clients
  end # }}}

  ## arrange {{{
  # Arrange clients in column
  # @param [Fixnum]  colx  X Position
  # @param [Fixnum]  coly  Y position
  # @param [Fixnum]  colw  Column width
  # @param [Fixnum]  colh  Column height
  ##

  def arrange(colx, coly, colw, colh)
    unless(@clients.empty?)
      @x      = colx
      @y      = coly
      @width  = colw
      @height = colh

      i      = 0
      n      = @clients.size
      y      = @y
      height = @height / n
      fix    = @height - (height * n)

      @clients.each do |c|
        height += fix if(i == n - 1) #< Add rounding fix

        c.geometry = [
          @x, y,
          @width - 2 * @@border,
          height - 2 * @@border
        ]

        y += height
        i += 1
      end
    end
  end # }}}

  ## << {{{
  # Append client or concat array of clients
  # @param [Subtlext::Client, Column, Array]  value  Client, Column or array of clients
  ##

  def <<(value)
    if(value.is_a?(Column))
      @clients.concat(value.clients)
    elsif(value.is_a?(Array))
      @clients.concat(value)
    elsif(value.is_a?(Subtlext::Client))
      @clients << value
    end
  end # }}}

  ## >> {{{
  # Remove client from column
  # @param [Subtlext::Client]  client  A Subtlext::Client
  ##

  def >>(client)
    @clients.delete(client)
  end # }}}
end # }}}

configure :columns do |s| # {{{
  # Config
  Column.border = s.config[:border] || 2

  # Icon
  s.icon = Subtlext::Icon.new("columns.xbm")

  # Init columns
  s.columns = {}

  Subtlext::View.all.each do |v|
    s.columns[v.name.to_sym] = [ Column.new ]
  end

  s.cur_view = Subtlext::View.current
  s.cur_cols = s.columns[s.cur_view.name.to_sym]

  s.data = "%s%d" % [ s.icon, s.cur_cols.size ]

  tile
end # }}}

helper do |s| # {{{
  def add_column # {{{
    self.cur_cols << Column.new
  end # }}}

  def remove_column # {{{
    if(1 < self.cur_cols.size)
      # Move clients from last column to first
      self.cur_cols.first << self.cur_cols.last

      self.cur_cols.pop
    end
  end # }}}

  def move_to_column(c, colid) # {{{
    # Detach client from previous column
    self.cur_cols.each do |col|
      col >> c

      self.cur_cols.delete(col) if(col.clients.empty?)
    end

    # Attach client to column
    if(colid > self.cur_cols.size)
      col = Column.new
      col << c

      self.cur_cols << col
    else
      self.cur_cols[colid - 1] << c
    end

    tile

    c.focus
  end # }}}

  def tile # {{{
    geometry = Subtlext::Screen.current.geometry
    n     = self.cur_cols.size
    i     = 0
    x     = geometry.x
    width = geometry.width / n
    fix   = geometry.width - (width * n)

    self.cur_cols.each do |col|
      width += fix if(i == n - 1) #< Add rounding fix

      col.arrange(x, geometry.y, width, geometry.height)

      x += width
      i += 1
    end
  end # }}}
end # }}}

# Hooks
on :start do |s| # {{{
  Subtlext::View.all.each do |v|
    s.columns[v.name.to_sym].first << v.clients
  end

  tile
end # }}}

on :tile do |s| # {{{
  tile
end # }}}

on :client_create do |s, c| # {{{
  # Add client to last column
  c.views.each do |v|
    s.columns[v.name.to_sym].last << c
  end

  tile
end # }}}

on :client_kill do |s, c| # {{{
  # Remove client from columns
  s.columns.each do |v, k|
    k.each do |col|
      col >> c

      k.delete(col) if(col.clients.empty?)
    end

  end

  tile
end # }}}

on :view_jump do |s, v| # {{{
  s.cur_view = v
  s.cur_cols = s.columns[v.name.to_sym]

  s.data = "%s%d" % [ s.icon, s.cur_cols.size ]

  tile
end # }}}

on :view_create do |s, v| # {{{
  s.columns[v.name.to_sym] = [[]]
end # }}}

on :view_kill do |s, v| # {{{
  s.columns.delete(v.name.to_sym)
end # }}}

# Grabs
grab :ColumnsAdd do |s| # {{{
  add_column
  s.data = "%s%d" % [ s.icon, s.cur_cols.size ]
  tile
end # }}}

grab :ColumnsRemove do |s| # {{{
  remove_column
  s.data = "%s%d" % [ s.icon, s.cur_cols.size ]
  tile
end # }}}

(1..9).each do |i| # {{{
  grab ("ColumnsMoveTo%d" % [ i ]).to_sym do |s, c|
    move_to_column(c, i)
    s.data = "%s%d" % [ s.icon, s.cur_cols.size ]
    tile
  end
end # }}}
