package My::List::Iterator;
use strict;
use warnings;

sub new {
    my ($class) = shift;
    my $self = {collection => shift};
    bless $self, $class;
    return $self;
}

sub has_next {
    return scalar(shift->{collection});
}

1;
