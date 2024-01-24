package SortKey::Num::similarity;

use 5.010001;
use strict;
use warnings;

use Text::Levenshtein::XS;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return +{
        v => 1,
        args => {
            string => {schema=>'str*', req=>1},
            ci => {schema => 'bool*'},
        },
    };
}

sub gen_keygen {
    my %args = @_;

    my $reverse = $args{reverse};
    my $ci = $args{ci};

    sub {
        $args{ci} ? Text::Levenshtein::XS::distance(lc($args{string}), lc($_[0])) : Text::Levenshtein::XS::distance($args{string}, $_[0]);
    };
}

1;
# ABSTRACT: Similarity to a reference string as sort key

=for Pod::Coverage ^(meta|gen_comparer)$

=head1 SYNOPSIS

Use with L<Sort::Key>:

 use Sort::Key qw(nkeysort);
 use SortKey::Num::similarity;

 my $keygen = SortKey::Num::similarity::gen_keygen(string => 'foo');
 my @sorted = &nkeysort($keygen, "food", "foolish", "foo", "bar");
 # => ("foo","food","bar","foolish")


=head1 DESCRIPTION

=cut
