# Arbi_temperature sublet file
# Created with sur-0.2

require 'arbi'

configure :arbi_temperature do |s|
  s.interval  = 2
  s.icon      = Subtlext::Icon.new('therm.xbm')
  Arbi.connect
end

on :run do |s|
  begin
    s.data = s.icon.to_s + Arbi.get('thermal').data.map {|x| x['temperature'] }.join(' ')
  rescue Exception => e
    s.data = ''
    STDERR.puts(e.to_s + "\n" + e.backtrace.join("\n"))
  end
end
