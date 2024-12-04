use warnings;
use 5.020;
use true;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable::Role::Plugin {

    # ABSTRACT: Plugin role for Data::Section::Pluggable

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 extensions

=head2 process_content

=cut

    use Role::Tiny;

    requires 'extensions';
    requires 'process_content';

}

=head1 SEE ALSO

=over 4

=item L<Data::Section::Pluggable>

=back

=cut
