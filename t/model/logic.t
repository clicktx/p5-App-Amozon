use strict;
use warnings;
use utf8;
use t::Util;
use Test::More;

my $c = Markets->bootstrap();

subtest 'Logic hoge' => sub {
    my $res = $c->model('Logic::Hoge')->hoge;
    is $res, 'hoge';
};

done_testing;
