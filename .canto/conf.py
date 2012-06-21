# config: http://codezen.org/canto/config/
# advanced config: http://codezen.org/canto/advconfig/

# {{{ examples
# add feeds, password.
#       add("URL", rate=60, keep=100, username="myuser", password="mypass")
#       scripts extensions.
#           wget http://codezen.org/static/slashdotpolls
#           mkdir ~/.canto/scripts/slashdotpolls
#           chmox +x Slashdotpolls
#           add("script:slashdotpolls -external")
#           add("script:myscript -arg1 -arg2 ...")
#       source other files
#           source_opml("/home/chris/feeds.opml")
#           Canto can also source plain lists of URLS, delimited by newlines.
#               source_urls("/home/chris/urls")
#       tweaking defaults
#           default_rate(30)
#           add("url")
#           default_rate(120)
#           add("url")
#       discard policy
#           never_discard("unread")
# }}}

never_discard("unread") # you can specify a tag like "Slashdot"

# source_urls("/home/chris/.canto/urls") # source plain lists of URLs

add("http://codezen.org/canto/feeds/latest", tags=[None, "update", "Canto"]) # Canto update News

default_rate(100)
add("https://github.com/numbchild.private.atom?token=2896ad0673745109bd5b4ed1ab31e21f", tags=[None, "github", "git", "update"]) # my personal feeds

default_rate(300)
# Arch Linux {{{
add("http://www.archlinuxcn.org/feed/", tags=[None, "Arch", "changes"]) # Arch homepage updates
# add("https://wiki.archlinux.org/index.php?title=Special:RecentChanges&feed=atom", tags=[None, "wiki", "Arch", "changes"]) # Arch Linux wiki Recent changes
# }}}

default_rate(500)
# projects release {{{
add("http://groups.google.com/group/vim_announce/feeds", tags=[None, "Vim", "release"]) # Vim announce
add("http://www.ruby-lang.org/en/feeds/news.rss", tags=[None, "Ruby", "lang"]) # Ruby language
add("https://getfirebug.com/wiki/index.php?title=Special:RecentChanges&feed=atom", tags=[None, "firebug", "tool", "software"]) # Firebug extensions
add("http://www.backtrack-linux.org/feed/atom/", tags=[None, "BackTrack", "Linux", "distro", "Crack", "Hack"]) # BackTrack Linux Atom 3
# add("http://www.backtrack-linux.org/feed/", tags=[None, "BackTrack", "Linux", "distro", "Crack", "Hack"]) # BackTrack Linux RSS 2
add("http://awesome.naquadah.org/w/index.php?title=Special:RecentChanges&feed=atom", tags=[None, "Awesome", "WM"]) # Awesome Wiki Updates
add("http://blog.getfirebug.com/feed/", tags=[None, "firebug"]) # Firebug
add("http://sourceforge.net/apps/wordpress/tux2live/feed/", tags=[None, "USB", "system"]) # Tux2live
add("http://feed43.com/vim-scripts.xml", tags=[None, "vim", "script", "plugin"]) # "~Vim scripts update"
add("http://rss.groups.yahoo.com/group/taglist/rss", tags=[None, "vim", "script", "plugin"]) # "~taglist vim plugin"
add("http://blog.golang.org/feeds/posts/default", tags=[None, "Go", "lang"]) # Go lang
add("http://feeds.feedburner.com/dartosphere", tags=[None, "Dart", "lang"]) # Dart lang
add("http://news.dartlang.org/feeds/posts/default", tags=[None, "Dart", "lang"]) # Dart news
#add("http://feeds.feedburner.com/git-ready", tags=[None, "git"]) # "~tig -- git-ready"
#add("http://feeds.feedburner.com/cheatsheets", tags=[None, "tools", "linux"]) # "~cheatsheets"
add("http://definitely-awesome.posterous.com/rss.xml", tags=[None, "Awesome"]) # one Awesome doc blog.
add("http://blog.conky.be/feed/", tags=[None, "update"]) # "~Conky Blog"
add("http://www.weechat.org/feeds/news/", tags=[None, "update"]) # weechat update
add("http://dev.weechat.org/feed/atom", tags=[None, "update"]) # "~weechat dev annonce"
add("http://feeds2.feedburner.com/css3", tags=[None, "CSS3", "CSS", "Web"]) # CSS3 .info
add("http://gitit.net/_feed/", tags=[None, "update", "git", "feature"]) # gitit
add("http://dev.mutt.org/hg/mutt/rss-log", tags=[None, "update"]) # "~Mutt dev"
add("http://www.backtrack-linux.org/feed/", tags=[None, "hack", "BackTrack"]) # BackTrack official blog.
add("http://www.backbox.org/blog/feed", tags=[None, "distro"]) # backbox: ubuntu based hacker distro.
add("http://freecode.com/projects/miredo/releases.atom", tags=[None, "ipv6"]) # Miredo
add("http://rss.gmane.org/gmane.network.onion-routing.announce", tags=[None, "update"]) # "~Tor announce"
# https://blog.torproject.org/crss "~Tor Blog"
add("http://blog.dota2.com/feed/", tags=[None, "Dota", "Dota2", "Game"]) # Dota2 official Blog
# }}}

