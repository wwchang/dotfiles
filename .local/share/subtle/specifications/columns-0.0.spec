# -*- encoding: utf-8 -*-
# Columns specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Columns"
  s.version     = "0.0"
  s.tags        = [ "Layout", "Tiling", "Automatic", "Icon", "Config", "Grab" ]
  s.files       = [ "columns.rb" ]
  s.icons       = [ "icons/columns.xbm" ]

  # Sublet description
  s.description = "Sublet for a column based layout"
  s.notes       = <<NOTES
This sublet adds another way of automatic tiling to subtle. It creates columns
and arranges clients inside of each column.

Columns can be created and clients moved into them via grabs. Empty columns
will be removed automatically, when the last client is either killed or moved
to another column.
NOTES

  # Sublet authors
  s.authors     = [ "unexist" ]
  s.contact     = "unexist@dorfelite.net"
  s.date        = "Tue Feb 10 22:10 CET 2011"

  # Sublet config
  s.config = [
    {
      :name        => "border",
      :type        => "integer",
      :description => "Window border",
      :def_value   => "2"
    }
  ]

  # Sublet grabs
  s.grabs = {
    :ColumnsAdd    => "Append new column",
    :ColumnsRemove => "Remove last column"
  }.merge(Hash[*(1..9).map { |i|
    [ "ColumnMoveTo#{i}".to_sym, "Move client to #{i}. column" ] }.flatten
  ])

  # Sublet requirements
  # s.required_version = "0.9.2127"
  # s.add_dependency("subtle", "~> 0.1.2")
end
