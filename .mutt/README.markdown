# build up
                                               / encrypt : gpg.
                                                - aliases.muttrc & abook
                                             - Send : sendmail
                         bogofilter         /
    getmail -> procmail ----------> INBOX -> Read.
                                           |    `- bogofilter for spam
                                           |    `- urlview & mailcap
                                           |      `- hooks & macros
                                           |      `- theme, format, and looks.
                                           |      `- key binds.
                                           |      `- score
                                           |      `- filter
                                           |      `- sidebar
                                           |      `- multiple accounts.
                                           |      `- signature
                                           |      `- SMTP, POP3, IMAP ...
                                           |      `-
                                           `--- Search : Mairix,
                                           `--- Notify :
                                           |
                                            \__ Write : Vim

NOTE:
    1. store password with encrypt instead of plain text.
        `~/.mutt/passwords`


# key binds & macros
S -- spam (bogofilter)
H -- non-spam (bogofilter)
d -- delete
m -- write mail
r -- reply mail
L -- reply to mailing list address
CC:  -- Group replies
f -- forward message.
b -- bounce (remail) message.
E-k -- mail a PGP public key to someone.
^K -- extra public key from message, and add them into your public key ring.
## compose mail
    Table 2.9. Most commonly used Compose Menu Bindings
    Key 	Function 	            Description
    a 	    <attach-file> 	        attach a file
    A 	    <attach-message> 	    attach message(s) to the message
    E-k 	<attach-key> 	        attach a PGP public key
    d 	    <edit-description> 	    edit description on attachment
    D 	    <detach-file> 	        detach a file
    t 	    <edit-to> 	            edit the To field
    E-f 	<edit-from> 	        edit the From field
    r 	    <edit-reply-to> 	    edit the Reply-To field
    c 	    <edit-cc> 	            edit the Cc field
    b 	    <edit-bcc> 	            edit the Bcc field
    y 	    <send-message> 	        send the message
    s 	    <edit-subject> 	        edit the Subject
    S 	    <smime-menu> 	        select S/MIME options
    f 	    <edit-fcc> 	            specify an ``Fcc'' mailbox
    p 	    <pgp-menu> 	            select PGP options
    P 	    <postpone-message> 	    postpone this message until later
    q 	    <quit> 	quit (abort)    sending the message
    w 	    <write-fcc> 	        write the message to a folder
    i 	    <ispell> 	            check spelling (if available on your system)
    C-F 	<forget-passphrase> 	wipe passphrase(s) from memory
R -- re-call postponed mail.
A -- add send to abook (abook)
C-a -- launch abook (abook)
,f -- search mail with mairix (mairix)
$ -- sync mailboxes
C-n -- next mailbox in sidebar (sidebar)
C-p -- previous mailbox in sidebar (sidebar)
y -- show mailboxes list.
c -- show mailboxes list (mutt)
C-b -- browse URLs (urlview)
F8 -- search mail with mu (mu)
F9 -- show found mails (mu)
C-v -- virify a message signature (gpg)
gi -- go to INBOX (mutt)
gd -- go to Draft (mutt)
tab -- next unread/new
space -- next page

# add at same time ( sync )

`/usr/share/mutt/example/`

If you want to add one folder in mails/
you have to add this folder in

**modify items**

    ~/Mails/
    procmail/procmailrc
    mailboxes.muttrc
    mairixrc
    subscriptions.muttrc
    scores.muttrc
    save-hooks.muttrc
    fcc-hooks.muttrc
    fcc-save-hooks.muttrc
    mbox-hooks.muttrc
    gpg.muttrc (GPG key ID)
    signature (GPG key ID, website)
    getmail/getmailrc (password)

## INSTALL
**some other config files*
    `$ ln -s ~/.mutt/urlview ~/.urlview`
    `$ mkdir ~/.mairix`
