package My::List;
use strict;
use warnings;

use base 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw/head tail/);

my $nil = bless { head => undef, tail => undef };

sub nil {
    $nil;
}

sub new {
    my ($class, $head, @rest) = @_;
    $class->SUPER::new({
        head => $head,
        tail => @rest == 0 ? $nil : $class->new(@rest)
    });
}

sub is_nil {
    my $self = shift;
    $self == $nil;
}
}

1;
