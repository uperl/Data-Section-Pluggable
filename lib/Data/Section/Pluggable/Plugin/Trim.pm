use warnings;
use 5.020;
use true;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable::Plugin::Trim {

    # ABSTRACT: Data::Section::Pluggable plugin that trims whitespace

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO

=over 4

=item L<Data::Section::Pluggable>

=item L<Data::Section::Pluggable::Role::ContentProcessorPlugin>

=back

=cut

    use Class::Tiny qw( extensions );
    use Role::Tiny::With;
    use Ref::Util qw( is_arrayref );

    with 'Data::Section::Pluggable::Role::ContentProcessorPlugin';

    sub BUILD ($self, $) {
        if(defined $self->extensions) {
            $self->extensions([$self-extensions]) unless is_arrayref $self->extensions;
        } else {
            $self->extensions(['txt']);
        }
    }

    sub process_content ($self, $dsp, $content) {
        return $content =~ s/^\s*//r =~ s/\s*\z//r;
    }
}
