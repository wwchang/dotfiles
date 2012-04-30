#!/usr/bin/perl

# RSS creator for Liferea/Snownews and the CTRL-ALT-DEL online comic.
#
# Author: Florian Brucker
# E-Mail: torf at torfbold dot com
# Homepage: http://www.torfbold.com
# Version: 0.2
#
# History:
#   0.1 - First release
#   
#   0.2 - Adaption to RSS 2.0
#
# This software is provided "as is", without any warrenty. Feel free to
# do with it what you like.

#Filters the feed from www.ctrlaltdel-online.com and keeps only the items
#announcing new comic strips. The images of these are automatically included in
#the feed (this is not the case in the original feed). 

use strict;
use warnings;

# print feed header
print <<HEADER;
<?xml version='1.0'?>
<rss version='2.0' xmlns:content="http://purl.org/rss/1.0/modules/content/">
	<channel>
		<title>Ctrl+Alt+Del</title>
		<link>http://www.cad-comic.com/</link>
		<description>RSS for the popular comic Ctrl+Alt+Del</description>
		<language>en-us</language>
		<generator>CAD RSS Generator v1.0</generator>
		<ttl>15</ttl>
		<image>
			<url>http://www.cad-comic.com/_common/images/CADlogo_144x82.jpg</url>
			<title>CAD Logo</title>
			<link>http://www.cad-comic.com/</link>
			<width>144</width>
			<height>82</height>
		</image>
		<docs>http://blogs.law.harvard.edu/tech/rss</docs>
HEADER
my $comic = 0;
while (<>) {
	
	s/^\s*//;
	
	if (/<title>.*<\/title>/) {
		if (/<title>Comic:\s*(.*)\s*<\/title>/) {
			print "\t\t<item>\n\t\t\t<title>$1</title>\n";
			$comic = 1;
		} else {
			$comic = 0;
		}
		next;
	} elsif (/<lastBuildDate>.*<\/lastBuildDate>/) {
		print "\t\t";
		print;
	}

	next if (!$comic);

	if (/<link>.*d=(.*)<\/link>/) {
		my $link = $1;
		$link =~ s/\-//g;
		print "\t\t\t<content:encoded><![CDATA[<img src=\"http://cad-comic.com/comics/$link.jpg\" />]]></content:encoded>\n";
		print "\t\t\t<link>http://cad-comic.com/comic.php?d=$link</link>\n";
	} elsif (/<pubDate>.*<\/pubDate>/ || /<author>.*<\/author>/ || /<guid>.*<\/guid>/) {
		print "\t\t\t";
		print;
	} elsif (/<\/item>/) {
		print "\t\t</item>\n";
	}
}

# print feed footer
print "\t</channel>\n</rss>\n";

