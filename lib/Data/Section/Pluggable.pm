use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable {

    # ABSTRACT: Read structured data from __DATA__

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head2 package

=cut

    use Class::Tiny qw( package );
    use Exporter qw( import );

    our @EXPORT_OK = qw( get_data_section );

    sub BUILDARGS ($class, @args) {
        if(@args == 1) {
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

 get_data_section;
 get_data_section $name;
 $dsp->get_data_section;
 $dsp->get_data_section($name);

=cut

    sub get_data_section {
        my $self = ref $_[0] ? shift : __PACKAGE__->new(scalar caller);
        if (@_) {
            my $all = $self->get_data_section;
            return undef unless $all;
            return $all->{$_[0]};
        } else {
            my $d = do { no strict 'refs'; \*{$self->{package}."::DATA"} };
            return undef unless defined fileno $d;
            seek $d, 0, 0;
            my $content = do { local $/; <$d> };
            $content =~ s/^.*\n__DATA__\n/\n/s; # for win32
            $content =~ s/\n__END__\n.*$/\n/s;
            my @data = split /^@@\s+(.+?)\s*\r?\n/m, $content;
            shift @data; # trailing whitespaces
            my $all = {};
            while (@data) {
                my ($name, $content) = splice @data, 0, 2;
                $all->{$name} = $content;
            }
            return $all;
        }
    }
}

1;

