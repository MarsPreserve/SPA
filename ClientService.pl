use strict;
use warnings;
use feature 'say';

use IO::Socket qw(AF_INET AF_UNIX SOCK_STREAM SHUT_WR);

my $client = IO::Socket->new(
    Domain   => AF_INET,
    Type     => SOCK_STREAM,
    proto    => 'tcp',
    PeerPort => 3333,
    PeerHost => '0.0.0.0',
) || die "Can't open socket: $IO::Socket::errstr";

say "Sending File Now ... ";
my $size = $client->send("DATA");
say "Sent data of length: $size";

$client->shutdown(SHUT_WR);

my $buffer;
$client->recv($buffer, 1024);
say "Got back $buffer";

$client->close();