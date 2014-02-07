use 5.019009;
use ExtUtils::MakeMaker 6.30;

WriteMakefile(
    NAME              => 'Experimental::Signatures::EnhancedWarnings',
    VERSION_FROM      => 'lib/Experimental/Signatures/EnhancedWarnings.pm',
    ABSTRACT_FROM     => 'lib/Experimental/Signatures/EnhancedWarnings.pm',
    AUTHOR            => 'Matthew Horsfall (alh) <wolfsage@gmail.com>',
    BUILD_REQUIRES    => {},
    CONFIGURE_REQUIRES => {
      'ExtUtils::MakeMaker' => '6.30',
    },
    TEST_REQUIRES => {
      'Test::Exception' => 0,
      'Test::More'      => '0.88',
    },
    test => {
      TESTS => 't/*.t',
    },
);
