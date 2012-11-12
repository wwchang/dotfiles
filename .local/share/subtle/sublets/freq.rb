# Freq sublet file
# Created with sur-0.1       
configure :freq do |s|
  s.interval = 120
end

on :run do |s|
  begin
    data = ""
    file = IO.readlines("/proc/cpuinfo").join

    file.scan(/cpu MHz\s+:\s+([0-9.]+)/) do |freq| 
      data << freq.first.to_i.to_s + " Mhz "
    end

    s.data = data.chop
  rescue => err # Sanitize to prevent unloading
    s.data = "subtle"
    p err
  end  
end
