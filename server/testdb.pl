#!/usr/bin/perl -w

use Data::Dumper;

use msgdb;

use Test::Simple tests => 4;

# seed the message database
send_message_to_room(1234, "Hi there!", "dweekly", "ship2015");

($m,$err) = get_messages_since(1231, "ship2014");
ok(scalar @{$m} == 0); # expect nothing

($m,$err) = get_messages_since(1235, "ship2015");
ok(scalar @{$m} == 0); # expect nothing

($m,$err) = get_messages_since(1231, "ship2015");
ok(scalar @{$m} == 1); # expect one msg back
ok($m->[0]->{ts} == 1234); # expect ts preserved

