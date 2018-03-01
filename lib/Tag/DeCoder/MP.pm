package Tag::DeCoder::MP;
use base 'Data::MessagePack';
my %map_methods=('encode' => 'pack', 'decode' => 'unpack');
{
    no strict 'refs';
    *{__PACKAGE__.'::'.$_}=\&{'Data::MessagePack::'.$map_methods{$_}} for keys %map_methods;
}

1;
