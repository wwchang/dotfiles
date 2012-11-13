# Update sublet file
# Created with sur-0.1
configure :uptime do |s|
  s.interval = 60

  # Icon
  s.icon = Subtlext::Icon.new("off.xbm")
end

on :run do |s|
  file = ""

  begin
    uptime = IO.readlines("/proc/uptime").join.split(" ").map(&:to_i)

    # Calculate parts
    time     = uptime[0].round
    seconds  = time % 60
    time    /= 60
    minutes  = time % 60
    time    /= 60
    hours    = time % 24
    time    /= 24
    days     = time

    # Output
    if(0 < days)
      s.data = "%s%d days,  %d:%02d" % [ s.icon, days, hours, minutes ]
    elsif(0 < hours)
      s.data = "%s%d:%02d" % [ s.icon, hours, minutes ]
    else
      s.data = "%s%d minutes" % [ s.icon, minutes ]
    end
  rescue => err # Sanitize to prevent unloading
    s.data = "subtle"
    p err
  end
end
