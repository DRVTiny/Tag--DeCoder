# NAME

Tag::DeCoder - Minimalistic functional interface for consensual serialization/deserialization

# SYNOPSIS

    use Tag::DeCoder;
    
    my $encoded = encodeByTag('CB' => {'my' => {'name' => ['Andrey', 'Alexandrovich'], 'surname' => 'Konovalov'}});
    my $decoded = decodeByTag($encoded);
    
    my $enc_binary_safe_ziped_data = encodeByTag('CB', 'Z', 'B64' => $big_data_structure);
    
    # You can also decode your data in place:
    decodeByTag(my $data=recv_it_from_socket());
    

# DESCRIPTION

Tag::DeCoder provides you universal and very simple way to do consensual serialization/deserialization of Perl data-structures
On the "sender" you will use encodeByTag() specifying desired method of serizalization (or possibly several nested methods)
On the "receiver" side you will simply use decodeByTag() with the received serialized data - and you get exactly the same data 
structure that was passed by sender.

All packages needed for (de)seralization will be loaded and registered as coders automagically on first call of decodeByTag/encodeByTag, 
so you dont need to load anything except Tag::DeCoder (and, of course, you have to install backend packages for coders/decoders as well).

# TAGS

Basically Tag::DeCoder provides only few coders/decoders:

* **CB** - for CBOR. Inherits all methods from [CBOR::XS package](https://metacpan.org/pod/CBOR::XS) for [CBOR](http://cbor.io/) coding and decoding
* **JS** - for JSON; Inherits all methods from [JSON::XS package](https://metacpan.org/pod/JSON::XS) for JSON coding and decoding.
* **MP** - for MessagePack; Uses [Data::MessagePack package](https://metacpan.org/pod/Data::MessagePack) as base, implements encode
  and decode methods as pseudonames for pack/unpack functions from the base
  package
* **SER** - for Sereal. According to [Sereal](https://metacpan.org/pod/Sereal) documentation, internally uses fast function calls 
  to sereal_encode_with_object and sereal_decode_with_object instead of OOP interface
* **I** - simplest native Perl-coding of UInt32 sequences such as [12,70819, 1e+6]
* **II** - native Perl implementation for Array of Arrays of UInt32, such as [ [12, 70819, 1e+6], [167657, 890] ]
* **B64** - for Base64 coding/decoding. Uses [MIME::Base64](https://metacpan.org/pod/MIME::Base64) as base (which contains fast XS code)
* **Z** -  to get "zipped" version of your data. Uses [Compress::Zlib](https://metacpan.org/pod/Compress::Zlib) in very straightforward manner :)
* **MD5** - prevents data loss or corruption by prefixing your data with md5_hex sum on encode and checking whether md5_hex of data after prefix 
  is stil equal to the prefix itself on decode

To write your own "tagged" serialization helper, you must create package Tag::DeCoder::{TAG} where TAG name is 1 to 3
characters long and may contain only this symbols: [A-Z] for the first letter, [A-Z0-9] for the rest 1 or 2 symbols.
Your coder must be written as object class and must implement only 2 basic methods: "encode" and "decode".
It may implement other methods as well.

You may create pull request to include your serialization helper in the Tag::DeCoder source tree

# LICENSE

Copyright (C) Andrey A. Konovalov.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Andrey Konovalov aka DRVTiny <drvtiny@gmail.com>
