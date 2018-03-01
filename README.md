# NAME

Tag::DeCoder - Serialization/Deserialization with

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

# LICENSE

Copyright (C) Andrey A. Konovalov.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Andrey A. Konovalov <drvtiny@gmail.com>
