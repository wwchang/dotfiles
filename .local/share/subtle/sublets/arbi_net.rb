# Arbi_net sublet file
# Created with sur-0.2

require 'subtype'

configure :arbi_net do |s|
  s.interval = 2
  s.interfaces = s.config[:interfaces] || []
  s.icons = {
    up:     Subtlext::Icon.new('net_up.xbm'),
    down:   Subtlext::Icon.new('net_down.xbm'),
    wired:  Subtlext::Icon.new('wired.xbm'),
    wifi:   Subtlext::Icon.new('wifi.xbm')
  }

  Arbi.connect
end

helper do
  def refresh
    Arbi.get('net').data.select {|x|
      self.interfaces.include?(x['name']) and x['state']
    }.map {|x|
      type = (x['quality'] or x['essid']) ? :wifi : :wired
      "#{self.icons[type].to_s}#{x['name']} #{self.icons[:up]}#{x['up']}#{self.icons[:down]}#{x['down']}" +
        ((self.type.long? and type == :wifi) ? " #{x['quality']}#{':' if x['essid'] and x['quality']}#{x['essid']}" : '')
    }.join(' ')
  rescue Exception => e
    STDERR.puts(e.to_s + "\n" + e.backtrace.join("\n"))
    "ERROR"
  end
end

use SubType::Expand
