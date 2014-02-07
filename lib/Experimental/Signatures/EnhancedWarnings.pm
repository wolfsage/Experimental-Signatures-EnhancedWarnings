package Experimental::Signatures::EnhancedWarnings;
# ABSTRACT - Make Perl 5.20 signatures more useful
use 5.019009;

use strict;
use warnings;

require Exporter;
use AutoLoader;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Experimental::Signatures::EnhancedWarnings', $VERSION);

1;
__END__

=head1 NAME

Experimental::Signatures::EnhancedWarnings - Make Perl 5.20 signature warnings more useful

=head1 SYNOPSIS

  use feature qw(signatures);
  no warnings 'experimental::signatures';
  use Experimental::Signatures::EnhancedWarnings;

  # Proceed as normal...

=head1 DESCRIPTION

Currently, warnings from subs with signatures show incorrect file/line numbers
(the file/line where the sub was defined, NOT where it was called from.) This
module attempts to remedy that by injecting itself into calls to Perl_pp_die(),
and checking for one of the three errors that signatures may throw:

=over 4

=item *

Too few arguments for subroutine

=item *

Too many arguments for subroutine

=item *

Odd name/value argument for subroutine

=back

B<warning:> This means that if you manually call C<die()> with any of the three warnings
above, your errors may report incorrect information.

=head1 SEE ALSO

See L<perlsub/"Signatures"> for more information about signatures.

=head1 AUTHOR

Matthew Horsfall (alh) - <wolfsage@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Matthew Horsfall

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
