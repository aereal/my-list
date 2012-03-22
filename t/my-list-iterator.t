package test::My::List::Iterator;
use strict;
use warnings;
use base qw(Test::Class);
use 5.010;
use Test::More;
use Test::Exception;
use Test::Name::FromLine;

use lib '../lib';

use My::List;
use My::List::Iterator;

subtest initialize => sub {
    subtest without_list => sub {
        throws_ok { My::List::Iterator->new } qr/My::List should be given/;
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

done_testing;