default_rate(300)
# Blog {{{
add("http://blog.stackoverflow.com/feed/", tags=[None, "StackExchange", "Blog"]) # Stack Exchange Blog
add("http://blog.binux.me/feed/", tags=[None, "hack"]) # Blinux.
add("http://igfw.net/feed", tags=[None, "censorship"]) # iGFW
add("http://instagram-engineering.tumblr.com/rss", tags=[None, "server"]) # Instagram Tech Blog
add("http://blog.csdn.net/pongba/rss/list", tags=[None, "C++", "blog"]) # pngba C++ blog.
add("http://feeds.feedburner.com/codinghorror", tags=[None, "blog"]) # "~Coding Horror"
add("http://feeds.feedburner.com/html5rocks", tags=[None, "blog"]) # "~HTML5 Rocks"
add("http://tomayko.com/feed/", tags=[None, "blog"]) # tomayko Blog
add("http://newartisans.com/feed/", tags=[None, "blog"]) # Lost in Technopolis
add("https://roylez.heroku.com/atom.xml", tags=[None, "blog"]) # @roylez blog.
add("http://luy.li/feed/", tags=[None, "blog"]) # "~Lazy Bones"
add("http://pbrisbin.com/feed", tags=[None, "hack", "blog"]) # "~pbrisbin Blog"
add("http://apt-blog.net/feed", tags=[None, "blog"]) # "~apt-blog Blog cn"
add("http://feeds2.feedburner.com/WebDesignerWall", tags=[None, "web", "program"]) # "~Web Designer Wall"
add("http://feeds2.feedburner.com/stevelosh", tags=[None, "blog"]) # "~stevelosh Blog"
add("http://feeds.feedburner.com/catswhocode", tags=[None, "blog"]) # "~CatsWhoCode.com"
add("http://program-think.blogspot.com/feeds/posts/default", tags=[None, "blog"]) # "~Program Think"
add("http://feeds.feedburner.com/ruanyifeng", tags=[None, "blog"]) # "~RuanYiFeng Blog"
add("http://feed.tmdsb.com/", tags=[None, "blog"]) # "~Goo Blog"
add("http://www.matrix67.com/blog/feed/atom", tags=[None, "blog"]) # "~Matric Math"
add("http://coolshell.cn/?feed=rss2", tags=[None, "blog"]) # "~Cool shell"
add("http://feed.williamlong.info/", tags=[None, "blog"]) # "~Moonlight Blog"
add("http://www.eaglefantasy.com/feed", tags=[None, "blog"]) # "~Physics Universe"
add("http://cdwillis.wordpress.com/feed/", tags=[None, "blog"]) #  "~cdwillis"
add("http://feeds.feedburner.com/softwaretechandmore", tags=[None, "blog"]) # "~SKORKS Blog"
add("http://blog.nguyenvq.com/feed/", tags=[None, "blog"]) # "~Super Nerdy Cool"
add("http://feed.feedsky.com/taoofsource", tags=[None, "blog"]) # "~test-2"
add("https://www.hackbloc.org/rss.xml", tags=[None, "blog"]) # "~hackbloc.org"
add("http://blog.sina.com.cn/rss/1197191492.xml", tags=[None, "blog"]) # Tamia Liu (LiuTao) 's sina blog.
add("http://blog.sina.com.cn/rss/menglikeer.xml", tags=[None, "blog"]) # "~Picture Sina Blog-1"
add("http://blog.sina.com.cn/rss/wings.xml", tags=[None, "blog"]) # "~Picture Sina Blog-2"
add("http://blog.sina.com.cn/rss/1710887475.xml", tags=[None, "blog"]) # "~Picture Sina Blog-3"
add("http://blog.chinaunix.net/u/rss.php?id=22178", tags=[None, "blog"]) # "~test-6"
# add("http://feeds.feedsky.com/csdn.net/chinalinuxzend", tags=[None, "blog"]) # "~test-9"
add("http://confusedfly.yo2.cn/feed", tags=[None, "blog"]) # "~test-10"
add("http://LaTex.yo2.cn/feed", tags=[None, "blog"]) # "~LaTex chinese Blog"
add("http://feeds.feedburner.com/lainme", tags=[None, "blog"]) # "~lainme Blog"
add("http://blog.ibeini.com/feed", tags=[None, "blog"]) # "ibeini Blog ("hack")"
add("https://www.csslayer.info/wordpress/feed/", tags=[None, "blog"]) # "CSSlayer Blog"
add("http://whileimautomaton.net/rss.rdf", tags=[None, "blog"]) # while ("im automaton");
add("http://www.gregsexton.org/feed/", tags=[None, "blog"]) # gregsexton.org
# }}}

