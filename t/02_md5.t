use strict;
use utf8;
use open qw(:utf8 :std);
use Test::More 0.98;
use lib 'lib';

use_ok $_ for qw(
    Tag::DeCoder
);

my $foreca_data = do { open my $fhForeca, '<', 't/data/foreca.json'; local $/ = <$fhForeca> };
my $foreca_struct = decodeByTag('{JS}' . $foreca_data);

is_deeply(decodeByTag(encodeByTag('CB', 'MD5', 'Z' => $foreca_struct)), $foreca_struct, 'Test ASCII data consistency by MD5 checking');

my $sentence_with_widechar = 'мама мыла раму';
is(decodeByTag(encodeByTag('MD5' => $sentence_with_widechar)), $sentence_with_widechar, 'Test UTF8 data consistency with direct MD5 decode after encode');

my $struct_with_widechar = {'sentence' => [split /\s/ => $sentence_with_widechar]};
is_deeply(decodeByTag(encodeByTag('CB,Z,MD5' => $struct_with_widechar)), $struct_with_widechar, 'Test UTF8 data consistency after complex transformations');

done_testing;
