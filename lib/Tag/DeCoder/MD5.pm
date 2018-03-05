package Tag::DeCoder::MD5;
use 5.16.1;
use Digest::MD5 qw(md5_hex);

sub new { bless [], ref($_[0]) || $_[0] }

sub encode { md5_hex($_[1]) . $_[1] }

sub decode {
    length($_[1])<32 and die 'this is not md5-prefixed data';
    my $pData=\(substr($_[1], 32));
    ( substr($_[1], 0, 32) eq md5_hex(${$pData}) )  or die 'md5 coder detected data corruption';
    ${$pData}
}

1;
