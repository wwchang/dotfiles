# Loadavg sublet file
# Created with sur-0.1
configure :loadavg do |s|
  s.interval = 30
end

on :run do |s|
  file = ""

  begin
    File.open("/proc/loadavg", "r") do |f|
      file = f.read
    end

    s.data = file.slice(0, 14)
  rescue => err # Sanitize to prevent unloading
    s.data = "subtle"
    p err
  end
end
