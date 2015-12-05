#!/usr/bin/perl

# Shitty little chat-by-DNS demo prototype

# v0.1 just responds with the same message
# v0.2 keeps an in-memory store per chatroom

use strict;
use warnings;
use Net::DNS::Nameserver;
use Net::IDN::Encode ':all';

use msgdb;

sub reply_handler {
    my ($qname, $qclass, $qtype, $peerhost,$query,$conn) = @_;
    my ($rcode, @ans, @auth, @add);
    my ($ts, $msg, $uname, $room);
    my ($response, $recordname, $rr);

#    print "Received query from $peerhost to ". $conn->{sockhost}. "\n";
#    $query->print;

    if($qname =~ /^(\d+)\.([^\.]+)\.([^\.]+)\.([^\.]+)\.POST/) {
	$ts = $1;
	$msg = domain_to_unicode($2);
	$uname = $3;
	$room = $4;
	print "$uname at $ts in $room: $msg\n";

        #TODO: validate the message

	send_message_to_room($ts, $msg, $uname, $room);

	$recordname = time().".".$room.".MSG";
	$rr = new Net::DNS::RR(name => $recordname,
			       type => 'TXT',
			       txtdata => "testresponse");
	push @ans, $rr;

	$rcode = "NOERROR";
    }

    if(!$rcode) {
	$rcode = "NXDOMAIN";
    }

    # mark the answer as authoritive (by setting the 'aa' flag
    return ($rcode, \@ans, \@auth, \@add, { aa => 1 });
}


my $ns = new Net::DNS::Nameserver(
    LocalPort    => 53,
    LocalAddr    => '10.226.129.51',
    ReplyHandler => \&reply_handler,
#    Verbose     => 1
    ) || die "couldn't create nameserver object\n";

$ns->main_loop;
