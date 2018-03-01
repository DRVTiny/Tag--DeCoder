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

* CB - for CBOR. Inherits all methods from CBOR::XS package for CBOR coding and decoding (compact binary JSON-like
  format). 
* JS - for JSON; Inherits all methods from JSON::XS package for JSON coding and
  decoding.
* MP - for MessagePack; Uses Data::MessagePack as base, implements encode
  and decode methods as pseudonames for pack/unpack functions from the base
  package
* I - simplest native Perl-coding of UInt32 sequences such as [12,70819,1e+6]
* II - native Perl implementation for Array of Arrays of UInt32, such as [[12,70819,1e+6],[167657,890]]
* B64 - Base64 coding/decoding, uses MIME::Base64 as base (contains XS code)
* Z - compressing with Compress::Zlib

To write your own Tag decoder/encoder you must create package Tag::DeCoder::{TAG} where TAG name is 1 to 3
characters long and may contain only this symbols: [A-Z] for the first letter, [A-Z0-9] for the rest 1 or 2 symbols.
Your coder must be written as object class and must implement only 2 basic methods: "encode" and "decode".
It may implement other methods as well.

# LICENSE

Copyright (C) Andrey A. Konovalov.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Andrey A. Konovalov <drvtiny@gmail.com>
