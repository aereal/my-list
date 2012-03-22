package test::My::List;
use strict;
use warnings;
use base qw(Test::Class);
use 5.010;
use Test::More;
use Test::Name::FromLine;
use Test::Exception;

use lib '../lib';

use My::List;

subtest initialize => sub {
    new_ok 'My::List';
};

subtest head => sub {
    subtest given_with_no_elements => sub {
        my $list = My::List->new;
        is $list->head, undef;
    };

    subtest given_with_1_element => sub {
        my $given = 0;
        my $list = My::List->new($given);
        is $list->head, $given;
    };

    subtest given_with_many_elements => sub {
        my $given_array = [0..10];
        my $list = My::List->new(@$given_array);
        is $list->head, $given_array->[0];
    };
};

subtest tail => sub {
    subtest given_with_no_elements => sub {
        my $list = My::List->new;
        ok $list->tail->is_nil;
    };

    subtest given_with_1_element => sub {
        my $given = 0;
        my $list = My::List->new($given);
        ok $list->tail->is_nil;
    };

    subtest given_with_many_elements => sub {
        my $given_array = [0..10];
        my $list = My::List->new(@$given_array);
        is ref($list->tail), 'My::List', 'should be a instance of My::List';
    };
};

subtest is_nil => sub {
    subtest given_nil => sub {
        my $nil = My::List->nil;
        ok $nil->is_nil;
    };

    subtest given_with_no_elements => sub {
        my $list = My::List->new;
        ok not $list->is_nil;
    };

    subtest given_with_1_element => sub {
        my $given = 'a';
        my $list = My::List->new($given);
        ok not $list->is_nil;
    };

    subtest given_with_many_elements => sub {
        my $given_array = [0..10];
        my $list = My::List->new(@$given_array);
        ok not $list->is_nil;
    };
};

subtest is_empty => sub {
    subtest given_with_no_elements => sub {
        my $list = My::List->new;
        ok $list->is_empty;
    };

    subtest given_with_1_element => sub {
        my $list = My::List->new('a');
        ok not $list->is_empty;
    };
};

subtest has_next => sub {
    subtest given_with_no_elements => sub {
        my $list = My::List->new;
        ok not $list->has_next;
    };

    subtest given_with_1_element => sub {
        my $list = My::List->new('a');
        ok not $list->has_next;
    };

    subtest given_with_many_elements => sub {
        my $list = My::List->new(1..10);
        ok $list->has_next;
    };
};

subtest build => sub {
    subtest given_one_arg => sub {
        throws_ok { My::List->build('a') } qr/Can't build/;
    };

    subtest given_two_args => sub {
        subtest second_is_my_list => sub {
            lives_ok { My::List->build('hoge', My::List->nil) };
        };

        subtest second_is_not_my_list => sub {
            throws_ok { My::List->build('fuga', 'hoge') } qr/Can't build/;
        };
    };
};

subtest iterator => sub {
    my $list = My::List->new;
    cmp_ok ref($list->iterator), 'eq', 'My::List::Iterator';
    is $list->iterator->list, $list;
};

subtest map => sub {
    my $callback = sub { scalar($_[0]) };

    subtest given_nil => sub {
        my $list = My::List->nil;

        is $list->map($callback), $list;
    };

    subtest given_empty => sub {
        my $list = My::List->new;

        is $list->map($callback), $list;
    };

    subtest given_with_some_elements => sub {
        my $list = My::List->new(1, 2, 3);

        is_deeply [$list->map(sub { $_[0] * 2 })->head], [My::List->new(2, 4, 6)->head];
    };
};

done_testing;