default_rate(100)
# Podcasts {{{
add("http://usesthis.com/feed/", tags=[None, "geek", "program", "software", "computer", "setup", "config"]) # The Setup
add("http://setup.xiuxiu.de/feed/", tags=[None, "geek", "computer", "setup", "config"]) # The Setup (Chinese)
add("http://vimcasts.org/feeds/ogg", tags=[None, "podcast", "vim"]) # "~Vimcasts OGG Feed"
add("http://feeds.feedburner.com/voa", tags=[None, "podcast", "english"]) # "~VOA special English Podcasts"
add("http://feeds.feedburner.com/Fosscasts-FreeOpenSourceScreencasts/ogg", tags=[None, "podcast"]) # "~Fosscasts Podcasts"
add("http://feeds.feedburner.com/tedtalks_video", tags=[None, "podcast", "TED"]) # "~TED Talks"
add("http://feeds2.feedburner.com/ShowmedoBlog", tags=[None, "podcast"]) # "~Show Me Do"
add("http://xkcd.com/rss.xml", tags=[None, "xkcd", "comic"]) # xkcd.com
# }}}

default_rate(100)
# Subscribes {{{
# add("http://www.verycd.com/base/cartoon/feed", tags=[None, "anime", "update"]) # VeryCD Anime Updates
# add("http://www.verycd.com/base/movie/feed", tags=[None, "movie", "update"]) # VeryCD Movie Updates
# add("http://www.verycd.com/base/tv/feed", tags=[None, "tv", "update"]) # VeryCD TV Updates
add("http://dev.open.taobao.com/bbs/rss.php?fid=2", tags=[None, "work", "taobao", "dev"]) # TaoBao Developer forums
add("http://ued.taobao.com/blog/feed/", tags=[None, "work", "taobao", "News"]) # TaoBao UED
add("http://hacks.mozilla.org/feed/", tags=[None, "web", "mozilla"]) # "~hacks.mozilla"
add("https://github.com/blog.atom", tags=[None, "update", "git", "feature", "blog"]) # "~Github Blog"
# http://feeds2.feedburner.com/chinagfwblog "~GFW Blog"
add("http://vimcasts.org/feeds/ogg", tags=[None, "podcast", "vim"]) # "~vimcasts.org ogg"
# add("http://maemo.org/news/latest.xml", tags=[None, "maemo"]) # "~maemo latest news"
# add("http://maemo.org/news/items.xml", tags=[None, "maemo"]) # "~maemo news"
# add("http://feeds.feedburner.com/37signals_podcast") # "~37singles Podcast"
add("http://www.hackthissite.org/pages/hts.rss.php", tags=[None, "hack"]) # "~hackthissite RSS"
# add("http://feeds.feedburner.com/PyMOTW", tags=[None, "python", "program"]) # "~Python Module of the Week"
add("http://ninlands.diandian.com/rss", tags=[None, "JiuZhou", "Novel", "books"]) # 九州 点点官方
add("http://feed.feedsky.com/heikezhi", tags=[None, "hack", "ebook"]) # "~黑客志 hack news"
add("http://feed.feedsky.com/aqee-net", tags=[None, "program"]) # 外刊 IT 评论
# }}}

default_rate(60)
# NEWS {{{
# add("http://news.ycombinator.com/rss", tags=[None, "news", "hack"]) # "~Hacker News"
add("http://rss.slashdot.org/slashdot/Slashdot", keep=200, tags=[None, "news", "Slashdot"]) # "~Slashdot"
# add("http://slashdot.org/index.rss", tags=[None, "news", "slashdot"]) # Slashdot
# add("http://reddit.com/.rss", tags=[None, "news", "reddit"]) # Reddit
add("http://feeds2.feedburner.com/solidot", tags=[None, "news", "Solidot"]) # Solidot
add("http://linuxtoy.org/feed/", tags=[None, "news"]) # "~LinuxToy"
add("http://feeds.geekpark.net/", tags=[None, "news"]) # 极客公园
# add("http://kerneltrap.org/node/feed", tags=[None, "kernel"]) # kerneltrap
add("http://feeds.feedburner.com/Command-line-fu", tags=[None, "linux", "commandline"]) # "~Command-line-fu"
#add("http://feeds.feedburner.com/Command-line-fu?format=xml", tags=[None, "linux", "commandline"]) # "~Command Line Fu"
# http://ubuntuweblogs.org/rss20.xml "~ubuntu weblogs"
# http://planet.ubuntu.com/rss20.xml "~ubuntu Blog"
add("http://www.thegeekstuff.com/feed") # "~The Geek Stuff"
#add("http://blog.makezine.com/index.xml") # "~MAKE"
# add("http://seclists.org/rss/nmap-hackers.rss") # "~Nmap hackers"
add("http://blog.jobbole.com/feed/") # "~Jobbole wordspace"
add("http://feeds.feedburner.com/emule-fans") # "~eMule Fans"
#add("http://feeds2.feedburner.com/emule-fans") # "~eMule Fans"
# http://www.lgdb.org/rss.xml "~LGDB Linux Game Data Base"
# }}}

