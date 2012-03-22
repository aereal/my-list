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
    subtest no_element_given => sub {
        my $iterator = My::List::Iterator->new();
        ok not $iterator->has_next;
    };

    subtest element_given => sub {
        my $iterator = My::List::Iterator->new(1);
        ok $iterator->has_next;
    };
};

done_testing;
