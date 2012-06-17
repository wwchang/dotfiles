#!/bin/sh
#The executable file named "proctest"
#
# You need a test directory.
TESTDIR=$HOME/test
if [ ! -d ${TESTDIR} ] ; then
  echo "Directory ${TESTDIR} does not exist; creating it"
  mkdir $HOME/test
fi

# mail.msg
echo '
Return-Path: <owner-mutt-users-M17720@mutt.org>
Delivered-To: unknown
Received: from pop.gmail.com (74.125.127.109) by stardiviner with POP3-SSL;
  30 Aug 2011 16:15:25 -0000
Delivered-To: numbchild@gmail.com
Received: by 10.52.160.198 with SMTP id xm6cs214510vdb;
        Tue, 30 Aug 2011 09:07:13 -0700 (PDT)
Received: by 10.227.60.79 with SMTP id o15mr5176222wbh.114.1314720431434;
        Tue, 30 Aug 2011 09:07:11 -0700 (PDT)
Received: from gbnet.net (shtjevan.gbnet.net [194.70.142.36])
        by mx.google.com with ESMTPS id fn2si13775409wbb.14.2011.08.30.09.07.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 09:07:11 -0700 (PDT)
Received-SPF: neutral (google.com: 194.70.142.36 is neither permitted nor denied by best guess record for domain of owner-mutt-users-M17720@mutt.org) client-ip=194.70.142.36;
Authentication-Results: mx.google.com; spf=neutral (google.com: 194.70.142.36 is neither permitted nor denied by best guess record for domain of owner-mutt-users-M17720@mutt.org) smtp.mail=owner-mutt-users-M17720@mutt.org
Received: (qmail 13241 invoked by uid 611); 30 Aug 2011 16:05:29 -0000
Received: (qmail 13152 invoked from network); 30 Aug 2011 15:54:10 -0000
Received: from dm.gbnet.net (194.70.142.30)
  by shtjevan.gbnet.net with ESMTPS (RC4-SHA encrypted); 30 Aug 2011 15:54:10 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjYAADsHXU5K0ATCmGdsb2JhbABClFKDYUSPJhQBAQEBAQgJDQcUJYFAAQEEATpECwsYLhRch3K5doVtYASkRQ
X-IronPort-AV: E=Sophos;i="4.68,302,1312153200";
   d="scan208";a="35588649"
Received: from mout.perfora.net ([74.208.4.194])
  by dm.gbnet.net with ESMTP; 30 Aug 2011 16:54:09 +0100
Received: from 144.0.168.192.in-addr.arpa (pool-108-45-85-39.washdc.fios.verizon.net [108.45.85.39])
	by mrelay.perfora.net (node=mrus0) with ESMTP (Nemesis)
	id 0M1Uxt-1RDlYs1OtV-00t8th; Tue, 30 Aug 2011 11:54:08 -0400
Date: Tue, 30 Aug 2011 11:54:06 -0400
From: Tom Baker <tbaker@tbaker.de>
To: mutt-users@mutt.org
Subject: Re: Mutt 1.5.21/Mac - no "N" indicator for mbox folders with new mail
Message-ID: <20110830155406.GB59331@julius>
References: <15f27653a72fe0d08e96601d822543c5b7dabfc6@stardiviner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f27653a72fe0d08e96601d822543c5b7dabfc6@mutt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:BcCvbbi0uLVCPMC7QRhJ1oT0IaUW3RDEWY7diL+eEYc
 1huPCYH32fpT15Vy5JFkJMpls6Yf7pDJKCUDLQ09XUYc/oxoxF
 GRNJBJb0U1g8ghcNJBqF53hOnZXtxQ/NK4QEfigsk7XWTR1nih
 R3Iiexzvdl2IyWC2Xdj8GBPBIH/8Gjclor4Pz/BCbgAXtVEuKS
 mXH140z1utSGZGF/4C3U1S6PcRQ1qIlA4R8ZS/AhgF4IvB95gS
 kaBHJeVJF9dJuBfCzvZp8vTafkFjx9Iv6khy/rj022HQbMVAkX
 OO8DG42I7QaRyfh8gzO+G79QRpxg+tkrRu5YFMmhmsbLewXP/e
 IZLIAQja6Xr/DWsxOnnPA9I87ugra2q9zcFiBzzBP
List-Post: <mailto:mutt-users@mutt.org>
List-Unsubscribe: send mail to majordomo@mutt.org, body only "unsubscribe mutt-users"
Precedence: bulk
Sender: owner-mutt-users@mutt.org

On Tue, Aug 30, 2011 at 02:51:15PM +0200, Christian Ebert wrote:
> * Thomas Baker on Monday, August 29, 2011 at 13:54:31 -0400
> > In my experience, Mutt works great on Mac but for one signfiicant
> > flaw: in the Mailboxes view, it does not properly mark mailboxes with
> > new mail with an "N" indicator -- even though it does show individual
> > messages correctly as new in the Message Index view.
>
> Are using mbox format mailboxes? Then try:
>
> set check_mbox_size=yes

That works! :-)

> See: man 5 muttrc

The man page says:

    This variable is unset by default and should only be enabled when new mail
    detection for these folder types is unreliable or doesnt work.

...which makes me wonder whether this is a workaround that uses a method
for new mail detection that is less reliable than the default method, whatever
that is, but it does appear to solve the problem.

Many thanks!
Tom

-- 
Tom Baker <tom@tombaker.org>
' > ${TESTDIR}/mail.msg

# proctest.rc
echo '
SHELL=/bin/sh
TESTDIR=${HOME}/test
MAILDIR=${TESTDIR}
LOGFILE=${TESTDIR}/Proctest.log
LOG="--- Logging for ${LOGNAME}, "

#Troubleshooting:
VERBOSE=yes
LOGABSTRACT=all

#Lets test stripping lines from the email messages header
# :0 fwh
# | egrep -vi "(^Content-|^MIME-Version:.)"

#If it is from myself, store the email message
# :0:
# * $ ^From:.*${LOGNAME}
# ${TESTDIR}/Proctest.mail

#Otherwise, discard the email message
# :0
# /dev/null

:0 c
* ^References: .*@stardiviner
{
    # get the subject into a variable
    # use procmails MATCH feature.
    GETTEXT="[ ]*\/[^ ].*"
    :0
    {
        * ^Subject:
        * $ ^Subject:${GETTEXT}
        SHORT_BODY=`head -1`
    }
    :0
    | $HOME/bin/notify.sh "$MATCH updated" "$SHORT_BODY"
}
' > ${TESTDIR}/proctest.rc

#
#Feed an email message to procmail. Apply proctest.rc recipes file.
#First prepare a mail.msg email file which you wish to use for the
#testing.
procmail ${TESTDIR}/proctest.rc < ${TESTDIR}/mail.msg
#
#Show the results.
less ${TESTDIR}/Proctest.log
clear
less ${TESTDIR}/Proctest.mail
#
#Clean up.
rm -i ${TESTDIR}/Proctest.log
rm -i ${TESTDIR}/Proctest.mail

