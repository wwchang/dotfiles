# Maildir sublet file
# Created with sur-0.2
configure :maildir do |s|
  s.interval = 60

  s.icon = Subtlext::Icon.new( "mail.xbm" )

  s.label = s.config[:label] || 'Mail'
  s.dir = s.config[:dir]
end

on :run do |s|
  count = ( Dir.entries( s.dir ).size - 2 ).to_s

  s.data = s.icon + ' ' + s.label + ' ' + count
end
