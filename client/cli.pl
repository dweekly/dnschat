#!/usr/bin/perl

use Net::IDN::Encode ':all';
use Net::DNS;

my $res = Net::DNS::Resolver->new(
    nameservers => [qw(54.241.255.225)],
    recurse     => 0,
    debug       => 1,
);

my $ts = time();
my $msg = "Hello, world!";
my $user = "dweekly";
my $room = "ship2015";

# $msg = s/ /-/g;

my $host = $ts.".".domain_to_ascii($msg).".".$user.".".$room.".POST";

my $reply = $res->search($host, 'TXT');

if ($reply) {
    foreach my $rr ($reply->answer) {
	next unless $rr->type eq "A";
	print $rr->address, "\n";
    }
} else {
    warn "query failed: ", $res->errorstring, "\n";
}

