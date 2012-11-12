# Ipaddr sublet file
# Created with sur-0.2
# 
# Code to get external IP taken from http://coderrr.wordpress.com/2008/05/28/get-your-local-ip-address/

require 'socket'
require 'open-uri'

def local_ip
  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true

  UDPSocket.open do |s|
    s.connect '64.233.187.99', 1
    s.addr.last
  end
ensure
  Socket.do_not_reverse_lookup = orig
end

def remote_ip
  open('http://checkip.dyndns.org/.') { |f|
    f.read =~ /((\d{1,3}\.){3}\d{1,3})/
    return $1
  }
end


configure :ipaddr do |s|
  s.interval = 60
end

on :run do |s|
  s.data = local_ip
end

on :mouse_over do |s|
  s.data = remote_ip
end

on :mouse_out do |s|
  s.data = local_ip
end
