use strict;
use warnings;
use utf8;
use t::Util;
use Test::More;

my $c = Markets->bootstrap();

subtest 'Data hello' => sub {
    my $res = $c->model('Data::Foo')->hello;
    is $res, 'hello';
};

done_testing;
