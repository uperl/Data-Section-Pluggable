# Data::Section::Pluggable ![static](https://github.com/uperl/Data-Section-Pluggable/workflows/static/badge.svg) ![linux](https://github.com/uperl/Data-Section-Pluggable/workflows/linux/badge.svg)

Read structured data from \_\_DATA\_\_

# SYNOPSIS

# DESCRIPTION

# CONSTRUCTOR

```perl
my $dsp = Data::Section::Pluggable->new($package);
my $dsp = Data::Section::Pluggable->new(\%attributes);
my $dsp = Data::Section::Pluggable->new(%attributes);
```

# ATTRIBUTES

## package

# METHODS

## get\_data\_section

```perl
my $hash = get_data_section;
my $data = get_data_section $name;
my $hash = $dsp->get_data_section;
my $data = $dsp->get_data_section($name);
```

## add\_format

```
$dsp->add_format( $ext, $cb );
```

## add\_plugin

```
$dsp->add_plugin( $name, %args );
```

# SEE ALSO

- [Data::Section](https://metacpan.org/pod/Data::Section)
- [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple)
- [Data::Section::Writer](https://metacpan.org/pod/Data::Section::Writer)
- [Mojo::Loader](https://metacpan.org/pod/Mojo::Loader)
- [Data::Section::Pluggable::Plugin::Json](https://metacpan.org/pod/Data::Section::Pluggable::Plugin::Json)
- [Data::Section::Pluggable::Role::Plugin](https://metacpan.org/pod/Data::Section::Pluggable::Role::Plugin)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2024 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
