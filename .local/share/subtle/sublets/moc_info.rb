configure :moc_info do |s|
    s.icons = {}
    %w{head body foot}.each {|x|
        %w{full empty}.each {|y|
            s.icons["#{x}_#{y}"] = Subtlext::Icon.new("timeline_#{x}_#{y}.xbm")
        }
    }
    s.icons[:note] = Subtlext::Icon.new("note.xbm")
    s.interval = 2
    s.bar_len = s.config[:bar_len] || 10
end

on :run do |s|
    begin
        infos = {}
        `mocp -i`.split(/[\r\n]+/).each {|l|
            p = l.split(/:/, 2)
            infos[p[0].downcase.to_sym] = p[1]
        }

        current = (s.bar_len.to_f / infos[:totalsec].to_i * infos[:currentsec].to_i).ceil
        left = s.bar_len - current
        
        data = s.icons[:note] + " " + (infos[:title].empty? ? infos[:file] : infos[:title]) + " "
        data += s.icons["head_#{current > 0 ? 'full' : 'empty'}"].to_s
        (2..current).each {
            data += s.icons['body_full'].to_s
        }
        (2..left).each {
            data += s.icons['body_empty'].to_s
        }
        data += s.icons["foot_#{current == s.bar_len ? 'full' : 'empty'}"].to_s
        s.data = data
    rescue Exception => e
        $stderr.putst e.to_s
        $stderr.puts e.backtrace
        s.data = "ERROR"
    end
end
