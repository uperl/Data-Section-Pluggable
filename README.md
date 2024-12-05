# Data::Section::Pluggable ![static](https://github.com/uperl/Data-Section-Pluggable/workflows/static/badge.svg) ![linux](https://github.com/uperl/Data-Section-Pluggable/workflows/linux/badge.svg)

Read structured data from \_\_DATA\_\_

# SYNOPSIS

```perl
use Data::Section::Pluggable;

my $dsp = Data::Section::Pluggable->new
                                  ->add_plugin('trim')
                                  ->add_plugin('json');

# prints "Welcome to Perl" without prefix
# or trailing white space.
say $dsp->get_data_section('hello.txt');

# also prints "Welcome to Perl"
say $dsp->get_data_section('hello.json')->{message};

# prints "This is base64 encoded.\n"
say $dsp->get_data_section('hello.bin');

__DATA__

@@ hello.txt
  Welcome to Perl


@@ hello.json
{"message":"Welcome to Perl"}

@@ hello.bin (base64)
VGhpcyBpcyBiYXNlNjQgZW5jb2RlZC4K
```

# DESCRIPTION

Data::Section::Simple is a module to extract data from `__DATA__` section of Perl source file.
This module started out as a fork of [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple) (itself based on [Mojo::Loader](https://metacpan.org/pod/Mojo::Loader)),
and includes some of its tests to ensure compatibility, but it also includes features not
available in either of those modules.

This module caches the result of reading the `__DATA__` section in the object if you use the OO
interface.  It doesn't do any caching of the processing required of "formats" (see below).

This module also supports `base64` encoding using the same mechanism as [Mojo::Loader](https://metacpan.org/pod/Mojo::Loader), which
is helpful for putting binary sections in `__DATA__`.

As mentioned, this module aims to be and is largely a drop in replacement for [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple)
with some extra features.  Here are the known ways in which it is not compatible:

- Because [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple) does not support `base64` encoded data, these data sections
would include the ` (base64)` in the filename instead of decoding the content.
- When a section is not found [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple) return the empty list from `get_data_section`,
where as this module returns `undef`, in order to keep the return value more consistent.

# CONSTRUCTOR

```perl
my $dsp = Data::Section::Pluggable->new($package);
my $dsp = Data::Section::Pluggable->new(\%attributes);
my $dsp = Data::Section::Pluggable->new(%attributes);
```

# ATTRIBUTES

## package

The name of the package to read from `__DATA__`.  If not specified, then
the current package will be used.

# METHODS

## get\_data\_section

```perl
my $hash = get_data_section;
my $data = get_data_section $name;
my $hash = $dsp->get_data_section;
my $data = $dsp->get_data_section($name);
```

Gets data from `__DATA_`.  This can be called either as a function (which is
optionally exported from this module), or as an object method.  Creating an
instance of [Data::Section::Pluggable](https://metacpan.org/pod/Data::Section::Pluggable) allows you to use packages other than
the default or use plugins.

## add\_format

```perl
$dsp->add_format( $ext, sub ($dsp, $content) { return ... } );
```

Adds a content processor to the given filename extension.  The extension should be a filename
extension without the `.`, for example `txt` or `json`.

The callback takes the [Data::Section::Pluggable](https://metacpan.org/pod/Data::Section::Pluggable) instance as its first argument and the content
to be processed as the second.  This callback should return the processed content as a scalar.

You can chain multiple content processors to the same filename extension, and they will be
called in the order that they were added.

## add\_plugin

```
$dsp->add_plugin( $name, %args );
```

Applies the plugin with `$name`.  If the plugin supports instance mode (that is: it has a constructor
named `new`), then `%args` will be passed to the constructor.  For included plugins see ["CORE PLUGINS"](#core-plugins).
To write your own see ["PLUGIN ROLES"](#plugin-roles).

# CORE PLUGINS

## json

Automatically decode json into Perl data structures.
See [Data::Section::Pluggable::Plugin::Json](https://metacpan.org/pod/Data::Section::Pluggable::Plugin::Json).

## trim

Automatically trim leading and trailing white space.
See [Data::Section::Pluggable::Plugin::Trim](https://metacpan.org/pod/Data::Section::Pluggable::Plugin::Trim).

# PLUGIN ROLES

## ContentProcessorPlugin

Used for adding content processors for specific formats.  This
is essentially a way to wrap the [add\_format method](#add_format)
as a module.

# SEE ALSO

These are some alternative modules that do a similar thing, each
with their own feature set and limitations.

- [Data::Section](https://metacpan.org/pod/Data::Section)
- [Data::Section::Simple](https://metacpan.org/pod/Data::Section::Simple)
- [Data::Section::Writer](https://metacpan.org/pod/Data::Section::Writer)
- [Mojo::Loader](https://metacpan.org/pod/Mojo::Loader)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2024 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
