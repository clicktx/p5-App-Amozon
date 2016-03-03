requires 'Amon2', '6.12';
requires 'Amon2::Util';
requires 'Amon2::Web';
requires 'Amon2::Web::Dispatcher::RouterBoom';
requires 'Crypt::CBC';
requires 'Crypt::Rijndael';
requires 'DBI';
requires 'File::ShareDir';
requires 'Getopt::Long';
requires 'HTTP::Session2::ClientStore2';
requires 'Module::Build';
requires 'Module::Find';
requires 'Module::Functions', '2';
requires 'Plack::App::File';
requires 'Plack::Builder';
requires 'Plack::Loader';
requires 'Plack::Session::Store::DBI';
requires 'Router::Boom', '0.06';
requires 'Starlet', '0.20';
requires 'Teng';
requires 'Teng::Row';
requires 'Teng::Schema::Declare';
requires 'Text::Xslate', '2.0009';
requires 'parent';
requires 'perl', '5.010_001';

on configure => sub {
    requires 'Module::Build', '0.38';
    requires 'Module::CPANfile', '0.9010';
};

on test => sub {
    requires 'Test::More', '0.98';
};
