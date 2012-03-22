package My::List;
use strict;
use warnings;
use My::List::Iterator;

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

sub build {
    my ($class, $head, $tail) = @_;
    die "Can't build" unless defined($tail) && ref($tail) eq __PACKAGE__;
    $class->SUPER::new({
        head => $head,
        tail => $tail
    });
}

sub is_nil {
    my $self = shift;
    $self == $nil;
}

sub is_empty {
    my $self = shift;
    !defined $self->head;
}

sub has_next {
    my $self = shift;
    !$self->tail->is_nil;
}

sub iterator {
    my $self = shift;
    My::List::Iterator->new($self);
}

sub map {
    my ($self, $callback) = @_;
    if ($self->is_empty) {
        $self
    } else {
        My::List->build($callback->($self->head), $self->tail->map($callback));
    }
}

sub each {
    my ($self, $callback) = @_;
    unless ($self->is_empty) {
        my $iterator = $self->iterator;
        $callback->($iterator->next) while $iterator->has_next;
    }
    $self;
}

sub reduce {
    my ($self, $callback, $memo) = @_;
    if ($self->tail->is_nil) {
        $callback->($self->head, $memo);
    } else {
        $callback->($self->head, $self->tail->reduce($callback, $memo));
    }
}

1;
