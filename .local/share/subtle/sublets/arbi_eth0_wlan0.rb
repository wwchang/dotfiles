# Arbi_eth0_wlan0 sublet file
# Created with sur-0.2.165

require 'arbi'

configure :arbi_eth0_wlan0 do |s|
    s.interval = 4
    s.icons = {
        :eth0   => Subtlext::Icon.new('wire.xbm'),
        :wlan0  => Subtlext::Icon.new('wifi.xbm'),
        :up     => Subtlext::Icon.new('up.xbm'),
        :down   => Subtlext::Icon.new('down.xbm')
    }
end

on :run do |s|
    class ::Float
        def s
            ('%.1f' % self).gsub(/\.0$/, '')
        end
    end

    begin
        net, data = Arbi.get("net"), ""

        if net['eth0'][:state]
            data = s.icons[:eth0] + " " + s.icons[:up] + " #{net['eth0'][:up].s} " +
                s.icons[:down] + " #{net['eth0'][:up].s} "
        end rescue nil

        if net['wlan0'][:state]
            data = s.icons[:wlan0] + " #{net['wlan0'][:essid]}:#{net['wlan0'][:quality]} " +
                s.icons[:up] + " #{net['wlan0'][:up].s} " + s.icons[:down] + " #{net['wlan0'][:down].s}"
        end rescue nil

        s.data = data.empty? ? "No network" : data.strip
    rescue Exception => e
        s.data = "No network"
        p e
    end
end
