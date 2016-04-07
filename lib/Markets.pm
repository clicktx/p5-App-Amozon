package Markets;
use strict;
use warnings;
use utf8;
our $VERSION = '0.01';
use 5.008001;
use Markets::DB::Schema;
use Markets::DB;

use parent qw/Amon2/;

# Enable project local mode.
__PACKAGE__->make_local_context();

# load plugins
__PACKAGE__->load_plugins( 'ShareDir', '+Markets::Log', '+Markets::Model', );

my $schema = Markets::DB::Schema->instance;

sub load_config {
    my ($c, $conf) = @_;
    my $config = $conf || do {
        my $env = $c->mode_name || 'development';
        my $config_base = File::Spec->catdir($c->base_dir, 'config'); # backward compatible
           $config_base = File::Spec->catdir($c->share_dir, 'config') unless -d $config_base;
        my $fname = File::Spec->catfile($config_base, "${env}.pl");
        my $config = do $fname;
        Carp::croak("$fname: $@") if $@;
        Carp::croak("$fname: $!") unless defined $config;
        unless ( ref($config) eq 'HASH' ) {
            Carp::croak("$fname does not return HashRef.");
        }
        $config;
    };
}

sub db {
    my $c = shift;
    if ( !exists $c->{db} ) {
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

1;
__END__

=head1 NAME

Markets - Markets

=head1 DESCRIPTION

This is a main context class for Markets

=head1 AUTHOR

Markets authors.
