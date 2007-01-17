package DBIx::InsertHash;
$VERSION = 0.002;

=head1 NAME

DBIx::InsertHash - insert/update a database record with a hash

=head1 VERSION

This document describes DBIx::InsertHash version 0.002

=head1 SYNOPSIS

    use DBIx::InsertHash;

    DBIx::InsertHash->insert($dbh, 'table',
                             {USERNAME => 'foo',
                              PASSWORD => 'bar',
                             });

    ###TODO### update() is coming in the next version

=cut

use strict;
use warnings;

=head1 DESCRIPTION

If you have data in a hash (which keys are matching the column names) and
want to insert it in a database, then this is the right module for you.
It frees you from having to construct the SQL statement.

=head1 INTERFACE

=head2 insert

Insert hash in database.

=over 4

=item dbh

DBI database handle (you have to L<connect|DBI/connect> yourself).

=item table

Table name.

=item hash

Data hash. The keys have to match with the column names of your table.

=back

=cut

sub insert {
    my ($class, $dbh, $table, $data) = @_;

    my $sql = 'INSERT INTO '.$table.' (';
    $sql .= join(', ', map { '`'.$_.'`' } keys %$data).') VALUES (';
    $sql .= join(', ', ('?') x (scalar keys %$data)).')';

    $dbh->do($sql, {}, values %$data);

    return $dbh->last_insert_id(undef, undef, $table, undef);
}


1;

=head1 AUTHOR

Uwe Voelker, <uwe.voelker@gmx.de>

