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

done_testing;
