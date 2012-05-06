#!/usr/bin/python
#
# dBus Gnome notificator
# reads the mail from stdin and sends a dBus message
# for use with evolution or procmail
# From: http://oz4.org/
# License: public domain, do whatever you like - 
#          it would be nice if you could link back

# Modified by gfrog@gfrog.net
# Date: 2011-10-09
# Change pynotify to notify-send

import email
import sys
import os
import re

##
## C O N F I G
##
ms=10000  # time to display the alert, in ms
icon="mail-unread" # full path to icon OR gnome icon stock name, try 'email'
maxbody = 200 # max 200 chars in body
maxsubject = 200 # max 50 chars in subject
maxsender = 50 # max 50 chars for sender name
log_file = "/tmp/mail-notify.log" # log file for debug.
debug = False
##
##


if debug is True:
    log = open(log_file, 'a', 0)
else:
    log = None

#pynotify will fail if there's an unknown tag...
def striptags(string):
    string = string.replace('&', '&amp;')
    string = string.replace('<', '&lt;')
    string = string.replace('>', '&gt;')
    string = string.replace('"', '&quot;')
    return string

# log debug message, 'print' can't work with procmail.
def debug_log(string):
    if debug is True and log is not None:
        log.write("%s\n" % string)
    return

s = sys.stdin.read()
debug_log(s)
msg = email.message_from_string(s)

if msg.is_multipart():
    for part in msg.walk():
        if part.get_content_type()=="text/plain":
            body = r"^^NEWLINE^^".join(part.get_payload(None,True).splitlines())
else:
    body = r"^^NEWLINE^^".join(msg.get_payload(None, True).splitlines())
body = striptags(body)
# kdialog works well with <br>
body = re.sub(r"\^\^NEWLINE\^\^", "<br />", body)

if len(body) > maxbody:
    body = body[:maxbody]

debug_log(body)

subject = email.Header.decode_header(" ".join(msg["subject"].splitlines()))
subject = email.Header.make_header(subject)
subject = striptags(unicode(subject))
if len(subject)>maxsubject:
    subject = subject[:maxsubject]

debug_log(subject)

sender_name, sender_addr = email.Utils.parseaddr(msg["from"])
sender_name = email.Header.decode_header(sender_name)

sender_name = email.Header.make_header(sender_name)
sender_name = striptags(unicode(sender_name))

sender = "%s <%s>" % (sender_name, sender_addr)
if len(sender) > maxsender:
    sender = sender[:maxsender]

debug_log(sender)

title = "Mail from: " + sender
body = "<b>" + subject +"</b>\n<small>" + body + "</small>"

if os.system("which notify-send") == 0:
    # Yep, it's for Gnome!
    os.system("`which notify-send` -t %d '%s' '%s'" % \
              (ms, title, body))
else:
    debug_log("there was a problem with notify-send\n")

if log is not None:
    log.close()