default_rate(600)
# China NEWS {{{
# http://fun4hi.com/?feed=rss2 "~Chinese Fun High"
# http://feed.feedsky.com/kisshi "~Chinese Kiss High"
# http://feed-all.google.org.cn/ "~Google NEWS -cn"
# }}}

default_rate(500)
# SEO {{{
add("http://feed.feedsky.com/stuseo", tags=[None, "SEO"]) # SEO 学习博客
add("http://www.ok.net.cn/blog/rss.php", tags=[None, "SEO"]) # 电子商务博客 - OK网旗下博客
# }}}

default_rate(600)
# Crack {{{
add("http://pcsci3nce.info/?feed=rss2", tags=[None, "crack", "hack"]) # "~pcsci3nce"
add("http://feeds.feedburner.com/HackingWifi", tags=[None, "crack", "hack"]) # "~Hacking Wifi"
add("http://www.dc949.org/news/rss.php", tags=[None, "crack", "blog"]) # DC949 News
add("http://homepages.tu-darmstadt.de/~p_larbig/wlan/", tags=[None, "crack", "hack"]) # "~wlan inject etc dev"
# }}}

default_rate(600)
# ebooks {{{
add("http://www.ppurl.com/feed", tags=[None, "ebook", "IT"]) # "PiPi ebooks.
add("http://book.zi5.me/feed", tags=[None, "ebook"]) # "~ZhiJian book house ("eBook")"
add("http://feeds.feedburner.com/RaphaelHertzogCom", tags=[None, "debian", "admin"]) # debian handbook
# }}}

default_rate(600)
# Pictures {{{
add("http://yukiao.jp/feed", tags=[None, "picture"]) # 青山裕企
# }}}

# ---------------------------------------------------------------

# [ Cursor Behavior 0.7.7+ ] {{{
cursor_type = "edge" # edge, top, middle, bottom.
cursor_scroll = "scroll" # scroll/page
cursor_edge = 3 # integer. how for the cursor is from the end of the screen before it scrolls.
# }}}

# [ Browsing ] {{{
import os
if os.getenv("TERM") == "linux":
    link_handler("elinks \"%u\"", text=True) # for curses browser.
    image_handler("fbi \"%u\"", text=True, fetch=True)
else:
    link_handler("firefox \"%u\"") # open URL with firefox.
    # image_handler("fbv \"%u\"", text=True, fetch=True) # Curses image show.
    image_handler("feh \"%u\"", fetch=True) # Curses image show.
    link_handler("mplayer \"%u\"", ext="mp3") # music
    link_handler("mplayer \"%u\"", ext="mp4") # video
    link_handler("mplayer \"%u\"", ext="ogg") # video
    link_handler("evince \"%u\"", ext="pdf", fetch=True) # PDF

# Non-HTML Content
# link_handler("mplayer -someoptions \"%u\"", ext="mp3") # video
#link_handler("mplayer \"%u\"", ext="mp3") # music
#link_handler("mplayer \"%u\"", ext="mp4") # video
#link_handler("mplayer \"%u\"", ext="ogg") # video
#link_handler("evince \"%u\"", ext="pdf", fetch=True) # PDF
link_handler("vim \"%u\"", ext="txt", fetch=True) # Text
# Images
#image_handler("fbi \"%u\"", text=True, fetch=True) # Curses image viewer.
#image_handler("feh \"%u\"", fetch=True) # X11 image viewer.
# }}}

# [ Reader Layout ] {{{
reader_orientation = None

import canto.cfg

# Layout Hook
#def resize_hook(cfg):
    #cfg.reader_orientation = "left" # None(floating), "left", "right", "top", "bottom".
    #cfg.reader_lines = (cfg.width / 5) * 3
    #cfg.columns = (cfg.width / 2) / 65 # Max column width of 65 characters

# FIXME when window width is smaller than a value, then use another reader orientation.
#def resize_hook(cfg):
    ## when big and wide screen, use left orientation.
    #if cfg.width > 200:
        #cfg.reader_orientation = "left" # None,(default floating), left, right, top, bottom.
        #cfg.reader_lines = (cfg.width / 5) * 3
        #cfg.columns = (cfg.width / 2) / 65 # Max column width of 65 characters
    #else:
        ## when small window, use floating reader.
        #cfg.reader_orientation = None # None,(default floating), left, right, top, bottom.
# }}}

