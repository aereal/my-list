package test::My::List;
use strict;
use warnings;
use base qw(Test::Class);
use 5.010;
use Test::More;
use Test::Name::FromLine;

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

done_testing;
