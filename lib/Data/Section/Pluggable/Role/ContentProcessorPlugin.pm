use warnings;
use 5.020;
use true;
use experimental qw( signatures );
use stable qw( postderef );

package Data::Section::Pluggable::Role::ContentProcessorPlugin {

    # ABSTRACT: Plugin role for Data::Section::Pluggable to process content

=head1 SYNOPSIS

Instance mode:

# EXAMPLE: examples/content_processor_plugin.pl

Class mode:

# EXAMPLE: examples/content_processor_plugin_class.pl

=head1 DESCRIPTION

This plugin role provides a simple wrapper mechanism around
the L<Data::Section::Pluggable> L<method add_format|/add_format>,
making it an appropriate way to add such recipes to CPAN.

=head1 CONSTRUCTOR

=head1 new

 my $class->new(%args);  # optional

If a constructor C<new> is provided, it will be called when the plugin
is added to create an instance of the plugin.  The methods below will
be called as instance methods.  Otherwise the methods will be called
as class methods.

=head1 METHODS

All methods are to be implemented by your class.

=head2 extensions

 my @extensions = $plugin->extensions;
 my \@extensions = $plugin->extensions;

Returns a list or array reference of filename extensions the plugin
should apply to.

=head2 process_content

 my $processed = $plugin->process_content($dsp, $content);

Takes the L<Data::Section::Pluggable> instance and content and returns
the process content.

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
