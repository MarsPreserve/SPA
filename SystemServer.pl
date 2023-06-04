use strict;
use warnings;
use feature 'say';

use IO::Socket qw(AF_INET AF_UNIX SOCK_STREAM SHUT_WR);

my $server = IO::Socket->new(
    Domain => AF_INET,
    Type => SOCK_STREAM,
    Proto => 'tcp',
    LocalHost => '0.0.0.0',
    LocalPort => 3333,
    ReusePort => 1,
    Listen => 5,
) || die "Can't open socket: $IO::Socket::errstr";
say "Waiting on 3333";

while (1) {
    # waiting for a new client connection
    my $client = $server->accept();

    # get information about a newly connected client
    my $client_address = $client->peerhost();
    my $client_port = $client->peerport();
    say "Connection from $client_address:$client_port";

    # read up to 1024 characters from the connected client
    my $data = "";
    $client->recv($data, 1024);
    say "received data: $data";

    # write response data to the connected client
    $data = "ok";
    $client->send($data);

    # notify client that response has been sent
    $client->shutdown(SHUT_WR);
}

$server->close();