# [ Colors ] {{{
# -1: default, 0: black, 1: red, 2: green, 3: yellow, 4: blue, 5: pink/magenta, 6: cyan, 7: white.
# examples:
#   colors[0] = "blue"
#   colors[0] = 4
#   colors[0] = (4, -1)
#   colors[0] = ("blue, "default")
#   colors[1] = "red"
#       Now colors[1] inherits colors[0]'s background, which now be set to ("red", "default").
# 256 Colors
#   colors[0] = 120

colors[0] = ("default", "default")
# FIXME modify those colors.
# }}}

# [ Using Advanced Features ] {{{
# Importing canto.extra
from canto.extra import *
# }}}

# [ Keybinds ] {{{
# keys['a'] = ...
# reader_keys['a'] = ...
# NOTE: you can override default command.
# unset a key: keys['q'] = None

#keys['\n'] = "reader" # Enter, mark the story read and open the reader.
#keys['\t'] = # Tab,
#keys[' '] = .. # Space,
#keys['  '] =  # Tab,

# http://www.mkssoftware.com/docs/man3/curs_getch.3.asp
# keys['KEY_F1'] = ... # F1.

#keys['C-a'] = # Ctrl-A
#keys['M-a'] = # Alt-A
#keys['C-M-A'] = # Ctrl-Alt-A
# }}}

# [ default binds ] {{{
keys['h'] = "help"
keys['j'] = "next_item"
keys['k'] = "prev_item"
keys['l'] = "next_tag"
keys['o'] = "prev_tag"
keys['KEY_RIGHT'] = "just_read" # mark as read
keys['KEY_LEFT'] = "just_unread" # mark as unread.
keys['g'] = "goto" # open current story link in browser.
keys['f'] = "inline_search" # mark all stories matching a search.
keys['n'] = "next_mark" # go to next marked story.
keys['p'] = "prev_mark" #
keys['N'] = "prev_mark"
keys['.'] = "next_unread" # go to next unread story.
keys[','] = "prev_unread"
keys[' '] = "reader" # Space, mark the story as read and open the reader.
keys['c'] = "toggle_collapse_tag" # Collapse/Show a tag of items.
keys['C'] = "set_collapse_all" # Collapse on all tags.
keys['V'] = "unset_collapse_all" # Uncollapse all tags.
keys['m'] = "toggle_mark" # Mark/unmark an item.
keys['M'] = "all_unmarked" # Unmark all items.
keys['r'] = "tag_read" # set all stories in a feed/group read.
keys['R'] = "all_read" # set all stories read.
keys['u'] = "tag_unread"
keys['U'] = "all_unread"
keys['C-r'] = "force_update" # Reread stories from disk.
keys['C-l'] = "refresh" # Redraw the screen.
keys['q'] = "quit"
# FIXME keys['\\'] = "restart" # Restart Canto (0.7.6+)
keys[']'] = "next_filter" # apply next global filter.
keys['['] = "prev_filter"
keys['}'] = "next_tag_filter" # applet next tag filter. (from filters)
keys['}'] = "prev_tag_filter" # apply previous feed filter.
keys['='] = "next_tag_sort" # apply next tag sort.
keys['-'] = "prev_tag_sort"
keys['<'] = "prev_tagset" # show previous set of tags.
keys['>'] = "next_tagset"
keys[';'] = "goto_reltag" # Goto the Nth visible tag, relative to current index (filter aware)
keys[':'] = "goto_tag" # goto the Nth tag (filter unaware)
# }}}

# [ Reader View ] {{{
reader_keys['j'] = "scroll_down" # scrolls, if there's more text.
reader_keys['k'] = "scroll_up"
reader_keys['KEY_NPAGE'] = "page_down" # Page down.
reader_keys['KEY_PPAGE'] = "page_up"
    # Goto the next story without closing the reader.
reader_keys['n'] = ["destroy", "just_read", "next_item", "reader"]
reader_keys['p'] = ["destroy", "just_read", "prev_item", "reader"]
reader_keys['g'] = "goto" # go to a specific link listed inside the item text.
reader_keys['l'] = "toggle_show_links" # show/hide the list of links at the bottom of the reader.
# reader_keys[' '] = ["destroy", "just_read"] # Space, close the reader.
# reader_keys['q'] = ["destroy", "just_read", "quit"] # Quit Canto
reader_keys['q'] = ["destroy"] # Quit reader
reader_keys['h'] = ["destroy", "just_read", "help"] # Show help.
reader_keys['.'] = ["destroy", "just_read", "next_item", "reader", "toggle_show_links"]
reader_keys[','] = ["destroy", "just_read", "prev_item", "reader", "toggle_show_links"]

reader_keys['C-f'] = "page_down"
reader_keys['C-b'] = "page_up"
reader_keys[' '] = "page_down"
reader_keys['i'] = ["destroy", "just_read"]
# FIXME reader_keys['o'] = "open_current_story_url", like keys['g'] = "goto"
reader_keys['N'] = "just_unread"
# }}}

