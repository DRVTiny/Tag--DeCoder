use strict;
use Test::More 0.98;
use lib 'lib';

use_ok $_ for qw(
    Tag::DeCoder
);

my $foreca_data = do { open my $fhForeca, '<', 't/data/foreca.json'; local $/ = <$fhForeca> };
my $foreca_struct = decodeByTag('{JS}' . $foreca_data);
is_deeply(decodeByTag(encodeByTag('SER' => $foreca_struct)), $foreca_struct, 'Sereal encoding/decoding');

done_testing;
