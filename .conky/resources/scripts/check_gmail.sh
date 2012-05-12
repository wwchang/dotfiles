#!/bin/bash

gmail_login="numbchild" 
gmail_password="Ghostdark324"

done="$(wget --secure-protocol=TLSv1 --timeout=3 -t 1 -q -O - \
https://${gmail_login}:${gmail_password}@mail.google.com/mail/feed/atom \
--no-check-certificate | grep 'fullcount' \
| sed -e 's/.*<fullcount>//;s/<\/fullcount>.*//' 2>/dev/null)"

if [ -z "$done" ]; then
echo "off"
else
echo "$done"
fi
