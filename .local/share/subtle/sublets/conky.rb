# Conky sublet file
# Created with sur-0.2
configure :conky do |s|
  s.data = "conky"
end

on :data do |s, data|
  # Parse conky format
  parsed = data.gsub(/\^(fg|i)\(([^)]*)?\)/) do |m|
    case $~[1]
      when "fg"
        unless($~[2].nil? and $~[2].empty?)
          Subtlext::Color.new($~[2])
        end
      when "i"
        Subtlext::Icon.new($~[2]) unless($~[2].nil?)
    end
  end

  s.data = parsed
end
