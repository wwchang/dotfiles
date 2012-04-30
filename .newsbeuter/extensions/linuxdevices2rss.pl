#!/usr/bin/perl

#Filter plugin that converts main page of http://www.linuxfordevices.com to RSS.
#Heavily based on sonataarctica script by Oliver Feiler. 
#[20051020] - Reverse order of articles. Much more natural on dialup links :-) 

use Data::Dumper;
use XML::LibXML;

my $contentblock  = 0;
my $base = 'http://www.linuxdevices.com';

while ($line = <STDIN>) {
        my %item;
        if ($line =~ /<font face=['"]Arial,Helvetica['"].*>News<\/font><\/th>/) {
                $contentblock = 1;
                next;
        }

        if ($line =~ /More  News .../) {
                last;
        }

        if ($contentblock == 1) {
                if ($line =~ /<a href="[^"]*\/news\//i) {
                        # headline
                        $line =~ /<a href="([^"]+)">(.*)<\/a><\/b> &#151;/i;
                        $item{'title'} = $2;
                        # link
                        $item{'link'} = $1;
                        if( $item{'link'} !~ /^http/ ) {
                            $item{'link'} = "http://www.linuxfordevices.com/$item{'link'}";
                        }
                        $item{'link'} =~ s/&/&amp;/g;
                        # article
                        $line = <STDIN>;
                        while( $line =~ /\r$/ ) {
                            $line =~ s/\r\n//;
                            $line .= <STDIN>;
                        }
                        $line =~ /(<!-[^>]*>)?\s*(.*)\s*<br>/i;
                        $item{'content'} = $2;
                        unshift(@DB,\%item);
                }
        }
}

#############################################################
# Taken from sonataarctica feed gen script.
# Does not work on OpenBSD 3.5 (see http://kiza.kcore.de/journal/2004-11&item=2)

my $rssbase = $base;

# Create XML
my $nsrss = "http://purl.org/rss/1.0/";
my $nsrdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
my $nsdc = "http://purl.org/dc/elements/1.1/";

my($doc) = XML::LibXML::Document->new();
my($text);

my($root) = $doc->createElement('RDF');
$root->setNamespace($nsrss, '', 0);
$root->setNamespace($nsrdf, 'rdf', 1);
$root->setNamespace($nsdc, 'dc', 0);
$doc->setDocumentElement($root);
$doc->setEncoding("iso-8859-1");

my($channel) = $doc->createElement('channel');
$channel->setAttribute('rdf:about', "$rssbase");
$root->appendChild($channel);
$channel->appendTextChild('title', 'Linuxdevices news');
$channel->appendTextChild('link', "$rssbase");
$channel->appendTextChild('description', 'Linuxdevices news');

my($channelitems) = $doc->createElement('items');
$channel->appendChild($channelitems);
my($seqitems) = $doc->createElement('rdf:Seq');
$channelitems->appendChild($seqitems);

foreach (@DB) {
        my $rssurl = $_->{'link'};
        my($li) = $doc->createElement('rdf:li');
        $li->setAttribute('rdf:resource', "$rssurl");
        $seqitems->appendChild($li);

        my($rssitem) = $doc->createElement('item');
        $rssitem->setAttribute('rdf:about', "$rssurl");
        $root->appendChild($rssitem);
        $rssitem->appendTextChild('link', "$rssurl");
        $rssitem->appendTextChild('title', $_->{'title'});
        $rssitem->appendTextChild('description', $_->{'content'});

        $rssitem->appendTextChild('dc:date', $_->{'date'});
}

print $doc->serialize(1);
