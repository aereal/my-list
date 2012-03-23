package test::My::List::Iterator;
use strict;
use warnings;
use base qw(Test::Class);
use 5.010;
use Test::More;
use Test::Fatal qw/exception lives_ok/;
use Test::Name::FromLine;

use lib '../lib';

use My::List;
use My::List::Iterator;

subtest initialize => sub {
    subtest without_list => sub {
        like exception { My::List::Iterator->new }, qr/My::List should be given/;
    };

    subtest with_list => sub {
        lives_ok { My::List::Iterator->new(My::List->new) };

        my $list = My::List->new;
        my $iterator = My::List::Iterator->new($list);
        is $iterator->list, $list;
    };
};

subtest has_next => sub {
    subtest given_list_with_no_elements => sub {
        my $list = My::List->new;
        my $iterator = My::List::Iterator->new($list);
        ok not $iterator->has_next;
    };

    subtest given_with_one_element => sub {
        my $list = My::List->new('x');
        my $iterator = My::List::Iterator->new($list);
        ok $iterator->has_next;
    };

    subtest given_list_with_many_elements => sub {
        my $list = My::List->new(1..10);
        my $iterator = My::List::Iterator->new($list);
        ok $iterator->has_next;
    };
};

subtest next => sub {
    subtest not_have_next_value => sub {
        my $list = My::List->new;

        subtest yield_value => sub {
            my $iterator = My::List::Iterator->new($list);

            like exception { $iterator->next }, qr/Reached end of iterator/;
        };
    };

    subtest have_next_value => sub {
        my $list = My::List->new('a', 'b', 'c');

        subtest yield_value => sub {
            my $iterator = My::List::Iterator->new($list);

            is_deeply [$iterator->list->head], ['a'];

            my $yielded = $iterator->next;
            is_deeply [$yielded], ['a'], 'Yield a value';

            is_deeply [$iterator->list->head], ['b'], 'Then iterated';
        };
    };
};

done_testing;