# [ Macros ] {{{
# queue up more than one action with a keybind. A simple list can get the job done.
# keys['j'] = ["just_read", "next_item"]
keys[' '] = ["just_read", "reader", "toggle_show_links"] # auto read and list links.
keys['\n'] = ["just_read", "reader", "toggle_show_links"]
keys['\t'] = "next_tagset"
# }}}

# [ searching ] {{{
#keys['1'] = search("Linux")
#keys['2'] = search(".*[Uu]buntu.*", regex=True)
# search_filter is "not" in quotes. it's not a builtin keybind, it's a canto.extra function
keys['/'] = search_filter
# }}}

# [ copying & Yanking ] {{{
# A neat function for putting a link on the X clipboard (for use in pasting into a chat,
# a browser, etc.) can be used
# need "xclip" to be installed
keys['y'] = yank
# }}}

# [ Downloading Content ] {{{
# need "wget" to be installed
# reader_keys['w'] = wget_link("/path/to/downloads")
reader_keys['w'] = wget_link("/home/chris/Downloads")
# }}}

# [ Saving ] {{{
# The last neat little utility is save which writes a file (~/canto_out)
# with a title and a link when called.
keys['s'] = save
# }}}

# [ Filters ] {{{
# Perhaps the most useful extra feature Canto provides is its powerful filter system. canto.extra
# provides a number of useful filters.
# None                  --- filter no items
# show_unread           --- ignore all items that have been marked read.
# show_marked           --- ignore all items that are unmarked.
# only_with("string")   --- show only items that have "string" in title.
# only_without("string") --- show only items that don't have "string" in title.
# all_of(filter1, filter2, ...)     --- show only items that pass all listed filters (binary AND)
# any_of(filter1, filter2, ...)     -- show items that pass any of the listed filters (binary OR)
# with_tag_in .....

# There are three ways to apply filters.
# Global filters.
#       These apply regardless. Any items that you see in the interface had to pass
#       through this filter. Global filters are useful, for example, to filter items based upon a
#       given state, as inshow_unread.
# Tag filters.
#       These filters only apply to specific tags (See the tag section).
# Feed filters.
#       These filters are applied when loading content from disk. Items that don't pass this filter
#       will never appear in the interface. Feed filters are useful when you want to ignore a whole
#       set of items entirely, like news posts in webcomic feeds.
# }}}

# [ Global Filters ] {{{
# Setting the 'show unread' filter will remove all previously read feed items by default when Canto
# opens. If you still want to have access to all items, you can add the None filter to the list:
# filters=[show_unread, None]
# filters=[show_unread]
# keys['1'] = set_filter(show_unread)
# keys['2'] = set_filter(show_marked)
# keys['3'] = set_filter(None)
# }}}

# [ Feed Filter ] {{{
# If I wanted just completely ignore non-comic items, I could modify the add call for Penny Arcade
# to use the only_with filter:
#add("http://feeds.penny-arcade.com/pa-mainsite", filter=only_with("Comic:"))
# This filter will eliminate all items that don't have "Comic:" in the title. Other examples include
# filtering distro package feeds for only a certain type of package (i.e. Gentoo,
# only_with("sys-devel")), or filtering porn torrents from torrent site feeds (only_without("XXX"),
# provided the feed items are clearly marked).
# }}}

# [ Tags ] {{{
# A tag is an arbitrary set of stories. By default, Canto creates a single tag per feed and if you
# never use any other tags, feeds and tags are analogous.
# A tag allows you to filter, sort and otherwise customize how these groups of items are displayed.
# }}}

# [ Manipulating Default Tags ] {{{
# add("http://reddit.com/.rss", tags=["Reddit"])
# adding tags.
# add("http://some-other-blog", tags=[None, "blogs"])
# NOTE: None in the tag is shorthand for using the title included with the feed. If all tags are
# omitted, tags=[None] is implied.
# }}}

# [ Using Tags as Folders ] {{{
# Typically, the above behavior, appending the items together by using a common tag is not what a
# user expects unless they're going to use a sort. Usually, tags are used as folders names so that
# switching to "blogs" means showing all the feeds that have "blogs" in the tags.

# This behavior is accomplished using the with_tag_in filter. Following the above example, we can
# emulate folders with global filters:

#add("http://some-blog", tags=[None, "blogs"])
#add("http://some-other-blog", tags=[None, "blogs"])
#filters = [ None, with_tag_in("blogs") ]

# With this snippet, using ']' to switch to the next global filter will cause Canto to display only
# the items in the two "blogs" feeds, but the items will still be organized by feed rather than
# displayed as an appended list of items.

# You can also list multiple tags and use implicit default tags for use in with_tag_in

#add("http://rss.slashdot.org/slashdot/Slashdot") # Creates implicit "Slashdot" tag
#add("http://.some-blog", tags=[None, "blogs"])
#filters = [ None, with_tag_in("Slashdot", "blogs") ]

# Lastly, you can combine with_tag_in and other filters with all_of

