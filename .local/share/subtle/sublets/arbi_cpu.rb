# Arbi_cpu sublet file
# Created with sur-0.2
require 'arbi'

configure :arbi_cpu do |s|
  s.interval = 2
  s.icon = Subtlext::Icon.new('cpu.xbm')
  Arbi.connect
end

on :run do |s|
  begin
    s.data = s.icon.to_s + Arbi.get('cpu').data.select {|x|
      x['name'] != 'AVERAGE'
    }.map {|x|
      x['percent']
    }.join(" ")
  rescue Exception => e
    s.data = ''
    STDERR.puts e.to_s + "\n" + e.backtrace.join("\n")
  end
end
