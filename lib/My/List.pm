package My::List;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {head => $_[0]};
    bless $self, $class;
    return $self;
}

sub head {
    my $self = shift;
    $self->{head};
}

1;