# filters = [ None, all_of(with_tag_in("update"), show_unread), all_of(with_tag_in("hack"), show_unread) ]
filters = [ show_unread, all_of(with_tag_in("update"), show_unread), all_of(with_tag_in("hack"), \
        show_unread), None ]

# This combination will make your second global filter show you all of your blog feeds, but only
# their unread items.

# FIXME
# All filters must be classes that subclass Filter ([None, <canto.extra.all_of instance at
# 0x8a4b6ac>])
#update_filter = [ None, all_of(with_tag_in("update"), show_unread) ]
#keys['1'] = set_filter(update_filter)
# }}}

# [ Adding Explicit Tags ] {{{
# So far we've only dealt with implicit tags that are either created by default or by appending a
# string to the tags list. Such creations are only useful for using tags with < / > or in filters.
# However, tags themselves can have attributes. You can make an explicit tag with the add_tag
# function.
#add("http://some-blog", tags=[None, "blogs"])
#add("http://some-other-blog", tags=[None, "blogs"])
#add_tag("blogs", ...parameters...)
# These definitions can come before or after you use them in add calls.
#add_tag("update", filters=[with_tag_in("update")])
add_tag( "update", sort=[reverse_sort(by_date)] )
add_tag("git", sort=[reverse_sort(by_date)] )
add_tag("hack", sort=[by_content] )
add_tag("crack", sort=[by_content] )
add_tag("vim", sort=[by_content] )
add_tag("program", sort=[None] )
add_tag("web", sort=[None] )
add_tag("linux", sort=[None] )
add_tag("commandline", sort=[by_content] )
add_tag("tool", sort=[by_content] )
add_tag("maemo", sort=[None] )
add_tag("english", sort=[by_content] )
add_tag("news", sort=[reverse_sort(by_date)] )
add_tag("podcast", sort=[reverse_sort(by_date)] )
add_tag("blog", sort=[by_content] )
# }}}

# [ Tags Filters ] {{{
#add("http://feeds.penny-arcade.com/pa-mainsite") # Implicitly creates "Penny Arcade" tag
#add_tag("Penny Arcade", filters=[only_with("Comic:"), only_with("News:")])

# NOTE: Tag filters are always overridden by global filters. If your global filter is show_unread,
# even if your tag filter is None, you won't see any read items.

# Like global filters, tag filters can be set by default.
default_tag_filters([show_unread, None])
# Similar to default_rate and default_keep, these defaults are applied as explicit tags are created
# Any tags created with add_tag will inherit the default tag filters from the call immediately
# before the add_tag (or [None] if it hasn't been called at all). Implicit tags (i.e. not created
# with add_tag) are made explicit after the rest of the configuration is done, so they will inherit
# the defaults from the last call to default_tag_filters made in the config.

# Just like global filters, tag filters can be set directly via keybind
#keys['u'] set_tag_filter(show_unread)

# NOTE : Unlike global filters, tag filters will never make a tag fully disappear since there would
# be no easy way to change the tag filter back to one with items in it.
# }}}

# [ Sort ] {{{
# None              -- use the ordering specified in the feed.
# by_date           -- order by the time the items are parsed.
# by_len            -- order by length of title.
# by_content        -- order by length of content.
# by_alpha          -- sort alphabetically.
# by_unread         -- order by read status
# reverse_sort(sort) -- reverse the given sort.
# }}}

# [ Sort Order ] {{{
# Anywhere that a sort can be used, you can use multiple sorts with the sort_order function from
# canto.extra. This takes any number of sorts in order of priority.

default_tag_sorts([sort_order(by_unread, reverse_sort(by_date))])
#default_tag_sorts([sort_order(by_unread, by_alpha)])
# This snippet will make tags sort items first by unread status and then sort the same items
# alphabetically.
# }}}

# [ Adding Content ] {{{
# A common task is to add relevant information to the reader.
# }}}

# [ Typical Content ] {{{
# A lot of feeds support typical information about each item. By default, the reader displays the
# title, the description, and the subsequent links. If you wanted to add other content, you can use
# add_info. For example, to add the author of an item to the reader:
#r = get_default_renderer()
#add_info(r, "Author")
# This will add the following line to the reader, above the content:
# Author: [author]

# add_info takes other arguments to customize how the line is displayed.
#add_info(r, "Author", caption="by: ")

# Additionally, it could be that the information isn't useful and should be ignored. Lots of feed
# generators set author to a default like donotreply@somedomain which isn't useful info. Other feeds
# will put author information into the content anyway. Because of this, you can specify to only add
# the information to particular tags.
#add_info(r, "Author", tags=["Slashdot"...])

r = get_default_renderer()
add_info(r, "Author", caption="by: ")
# }}}

# [ Less Common Content ] {{{
# It's difficult to know whether your RSS includes any special information. As of 0.7.x, canto
# includes a simple wrapper script called canto-inspect. You call it like so:
# $ canto-inspect [URL] > output

