use strict;
use warnings;

use Test::More;
use Test::Exception;

use feature qw(signatures);
no warnings qw(experimental::signatures);
use Experimental::Signatures::EnhancedWarnings;

sub thing($a, $b) { return $a + $b }
sub other($a, %) { return $a }

throws_ok
	{ thing(1); }
	qr/Too few arguments for subroutine at .*\.t line 15/,
	"Too few error appears in correct file/line";
;

throws_ok
	{ thing(1, 2, 3); }
	qr/Too many arguments for subroutine at .*\.t line 21/,
	"Too many error appears in correct file/line";
;

throws_ok
	{ other(1, 2); }
	qr/Odd name\/value argument for subroutine at .*\.t line 27/,
	"Odd name/value error appears in correct file/line";
;

# Hopefully we aren't butchering all warnings
sub oops { die "Hello"; }

throws_ok
	{ oops(); }
	qr/Hello at .*\.t line 33/,
	"Other errors appear in their proper place";

done_testing;
