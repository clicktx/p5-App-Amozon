package Amozon::Admin::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use Module::Find qw(useall);

# Load all controller classes at loading time.
useall('Amozon::Admin::C');

base 'Amozon::Admin::C';

get '/' => 'Root#index';
post '/reset_counter' => 'Root#reset_counter';


1;
