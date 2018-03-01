use strict;
use Test::More 0.98;
use lib 'lib';
use JSON::XS;

use_ok $_ for qw(
    Tag::DeCoder
);

my $foreca_data = do { open my $fhForeca, '<', 't/data/foreca.json'; local $/ = <$fhForeca> };
my %foreca_struct = ( 'ethalon' => JSON::XS->new->decode($foreca_data) );

$foreca_struct{ $_ } = decodeByTag(encodeByTag($_ => $foreca_struct{'ethalon'})) for 'CB,Z', 'MP,Z,B64';

is_deeply($foreca_struct{'CB,Z'}, 	$foreca_struct{'ethalon'}, 'Complex datastructure nested decode/encode, zipped CBOR');
is_deeply($foreca_struct{'MP,Z,B64'}, 	$foreca_struct{'ethalon'}, 'Complex datastructure nested decode/encode, base64 over zipped MessagePack');

done_testing;