# It's essentially a custom pretty printer for the XML Although it is not extremely advanced, using
# canto-inspect you can detect interesting content, as in this partial output from canto-inspect
# http://rss.slashdot.org/slashdot/Slashdot:
add_info(r, "updated", caption="Date: ", tags=["update"]) # display time for update tags stories.
add_info(r, "last-modified", caption="Last Modified: ", tags=["update"]) # display time for update tags stories.
# }}}

# [ Highlighting ] {{{
# New in 0.7.6 is the ability to statically highlight words in the reader or main views.
#r = get_default_renderer()
# FIXME original, the "0" should be "None" behind "NASA"
add_hook_pre_reader(r, highlight_word("hack", 0))
add_hook_pre_reader(r, highlight_word("crack", 0))
add_hook_pre_reader(r, highlight_word("linux", 0))
#add_hook_pre_story(r, highlight_word("never"))
# This will, for example, highlight the word "NASA" in the reader and "never" in the main view.

# These are not case sensitive by default. Those familiar with Python regex can specify a flags arg
# but if all you need is case sensitivity you can set it to None

add_hook_pre_story(r, highlight_word("hack"))
add_hook_pre_story(r, highlight_word("crack"))
add_hook_pre_story(r, highlight_word("curses"))
add_hook_pre_story(r, highlight_word("linux"))
add_hook_pre_story(r, highlight_word("program"))
add_hook_pre_story(r, highlight_word("girl"))
add_hook_pre_story(r, highlight_word("boy"))
add_hook_pre_story(r, highlight_word("women"))
add_hook_pre_story(r, highlight_word("female"))
add_hook_pre_story(r, highlight_word("male"))

add_hook_pre_reader(r, highlight_word("hack"))
# FIXME add_hook_pre_reader(r, highlight_word("stardiviner", None)) # case-sensitivity with None
# }}}

# [ Update Triggers ] {{{
# Canto supports a number of different update mechanisms.
# NOTE: These triggers are to update the client from disk only, they have nothing to do with getting
# items from the server. That is only controlled by running canto-fetch and the rates you have set
# in the configuration.

# Interval Updating.
#       This is the default behavior. At intervals (generally about a minute), the
#       feeds are read from disk and the display is updated. This behavior is what most people
#       expect from their RSS reader.

# Change Tag Updating.
#       This makes the client update whenever you change feeds/tags. This is useful
#       to use with filters.

# Signal Updating.
#       This enables you to issue a SIGUSR1 to canto and trigger a screen update.
#       Most useful from a script (i.e. write a script or a cron that runs canto-fetch and
#       immediately issues SIGUSR1.

# Manual Updating.
#       Not automatic, but driven by a keybind (C-r by default).

# }}}

# [ Considerations ] {{{
# Multiple update triggers allow users to update Canto's feeds in different ways depending upon
# their reading habits. Users who don't appreciate text shifting out from under their eyes might
# want to avoid the every-minute interval update and use the change_tag or manual update triggers to
# insure more predictable refreshes. On the other hand, users that tend to jump from one tag to
# another and do short bursts of content reading might find the interval triggers more to their
# liking. It's all about what suits you.

# If you feel there is an update trigger that we need to implement, file a feature request bug and
# we'll consider it. Update triggers are fairly easy to implement.
# }}}

# [ Using Triggers ] {{{
# Using triggers is a simple as using a list. By default, triggers is set like this:
#triggers = ["interval"]

# You can add triggers or remove triggers with typical Python list functions
#triggers.append("change_tag")
#triggers.append("signal")
#triggers.remove("interval")

triggers.append("interval")
triggers.append("change_tag")
triggers.append("signal")
# }}}

# [ Hooks ] {{{
# Canto includes a number of hooks for outside extensibility. You may find hooks to be most useful
# when you author them yourself. Even so, canto.extra does include a few basic, but useful, hooks.

#start_hook | Run once, on startup

#resize_hook | Run when the window is resized (including on start)

#new_hook | Run once for every new item.

#select_hook | Run when a new item is selected

#unselect_hook | Run when an item is unselected

#state_change_hook | Run whenever an item's state (read/marked) changes

#update_hook | Run when the interface updates

#end_hook | Run when the interface closes

# NOTE: All hooks are enforced by the interface except new_hook. new_hook is intended to be used as
# a notification method. All other hooks don't function unless Canto is running.
# }}}

# [ Using Hooks ] {{{
# There are only two hooks included in canto.extra by default. These are for manipulating the titles
# of an xterm (or another compatible X terminal).
# import os
if os.getenv("TERM") == "rxvt-unicode-256color" or os.getenv("TERM") == "xterm-256color":
    select_hook = set_xterm_title
    end_hook = clear_xterm_title
# This will set the xterm's title to "Tag - Title" when you select an item and clear it when Canto
# closes.
# }}}

# vim: foldmethod=marker
