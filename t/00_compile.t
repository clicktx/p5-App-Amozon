use strict;
use warnings;
use Test::More;

use Amozon;
use Amozon::Web;
use Amozon::Web::Dispatcher;
use Amozon::Web::C::Root;
use Amozon::Web::C::Account;
use Amozon::Web::ViewFunctions;
use Amozon::Web::View;
use Amozon::Admin;
use Amozon::Admin::Dispatcher;
use Amozon::Admin::C::Root;
use Amozon::Admin::ViewFunctions;
use Amozon::Admin::View;

pass "All modules can load.";

done_testing;
