use strict;
use warnings;
use Test::More;

use Markets;
use Markets::Web;
use Markets::Web::Dispatcher;
use Markets::Web::C::Root;
use Markets::Web::C::Account;
use Markets::Web::ViewFunctions;
use Markets::Web::View;
use Markets::Admin;
use Markets::Admin::Dispatcher;
use Markets::Admin::C::Root;
use Markets::Admin::ViewFunctions;
use Markets::Admin::View;

pass "All modules can load.";

done_testing;
