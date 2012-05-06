# creates ascii art text with the figlet program. You need to have figlet installed. This script is used with /figlet command, which understands IRC colour codes, and will
# re-assemble the generated art with the correct colours. You don't have to use colour, of course. In that case, this script still has a major advantage over /exec -out
# figlet -k: you won't have to think about special characters like ). Ever tried /exec -out figlet :)? :)
use IPC::Open3;
use strict;
use vars qw($VERSION %IRSSI);

use Irssi qw(command_bind active_win);
$VERSION = "1.14";
%IRSSI = (
    authors	=> 'Juerd',
    contact	=> 'juerd@juerd.nl',
    name	=> 'Figlet',
    description	=> 'Safe figlet implementation (with color support!)',
    license	=> 'Public Domain',
    url		=> 'http://juerd.nl/irssi/',
    changed	=> 'Sun 10 Mar 14:46 CET 2002',
    changes	=> 'No more zombie processes',
);

command_bind(
    figlet => sub {
	my ($msg) = @_;
	my @figlet;
	my $prefix = '';
	while ($msg =~ s/
	    ^(
		[^\cC\cB\cO\c_]+
	    |
		(?:
		    \cC\d*(?:,\d*)?
		|
		    [\cB\cO\c_]
		)+
	    )
	//x) {
	    my $part = $1;
	    if ($part =~ /[\cC\cB\cO\c_]/) {
		if (@figlet) {
		    $_ .= $part for @figlet;
		} else {
		    $prefix = $part;
		}
	    } else {
		my $i = 0;
		my $pid = open3(undef, *FIG, *FIG,  qw(figlet -k), $part);
		while (<FIG>) {
		    chomp;
		    $figlet[$i++] .= $_;
		}
		close FIG;
		waitpid $pid, 0;
	    }
	}
	for (@figlet) {
	    (my $copy = $_) =~ s/\cC\d*(?:,\d*)?|[\cB\cO\c_]//g;
	    next unless $copy =~ /\S/;
	    active_win->command("say $prefix$_");
	}
    }
);
