
use strict;
use warnings;
use ExtUtils::MakeMaker;

eval {
    use ExtUtils::MakeMaker::Coverage;

    ExtUtils::MakeMaker::Coverage->config->cover_pod(0);
};

WriteMakefile(
              NAME          => 'DBIx::InsertHash',
              AUTHOR        => 'Uwe Voelker <uwe.voelker@gmx.de>',
              VERSION_FROM  => 'lib/DBIx/InsertHash.pm',
              ABSTRACT_FROM => 'lib/DBIx/InsertHash.pm',
              PL_FILES      => {},
              PREREQ_PM     => {'Test::Deep' => 0,
                                'Test::More' => 0,
                               },
              dist          => {COMPRESS => 'gzip -9f',
                                SUFFIX   => 'gz',
                               },
              clean         => {FILES => 'lib/DBIx/InsertHash.pm-*'
                               },
             );
