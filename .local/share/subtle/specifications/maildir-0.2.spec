# -*- encoding: utf-8 -*-
# Maildir specification file
# Created with sur-0.2
Sur::Specification.new do |s|
  # Sublet information
  s.name        = "Maildir"
  s.version     = "0.2"
  s.tags        = [ "Mail", "Icon" ]
  s.files       = [ "maildir.rb" ]
  s.icons       = [ "mail.xbm" ]

  # Sublet description
  s.description = "Display unread mailcount in Maildir"
  s.notes       = <<NOTES
This sublet displays the number of unread mails in a maildir.
NOTES

  # Sublet authors
  s.authors     = [ "crshd" ]
  s.contact     = "crshd@mail.com"
  s.date        = "Mon May 02 13:02 MYT 2011"

  # Sublet config
  s.config = [
    {
      :name        => "dir",
      :type        => "string",
      :description => "Path to mailbox",
      :def_value   => "Default value"
    },
    {
      :name        => "label",
      :type        => "string",
      :description => "Label",
      :def_value   => "Mail"
    }
  ]

  # Sublet grabs
  #s.grabs = {
  #  :MaildirGrab => "Sublet grab"
  #}

  # Sublet requirements
  # s.required_version = "0.9.2127"
  # s.add_dependency("subtle", "~> 0.1.2")
end
