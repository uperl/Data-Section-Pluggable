use Test2::V0 -no_srand => 1;
use Data::Section::Pluggable;

is(
    Data::Section::Pluggable->new,
    object {
        prop isa => 'Data::Section::Pluggable';
        call package => 'main';
        call [get_data_section => 'foo.txt'] => "hello world\n";
        call get_data_section => hash {
            field 'foo.txt' => "hello world\n";
            etc;
        };
    },
    'all defaults',
);

is(
    Data::Section::Pluggable->new("Foo"),
    object {
        prop isa => 'Data::Section::Pluggable';
        call package => 'Foo';
    },
    'constructor with scalar',
);

is(
    Data::Section::Pluggable->new(package => "Foo"),
    object {
        prop isa => 'Data::Section::Pluggable';
        call package => 'Foo';
    },
    'constructor with hash',
);

is(
    Data::Section::Pluggable->new({ package => "Foo" }),
    object {
        prop isa => 'Data::Section::Pluggable';
        call package => 'Foo';
    },
    'constructor with hash ref',
);

done_testing;

__DATA__
@@ foo.txt
hello world
__END__
