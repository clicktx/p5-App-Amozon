use strict;
use File::Basename qw(dirname);
my $basedir =
  File::Spec->rel2abs( File::Spec->catdir( dirname(__FILE__), '..' ) );
my $log_dir = File::Spec->catdir( $basedir, 'log' );

+{
    # logging setting
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
};
