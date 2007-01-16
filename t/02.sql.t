
use strict;
use warnings;

use Test::More tests => 4;
use Test::Deep;

use DBIx::InsertHash;


{
    package DBIx::InsertHash::DBI;

    sub new {
        my ($class) = @_;

        return bless {}, $class;
    }

    sub do {
        my ($self, $sql, $opt, @val) = @_;

        $self->{sql} = $sql;
        $self->{opt} = $opt;
        $self->{val} = \@val;
    }

    sub last_insert_id {
        my ($self, @arg) = @_;

        return 999;
    }
}

my $dbh = DBIx::InsertHash::DBI->new;

my $id = DBIx::InsertHash->insert($dbh, 'TABLE_NAME',
                                  {abc => 123,
                                  },
                                 );

is($id, 999, 'ID');
is($dbh->{sql}, 'INSERT INTO TABLE_NAME (`abc`) VALUES (?)', 'SQL');
cmp_bag($dbh->{val}, [123], 'values');


DBIx::InsertHash->insert($dbh, 'TABLE_NAME',
                         {abc => 123,
                          def => 456,
                         },
                        );

cmp_bag($dbh->{val}, [123, 456], 'multiple values');

