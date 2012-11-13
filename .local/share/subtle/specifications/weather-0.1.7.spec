# -*- encoding: utf-8 -*-
# Weather specification file
# Created with sur-0.2
Sur::Specification.new do |s|
    s.name        = 'Weather'
    s.authors     = [ 'Andrew Fricke' ]
    s.date        = 'Mon Feb 07 22:53 EST 2011'
    s.contact     = 'Zonzero5@gmail.com'
    s.description = 'Simple configurable weather sublet.'
    s.notes       = <<NOTES
Simple configurable weather sublet that pulls from Google's weather API.

('sur config weather' for available options)
NOTES
    s.config      = [
        {
            :name        => 'interval',
            :type        => 'integer',
            :def_value   => '7200',
            :description => 'Update interval in seconds.'
        },
        {
            :name        => 'locale',
            :type        => 'string',
            :def_value   => 'en',
            :description => 'Desired locale for units and names. (en, de, etc.)'
        },
        {
            :name        => 'units',
            :type        => 'string',
            :def_value   => 'f',
            :description => 'Desired temperature unit. (c|f)'
        },
        {
            :name        => 'location',
            :type        => 'string',
            :def_value   => 'New-York',
            :description => 'Location, either zip code or city name.'
        },
        {
            :name        => 'direction',
            :def_value   => 'right',
            :type        => 'string',
            :description => 'Text direction. (left|right)'
        },
        {
            :name        => 'forecast_length',
            :type        => 'integer',
            :def_value   => '3',
            :description => 'Forecast length. (0-4)'
        },
        {
            :name        => 'hide_current',
            :type        => 'boolean',
            :def_value   => 'false',
            :description => 'Hide the current temperature.'
        },
        {
            :name        => 'current_label',
            :type        => 'string',
            :def_value   => 'Now',
            :description => 'Current temperature label.'
        },
        {
            :name        => 'temp_suffix',
            :type        => 'string',
            :def_value   => '\'\'',
            :description => 'Temperature suffix.'
        },
        {
            :name        => 'sep',
            :type        => 'string',
            :def_value   => '/',
            :description => 'Separator between days.'
        },
        {
            :name        => 'day_color',
            :type        => 'string',
            :def_value   => '#757575',
            :description => 'Day color.'
        },
        {
            :name        => 'temp_color',
            :type        => 'string',
            :def_value   => '#B8B8B8',
            :description => 'Temperature color.'
        },
        {
            :name        => 'sep_color',
            :type        => 'string',
            :def_value   => '#FECF35',
            :description => 'Seperator color.'
        }
    ]
    s.version     = '0.1.7'
    s.tags        = [ 'Config', 'Weather' ]
    s.files       = [ 'weather.rb' ]
end
