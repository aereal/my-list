package test::My::List::Iterator;
use strict;
use warnings;
use base qw(Test::Class);
use 5.010;
use Test::More;
use Test::Name::FromLine;

use lib '../lib';

use My::List::Iterator;

subtest initialize => sub {
    new_ok 'My::List::Iterator';
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
