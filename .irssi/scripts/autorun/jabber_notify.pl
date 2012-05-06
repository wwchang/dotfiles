#!/usr/bin/env perl

use strict;
use warnings;

use vars qw($VERSION %IRSSI $Notes $AppName);

use Irssi;

use DateTime;
use Net::Jabber;
use Unicode::String qw[utf8 latin1];
use Data::Dump 'dump';

$VERSION = '0.02';
%IRSSI = (
    authors         =>      'David Jack Olrik',
    contact         =>      'djo@cpan.org',
    name            =>      'jabber_notify',
    description     =>      'Sends out notifications for Irssi via Jabber',
    license         =>      'Artistic',
    url             =>      'http://david.olrik.dk/',
);

sub cmd_jabber_notify ($$$)
{
    Irssi::print('%G>>%n Jabber notify can be configured using settings:');
    Irssi::print('%G>>%n jabber_notify_show_privmsg : Notify about private messages.');
    Irssi::print('%G>>%n jabber_notify_show_hilight : Notify when your name is hilighted.');
    Irssi::print('%G>>%n jabber_notify_show_notify  : Notify when someone on your away list joins or leaves.'); 
    Irssi::print("\%G>>\%n jabber_notify_hostname     : Jabber server - default 'jabber.dk'");
    Irssi::print("\%G>>\%n jabber_notify_port         : Jabber port - default '5222'");
    Irssi::print('%G>>%n jabber_notify_tls          : Encrypy if possible - default ON');
    Irssi::print('%G>>%n jabber_notify_resource     : Jabber resource name, change this one if you have more than one irssi running');
    Irssi::print('%G>>%n jabber_notify_username     : Jabber username');
    Irssi::print('%G>>%n jabber_notify_password     : Jabber password');
    Irssi::print('%G>>%n jabber_notify_recipient    : Jabber notification recipient');


}

$Notes = ["Script message", "Message notification"];
$AppName = "irssi";

sub notify
{
    my ($title,$text) = @_;

    return unless Irssi::settings_get_str('jabber_notify_recipient')
        && Irssi::settings_get_str('jabber_notify_username')
        && Irssi::settings_get_str('jabber_notify_password');

    my $message = sprintf("Irssi: %s %s",DateTime->now(time_zone => 'local')->hms,join(' ',$title, $text));

    my $client = Net::Jabber::Client->new(debuglevel => 0);

    $client->Connect(
        hostname       => Irssi::settings_get_str('jabber_notify_hostname'),
        componentname  => Irssi::settings_get_str('jabber_notify_hostname'),
        port           => Irssi::settings_get_str('jabber_notify_port'),
        timeout        => 10,
        connectiontype => 'tcpip',
        tls            => Irssi::settings_get_bool('jabber_notify_tls'),
    );

    $client->AuthSend(
        username => Irssi::settings_get_str('jabber_notify_username'),
        password => Irssi::settings_get_str('jabber_notify_password'),
        resource => Irssi::settings_get_str('jabber_notify_resource'),
    );

    $client->MessageSend(
        to      => Irssi::settings_get_str('jabber_notify_recipient'),
        subject => 'Irssi',
        body    => utf8($message)->latin1,
    );

    $client->Disconnect;
}

sub sig_message_private ($$$$) {
    return unless Irssi::settings_get_bool('jabber_notify_show_privmsg');

    my ($server, $data, $nick, $address) = @_;

    # Do not notify if the address of the active query matches the address of
    # the current message
    return
        if Irssi::active_win->{active}->{address}
        && Irssi::active_win->{active}->{address} eq $address;

    notify("Query","<$nick> $data");
}

sub sig_print_text ($$$) {
        return unless Irssi::settings_get_bool('jabber_notify_show_hilight');

        my ($dest, $text, $stripped) = @_;

        # Do not notify if we are in the active window
        return if $dest->{window}->{refnum} == Irssi::active_win()->{refnum};

        if ($dest->{level} & MSGLEVEL_HILIGHT) {
            notify('',"$dest->{target} $stripped");
        }
}

#sub sig_notify_joined ($$$$$$) {
#        return unless Irssi::settings_get_bool('jabber_notify_show_notify');
#        my ($server, $nick, $user, $host, $realname, $away) = @_;
#       
#        my $title = $realname || $nick;
#        my $message = "<$nick!$user\@$host>\nHas joined $server->{chatnet}";
#        notify($title,$message);
#}

#sub sig_notify_left ($$$$$$) {
#        return unless Irssi::settings_get_bool('jabber_notify_show_notify');
#        my ($server, $nick, $user, $host, $realname, $away) = @_;
#
#        my $title = $realname || $nick;
#        my $message = "<$nick!$user\@$host>\nHas left $server->{chatnet}";
#        notify($title,$message);
#}

Irssi::command_bind('jabber_notify', 'cmd_jabber_notify');

Irssi::signal_add_last('message private', \&sig_message_private);
Irssi::signal_add_last('print text', \&sig_print_text);
Irssi::signal_add_last('notifylist joined', \&sig_notify_joined);
Irssi::signal_add_last('notifylist left', \&sig_notify_left);

Irssi::settings_add_bool($IRSSI{'name'}, 'jabber_notify_show_privmsg', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'jabber_notify_show_hilight', 1);
Irssi::settings_add_bool($IRSSI{'name'}, 'jabber_notify_show_notify', 1);
Irssi::settings_add_str($IRSSI{'name'}, 'jabber_notify_hostname', 'jabber.dk');
Irssi::settings_add_str($IRSSI{'name'}, 'jabber_notify_port', '5222');
Irssi::settings_add_bool($IRSSI{'name'}, 'jabber_notify_tls', 1);
Irssi::settings_add_str($IRSSI{'name'}, 'jabber_notify_resource', 'Irssi');
Irssi::settings_add_str($IRSSI{'name'}, 'jabber_notify_username', '');
Irssi::settings_add_str($IRSSI{'name'}, 'jabber_notify_password', '');
Irssi::settings_add_str($IRSSI{'name'}, 'jabber_notify_recipient', '');

Irssi::print('%G>>%n '.$IRSSI{name}.' '.$VERSION.' loaded (/jabber_notify for help)');
#Irssi::print(join(', ',keys %{Irssi::active_win()}));
#Irssi::print(Irssi::active_win()->{refnum}); # 1
#Irssi::print(Irssi::active_win()->{sticky_refnum}); # 2
