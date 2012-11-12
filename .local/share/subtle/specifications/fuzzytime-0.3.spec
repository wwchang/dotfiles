# -*- encoding: utf-8 -*-
# Fuzzytime specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Fuzzytime"
  s.version     = "0.3"
  s.tags        = [ "Localization" ]
  s.files       = [ "fuzzytime.rb" ]
  s.icons       = [ ]

  # Sublet description
  s.description = "Display time in fuzzy strings"
  s.notes       = <<NOTES
This sublet displays the time in strings that describe the time rather than
displaying the actual time. Instead of something like '15:50' it displays
'ten to four'.

Currently supported locales: en, de, fr and es

If your locale is missing just let me know.
NOTES

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Mon Feb 07 13:03 CET 2011"

  # Sublet config
  s.config      = [
    {
      :name        => "locale",
      :type        => "string",
      :description => "Localization of the text",
      :def_value   => "en"
    }
  ]
end
