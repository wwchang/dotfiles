#!/usr/bin/perl
#
# csszengarden2rss - Converts recent themes from www.csszengarden.com to an RSS feed.
#
# For usage with http://www.csszengarden.com/
#
# Copyright (c) 2004 Christophe Meyer <stombi@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

#Convert recent themes from csszengarden.com to RSS 
#For usage with http://www.csszengarden.com/ 

use strict;

my $html='';
while(<>){$html.=$_;}

print <<EOXML
<?xml version="1.0" encoding="iso-8859-1"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns="http://purl.org/rss/1.0/">

	<channel rdf:about="http://www.csszengarden.com/"> 
		<title>css Zen Garden</title>
		<link>http://www.csszengarden.com/</link>
		<description>css Zen Garden: The Beauty in CSS Design</description>
		<dc:language>en</dc:language>
EOXML
;

print <<EOSEQ
		<items>
			<rdf:Seq>
EOSEQ
;

while ($html=~m/<li><a\s+href="(.*?)"\s+title="AccessKey:/smg)
{
	my $seq = 'http://www.csszengarden.com/'.$1;
	
print <<EOSEQ
				<li rdf:resource="$seq"/>
EOSEQ
;
}

print <<EOSEQ
			</rdf:Seq>
		</items>
	</channel>
EOSEQ
;

while ($html=~m/<li><a\s+href="(.*?)"\s+title="AccessKey:.*?>(.*?)<\/a>.*?<a href="(.*?)"\s+class=".*?">(.*?)<\/a><\/li>/smg)
{
my $link = 'http://www.csszengarden.com/'.$1;
my $authorlink = $3;
my $author = $4;
my $title = $2.' by '.$author;
my $title2 = $2;
my $creator = '<a href="'.$authorlink.'">'.$author.'</a>';
my $description = '<p><strong>'.$title2.'</strong> by '.$creator.'</p>';


print <<EOITEM
	<item rdf:about="$link">
		<title><![CDATA[$title]]></title>
		<link>$link</link>
		<description><![CDATA[$description]]></description>
		<dc:creator><![CDATA[$creator]]></dc:creator>
		<dc:subject>CSS</dc:subject>
	</item>
EOITEM
;
}
print <<EOXML
</rdf:RDF>
EOXML
;
