#!/usr/bin/perl
#
# This script generates an RSS feed from the current and past slashdot polls (http://slashdot.org/pollBooth.pl). 
# It can be used as a filter or execurl. See the comment on top of the file for instructions on how to install it. 
# Plus after all these years it still works! :^)

#######################################################################
# As filter: subscribe http://slashdot.org/pollBooth.pl and let it
#            filter through this script.
# Execurl:   Run script as "slashdotpoll -external". This will use
#            curl to download the web page.
#
# Public domain. No copyright is claimed.
# Original author Oliver Feiler <kiza@gmx.net>

$baseurl = "http://slashdot.org";
$pollurl = "/pollBooth.pl?qid=";
$mode = 1;
if ($ARGV[0] eq "-external") {
	$mode = 2;
}

if ($mode == 1) {
	@content = <>;
} else {
	@content = `curl -s -m 20 http://slashdot.org/pollBooth.pl`;
}

print	'<?xml version="1.0"?>'.
		'<rss version="0.91"><channel>'.
		'<title>Slashdot Polls</title>'.
		'<link>http://slashdot.org/pollBooth.pl</link>'.
		'<description>Slashdot Poll RSS feed</description>';
foreach(@content) {
	if (/pollBooth.pl\?qid=\d+"/) {
		/pollBooth.pl\?qid=(.*?)">(.*?)</;
		$headline = $1;
		$headline =~ s/&/&amp;/g;
		$headline =~ s/</&lt;/g;
		$headline =~ s/>/&gt;/g;
		$headline =~ s/\"/&quot;/g;
		$headline =~ s/\'/&apos;/g;
		print "<item><link>$baseurl$pollurl$headline</link><title>$2</title></item>";
	}
}

print "</channel></rss>\n";



