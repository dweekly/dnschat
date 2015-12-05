#!/usr/bin/perl

use Data::Dumper;
use msgdb;

print(Dumper($msgdb));
send_message_to_room(1234, "Hi there!", "dweekly", "ship2015");
print(Dumper($msgdb));

print(Dumper(get_messages_since(1231,"ship2014"))); # expect nothing
print(Dumper(get_messages_since(1235,"ship2015"))); # expect nothing
print(Dumper(get_messages_since(1231,"ship2015"))); # expect one msg

die();
