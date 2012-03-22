package My::List::Iterator;
use strict;
use warnings;
use base 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw/list/);

sub new {
    my ($class, $list) = @_;
    die "The instance of My::List should be given" unless defined($list) && ref($list) eq 'My::List';
    $class->SUPER::new({list => $list});
}

sub has_next {
    my $self = shift;
    !$self->list->is_empty;
}

sub next {
    my $self = shift;
    if ($self->has_next) {
        my $yielded = $self->list->head;
        $self->list($self->list->tail);
        $yielded;
    } else {
        die "Reached end of iterator";
    }
}

1;
