# DNSChat

A simple proof-of-concept of a Perl-based DNS resolver host
to enable chat over DNS.

Intended use case is to enable basic comms for users behind very expensive
WiFi portals like on planes, stations, and cruise ships.

To use:
1) Get a server (e.g. AWS) on a defined IP.
2) Update server/server.pl to include your local 10.* IP from ifconfig.
3) On the server run "sudo perl server/server.pl" to start the server.
4) Update the client/client.pl to point to the static public IP of your
   server.
5) On your client, run "perl client/client.pl" to test the configuration.

Server test:
* "perl server/testdb.pl" to ensure the database is storing & retrieving
  messages correctly.

References:
* http://projects.bentasker.co.uk/jira_projects/browse/DNSCHAT.html
* Net::DNS
