use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable {

    # ABSTRACT: Read structured data from __DATA__

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 CONSTRUCTOR

 my $dsp = Data::Section::Pluggable->new($package);
 my $dsp = Data::Section::Pluggable->new(\%attributes);
 my $dsp = Data::Section::Pluggable->new(%attributes);

=head1 ATTRIBUTES

=head2 package

=cut

    use Class::Tiny qw( package );
    use Exporter qw( import );
    use Ref::Util qw( is_ref is_plain_hashref );

    our @EXPORT_OK = qw( get_data_section );

    sub BUILDARGS ($class, @args) {
        if(@args == 1) {
            return $args[0] if is_plain_hashref $args[0];
            return { package => $args[0] };
        } else {
            my %args = @args;
            return \%args;
        }
    }

    sub BUILD ($self, $) {
        unless(defined $self->package) {
            my $package = caller 2;
            $self->package($package);
        }
    }

=head1 METHODS

=head2 get_data_section

 my $hash = get_data_section;
 my $data = get_data_section $name;
 my $hash = $dsp->get_data_section;
 my $data = $dsp->get_data_section($name);

=cut

    sub get_data_section ($self=undef, $name=undef) {

        # handle being called as a function instead of
        # a method.
        unless(is_ref $self) {
            $name = $self;
            $self = __PACKAGE__->new(scalar caller);
        }

        my $all = $self->_get_all_data_sections;
        return undef unless $all;

        if (defined $name) {
            if(exists $all->{$name}) {
                return $all->{$name};
            }
            return undef;
        } else {
            return $all;
        }
    }

    sub _get_all_data_sections ($self) {
        my $fh = do { no strict 'refs'; \*{$self->package."::DATA"} };

        return undef unless defined fileno $fh;

        # Question: does this handle corner case where perl
        # file is just __DATA__ section?
        seek $fh, 0, 0;
        my $content = do { local $/; <$fh> };
        $content =~ s/^.*\n__DATA__\n/\n/s; # for win32
        $content =~ s/\n__END__\n.*$/\n/s;

        my @data = split /^@@\s+(.+?)\s*\r?\n/m, $content;

        # trailing whitespace
        shift @data;

        my $all = {};
        while (@data) {
            my ($name_encoding, $content) = splice @data, 0, 2;
            my ($name, $encoding);
            if($name_encoding =~ /^(.*)\s+\((.*?)\)\Z/) {
                $name = $1;
                $encoding = $2;
            } else {
                $name = $name_encoding;
            }
            $all->{$name} = $content;
        }

        return $all;
    }
}

1;

