use strict;
use Data::Section::Pluggable qw(get_data_section);
use Test::More;

is get_data_section('foo.html'), undef, 'Do not die.';

done_testing;
