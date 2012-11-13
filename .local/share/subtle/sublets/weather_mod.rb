# Weather sublet file
# Created with sur-0.2

require 'rexml/document'
require 'open-uri'
require 'iconv'

configure :weather_mod do |s|
    s.interval = s.config[:interval] || 7200
    
    s.locale = s.config[:locale] || 'en'
    s.units = s.config[:units] == 'c' ? { :unit => 'c', :cmp => 'SI' } : { :unit => 'f', :cmp => 'US' }
    
    s.location = s.config[:location] || 'New-York'
    s.url = 'http://www.google.com/ig/api?weather=' + s.location + '&hl=' + s.locale

    s.direction = s.config[:direction] || 'right'
    s.forecast_length = s.config[:forecast_length] || 3
    s.hide_current = s.config[:hide_current] ? 1 : 0

    s.current_label = s.config[:current_label] || 'Now'
    s.temp_suffix = s.config[:temp_suffix] || ''
    s.sep = ' ' + (s.config[:sep] || '/') + ' '
    s.condition = ''
    s.icon = Subtlext::Icon.new("weather_cloud.xbm")	
    
    s.day_color = Subtlext::Color.new(s.config[:day_color] || '#757575')
    s.temp_color = Subtlext::Color.new(s.config[:temp_color] || '#B8B8B8')
    s.sep_color = Subtlext::Color.new(s.config[:sep_color] || '#FECF35')
    
    s.forecast = [ ]
    
    s.error = ''
end

helper do
    def convertUnits(n, u)
        if u == 'c'
            return ((5.0/9) * (n - 32)).round
        else
            return ((9.0/5) * (n + 32)).round
        end
    end
    
    def getWeather
        self.forecast.clear
        
        begin
            content = Iconv.iconv('UTF-8', 'ISO-8859-1', open(self.url, {:read_timeout => 1}).read)[0]
        rescue
            return self.error = 'Connection error.'
        end
        
        xml = REXML::Document.new(content)
        
        return self.error = 'Invalid location.' if xml.root.elements['//problem_cause']
        
        xml.elements.each('//forecast_conditions') do |f|
            high = f.elements['high'].attributes['data'].to_i
            low = f.elements['low'].attributes['data'].to_i
            self.condition = (File.basename f.elements['icon'].attributes['data'].to_s).sub(/.gif/, '')

            self.forecast << {
                :day   => f.elements['day_of_week'].attributes['data'],
                :temp  => ((high + low) / 2).to_s
            }

        end
        
        if self.units[:cmp] != xml.root.elements['//forecast_information/unit_system'].attributes['data']
            self.forecast.each { |f| f[:temp] = convertUnits(f[:temp].to_i, self.units[:unit]).to_s }
        end
        
        self.forecast.slice!(self.forecast_length - 4, 4 - self.forecast_length)
        
        if self.hide_current.zero?
            self.forecast.unshift(
                {
                    :day  => self.current_label,
                    :temp => xml.root.elements['//current_conditions/temp_' + self.units[:unit]].attributes['data']
                }
            )
            self.condition = (File.basename xml.root.elements['//current_conditions/icon'].attributes['data'].to_s).sub(/.gif/, '')
        end
        
        if self.direction ==  'left'
            self.forecast.reverse!
        end
    end

    def getIcon
        if ["cloudy", "mostly_cloudy", "partly_cloudy"].include?(self.condition)
            icon = "weather_cloud.xbm"
        elsif ["rain", "chance_of_rain"].include?(self.condition)
            icon = "weather_rain.xbm"
        elsif ["chance_of_storm", "thunderstorm"].include?(self.condition)
            icon = "weather_storm.xbm"
        elsif ["sunny", "mostly_sunny"].include?(self.condition)
            icon = "weather_sun.xbm"
        elsif ["mist"].include?(self.condition)
            icon = "weather_mist.xbm"
        else
            icon = "weather_unknown.xbm"
        end
        self.icon = Subtlext::Icon.new(icon)
    end
end

on :run do |s|
    getWeather
    getIcon
   
    return s.data = s.error if !s.error.empty?
    
    weather_string = ''
    
    s.forecast.each do |f|      
        weather_string << s.day_color + f[:day] + ' ' + s.temp_color + f[:temp] + s.temp_suffix
        
        if f != s.forecast.last
            weather_string << s.sep_color + s.sep
        end
    end
  
    s.data = s.icon + weather_string
end
