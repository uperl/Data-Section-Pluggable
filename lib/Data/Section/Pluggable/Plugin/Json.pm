use warnings;
use 5.020;
use true;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable::Plugin::Json {

    # ABSTRACT: Data::Section::Pluggable Plugin for JSON

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO

=over 4

=item L<Data::Section::Pluggable>

=item L<Data::Section::Pluggable::Role::ContentProcessorPlugin>

=back

=cut

    use Role::Tiny::With;
    use JSON::MaybeXS ();

    with 'Data::Section::Pluggable::Role::ContentProcessorPlugin';

    sub extensions ($class) {
        return ('json');
    }

    sub process_content ($class, $dsp, $content) {
        JSON::MaybeXS::decode_json($content);
    }
}
