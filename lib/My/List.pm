package My::List;
use strict;
use warnings;

sub new {
    my $class = shift;
    my ($head, @rest) = @_;
    my $self = {head => $head, tail => @rest == 0 ? undef : $class->new(@rest)};
    bless $self, $class;
    return $self;
}

sub head {
    my $self = shift;
    $self->{head};
}

sub tail {
    my $self = shift;
    $self->{tail};
}

1;
