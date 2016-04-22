# fork from https://github.com/clicktx/p5-Amon2-Plugin-LogHandler
package Amozon::Log;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Log::Handler;
use Amon2::Util ();

sub init {
    my ( $class, $c, $config ) = @_;

    my $conf = $c->config->{'Log::Handler'}
      || die
"missing configuration for LogHandler plugin(\$c->{'Log::Handler'} is undefined)";
    my $logger = Log::Handler->new();

    if ( $ENV{PLACK_ENV} && $ENV{PLACK_ENV} eq 'production' ) {
        delete $conf->{screen};
        delete $conf->{file}->{'debug'};
    }
    $logger->config( config => $conf ) or die $logger->errstr;
    Amon2::Util::add_method(
        $c, 'log',
        sub {
            $SIG{__WARN__} = sub { $logger->log( warn => @_ ) };
            $SIG{__DIE__} = sub { $logger->trace( emergency => @_ ) };
            $logger;
        },
    );
    Amon2::Util::add_method( $c, 'debug', sub { shift->log->debug(shift) }, );
}

1;
__END__

=encoding utf-8

=head1 NAME

Amon2::Plugin::LogHandler - Log::Handler glue for Amon2

=head1 SYNOPSIS

    use Amon2::Plugin::LogHandler;
    __PACKAGE__->load_plugin('LogHandler');
    
    # in your config.pl
    my $basedir =
      File::Spec->rel2abs( File::Spec->catdir( dirname(__FILE__), '..' ) );
    my $log_dir = File::Spec->catdir( $basedir, 'var', 'log' );

    'Log::Handler' => {
        screen => {
            log_to   => "STDOUT",
            maxlevel => "debug",
            minlevel => "emergency",
        },
        file => {
            default => {
                mode => "append",
            },
            debug => {
                filename => [ $log_dir, "debug.log" ],
                maxlevel => "debug",
                minlevel => "emergency",
            },
            common => {
                filename => [ $log_dir, "common.log" ],
                maxlevel => "info",
                minlevel => "warn",
            },
            error => {
                filename => [ $log_dir, "error.log" ],
                maxlevel => "warn",
                minlevel => "emergency",
            },
        },
    },
    
    # in your controller
    $c->log->info('message info');
    $c->debug('debug message'); #debug is alies
    

=head1 DESCRIPTION

Amon2::Plugin::LogHandler is glue for L<Amon2>. This module is L<Amon2::Plugin::LogDispach> forked product.

=head1 SEE ALSO

L<Amon2> L<Log::Handler>

=head1 LICENSE

Copyright (C) clicktx.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

clicktx E<lt>clicktx@gmail.comE<gt>

=cut
