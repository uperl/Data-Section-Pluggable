use warnings;
use 5.020;
use true;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable::Plugin::Json {

    # ABSTRACT: Data::Section::Pluggable Plugin for JSON

=head1 SYNOPSIS

# EXAMPLE: examples/json.pl

=head1 DESCRIPTION

This plugin decodes json from C<__DATA__>.  It only applies to
filenames with the C<.json> extension.  Under the covers it uses
L<JSON::MaybeXS> so it is recommended that you also install
L<Cpanel::JSON::XS> for better performance.

=head1 SEE ALSO

=over 4

=item L<Data::Section::Pluggable>

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
