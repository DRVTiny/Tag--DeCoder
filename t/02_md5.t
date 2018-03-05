use strict;
use Test::More 0.98;
use lib 'lib';

use_ok $_ for qw(
    Tag::DeCoder
);

my $foreca_data = do { open my $fhForeca, '<', 't/data/foreca.json'; local $/ = <$fhForeca> };
my $foreca_struct = decodeByTag('{JS}' . $foreca_data);

is_deeply(decodeByTag(encodeByTag('CB', 'MD5', 'Z' => $foreca_struct)), $foreca_struct, 'Test MD5 data consistency checking');

done_testing;
