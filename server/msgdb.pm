#!/usr/bin/perl

package msgdb;

BEGIN {
    require Exporter;
    our $VERSION = 0.2;
    our @ISA = qw(Exporter);
    our @EXPORT = qw(send_message_to_room get_messages_since);
    our @EXPORT_OK = qw($msgdb);
}

our $msgdb = {};

sub send_message_to_room($$$$) {
    my ($ts, $msg, $uname, $room) = @_;

    # store the message in the local database
    # for now just a crappy in-mem DB, no persistence
    push(\@{$msgdb->{$room}}, {ts => $ts, msg => $msg, uname => $uname});

    # push out message to any listeners
}

sub get_messages_since($$) {
    my ($ts, $room) = @_;

    # TODO: sanity check on age of ts?
    # TODO: sanity check on total # msgs returned

    my $msgs = [];
    if(!$msgdb->{$room}){
	return ($msgs, "No such room!");
    }

    # walk backwards through room messages until earlier than asked
    my $room_ref = $msgdb->{$room};
    my $num_room_messages = scalar @{ $room_ref };
    while($num_room_messages--){
	my $msg = $room_ref->[$num_room_messages];
	if($msg->{ts} < $ts){
	    return ($msgs, "");
	}
	push $msgs, $msg;
    }
    return ($msgs, "");
}

1;
