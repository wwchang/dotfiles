# build up
                                                  /-- encrypt : gpg.
                                                 /    (after write email,
                                                /     press "p" to
                                               /     show up encrypt/sign/clear menu)
                                              /-- aliases.muttrc & abook & lbdb (A, C-a)
                                             /-- Send : sendmail/msmtp (m)
                                            /       C-t -- address/query complete
                                            /   `-  m --> compose a new message.
                                            /       r --> reply to sender
                                            /       g -- reply to allrecipients
                                            /       L --> replay to mailing list
                                            /       f --> forward message
                                            /       b --> bounce(remail) message
                                            /   Esc k --> mail a PGP key to someone
                         bogofilter        / -- get help: "?" or "F1"
    getmail -> procmail ----------> INBOX -> Read.
                                           |    `- bogofilter for spam/ham (S/H)
                                           |    `- urlview & mailcap (C-b)
                                           |      `- hooks & macros
                                           |      `- theme, format, and looks.
                                           |      `- key binds.
                                           |      `- score
                                           |      `- filter
                                           |      `- sidebar (C-n/p)
                                           |      `- multiple accounts.
                                           |      `- signature
                                           |      `- SMTP, POP3, IMAP ...
                                           |      `- ",f" to execute getmail.sh script.
                                           \__ View:
                                           |    - thread mode:
                                           |        - <Esc>v/V collapse (all) thread
                                           \__ Search :
                                           |    - Mairix: (,f)
                                           |    - Mu: <F8> search, <F7> result
                                           \__ Notify :
                                           |
                                            \__ Write : Vim
                                            \__ attachment : press "p" (on PDF)
                                           |     to choose printer to print. (PDF file)
                                            \- save/move/copy/delete/bounce/attach
                                                \ s/M/C/D(d)/B/A

NOTE:
    1. store password with encrypt instead of plain text.
        `~/.mutt/passwords`


# key binds & macros
`Ctrl-` -- for thread/page/ operations.
`<esc>` -- for subthread/mutt/(reverse) operations.
`,` -- for mutt/external-program/

`,k` -- show the keyboard key code.
<Esc-k> -- mail a PGP public key to someone.
<C-k> -- extra public key from message, and add them into your public key ring.
R -- re-call postponed mail.
a -- add sender into mutt aliases. (alias)
A -- add send to abook (abook)
<C-a> -- launch abook (abook)
<,f> -- fetch new messages (getmail)
<,s> -- search mail with mairix (mairix)
y -- show mailboxes list (mutt)
c -- show mailboxes list (mutt)
<C-v> -- virify a message signature (gpg)
v -- collapse thread
V -- collapse all threads
gi -- go to INBOX (mutt)
gd -- go to Draft (mutt)
<Space> -- next page
<Tab> -- next new then unread
<BackTab> -- previous new then unread
## address
### query
<Q> -- query external program
<C-t> -- complete when input address in new composed mail.
<C-i> -- open mailboxes list, and jump(search) to Stack Exchange folder to access sub-mailboxes.

default keys and functions (macros) can reference here:
http://www.mutt.org/doc/devel/manual.html#functions

# add at same time ( sync )

`/usr/share/mutt/example/`

If you want to add one folder in mails/
you have to add this folder in

**modify items**

    ~/Mails/
    procmail/procmailrc
    mailboxes.muttrc
    mairixrc
    aliases.muttrc
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
