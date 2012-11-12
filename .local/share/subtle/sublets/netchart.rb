# Netchart sublet file
# Created with sur-0.1.129
class Chart < Subtlext::Icon # {{{

  ## initialize {{{
  # Initialize chart
  # @param [String]  dev     Device name
  # @param [Fixnum]  width   Chart width
  # @param [Fixnum]  height  Chart height
  ##

  def initialize(dev, rx, tx, width = 50, height = 10)
    super(width, height, true)

    @dev     = dev
    @limit   = 1000
    @last    = 0

    @data_rx = []
    @data_tx = []

    @last_rx = 0
    @last_tx = 0

    clear
  end # }}}

  ## update {{{
  # Update data
  ##

  def update
    time   = Time.now.to_i
    delta  = time - @last
    @last = time

    # Fetch data
    cur_rx = IO.readlines("/sys/class/net/#{@dev}/statistics/rx_bytes").first.to_i
    cur_tx = IO.readlines("/sys/class/net/#{@dev}/statistics/tx_bytes").first.to_i

    # Get rx/tx per second in kb
    rx = ((cur_rx - @last_rx) / delta / 1024.0).ceil
    tx = ((cur_tx - @last_tx) / delta / 1024.0).ceil

    # Store values
    @last_rx = cur_rx
    @last_tx = cur_tx

    # Update arrays
    append_or_shift(@data_rx, rx * 100 / @limit)
    append_or_shift(@data_tx, tx * 100 / @limit)
  end # }}}

  ## render {{{
  # Render chart
  # @param  [Subtlext::Color]  rx  Received data color
  # @param  [Subtlext::Color]  tx  Transmitted data color
  # @param  [Subtlext::Color]  bg  Background color
  ##

  def render(rx, tx, bg)
    clear
    draw_rect(0, 0, @width, @height, true, bg)
    draw_bar(@data_rx, rx, bg)
    draw_bar(@data_tx, tx, bg)
  end # }}}

  private

  def draw_bar(ary, fg, bg) # {{{
    i = 0

    ((@width - (ary.size * 2))..@width).step(2) do |x|
      if(i < ary.size)
        draw_point(x, @height - ary[i], fg, bg)
        draw_point(x + 1, @height - ary[i], fg, bg)
      end

      i += 1
    end
  end # }}}

  def append_or_shift(ary, value) # {{{
    if(value.is_a?(Fixnum))
      norm = (value * @height) / 100 # Normalize size

      # Add data and shift last
      ary.push(0 == norm ? 1 : norm)
      ary.shift if(@width / 2 < ary.size)
    end
  end # }}}
end # }}}

configure :netchart do |s| # {{{
  colors = Subtlext::Subtle.colors

  # Config
  s.interval = s.config[:interval] || 30
  s.title    = s.config[:title].nil? ? "" : "%s " % [ s.config[:title] ]
  s.colors   = {
    :rx    => Subtlext::Color.new(s.config[:rx_color] || colors[:focus_fg]),
    :tx    => Subtlext::Color.new(s.config[:tx_color] || colors[:views_fg]),
    :panel => Subtlext::Color.new(s.config[:bg_color] || colors[:panel_top])
  }

  # Icons
  s.icons = {
    :rx => Subtlext::Icon.new("rx.xbm"),
    :tx => Subtlext::Icon.new("tx.xbm")
  }

  # Chart
  s.chart = Chart.new(
    s.config[:device] || "eth0",
    s.config[:width] || 50, s.config[:height] || 10
  )
end # }}}

on :run do |s| # {{{
  s.chart.update
  s.chart.render(s.colors[:rx], s.colors[:tx], s.colors[:panel])

  self.data = "%s%s%s%s%s%s" % [
    s.title, s.colors[:rx], s.icons[:rx], s.chart,
    s.colors[:tx], s.icons[:tx]
  ]
end # }}}
