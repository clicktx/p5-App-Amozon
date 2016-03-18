package Markets;
use strict;
use warnings;
use utf8;
our $VERSION='0.01';
use 5.008001;
use Markets::DB::Schema;
use Markets::DB;

use parent qw/Amon2/;
# Enable project local mode.
__PACKAGE__->make_local_context();

my $schema = Markets::DB::Schema->instance;

sub db {
    my $c = shift;
    if (!exists $c->{db}) {
        my $conf = $c->config->{DBI}
            or die "Missing configuration about DBI";
        $c->{db} = Markets::DB->new(
            schema       => $schema,
            connect_info => [@$conf],
            # I suggest to enable following lines if you are using mysql.
            # on_connect_do => [
            #     'SET SESSION sql_mode=STRICT_TRANS_TABLES;',
            # ],
        );
    }
    $c->{db};
}

use Log::Handler;

sub log {
    my $c = shift;
    if ( !exists $c->{'log'} ) {
        my $conf = $c->config->{logger};

        if ( $ENV{PLACK_ENV} && $ENV{PLACK_ENV} eq 'production' ) {
            delete $conf->{screen};
            delete $conf->{file}->{'debug'};
        }

        my $log = Log::Handler->new();
        $log->config( config => $conf ) or die $log->errstr;

        $SIG{__WARN__} = sub { $log->log( warn => @_ ) };
        $SIG{__DIE__} = sub { $log->trace( emergency => @_ ) };
        $c->{'log'} = $log;
    }
    $c->{'log'};
}

sub debug {
    shift->log->debug(shift);
}

1;
__END__

=head1 NAME

Markets - Markets

=head1 DESCRIPTION

This is a main context class for Markets

=head1 AUTHOR

Markets authors.
