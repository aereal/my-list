package My::List;
use strict;
use warnings;

use base 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw/head tail/);

sub new {
    my ($class, $head, @rest) = @_;
    $class->SUPER::new({
        head => $head,
        tail => @rest == 0 ? undef : $class->new(@rest)
    });
}

1;
