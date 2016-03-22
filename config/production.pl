use File::Spec;
use File::Basename qw(dirname);
my $basedir =
  File::Spec->rel2abs( File::Spec->catdir( dirname(__FILE__), '..' ) );
my $dbpath = File::Spec->catfile( $basedir, 'db', 'production.db' );
my $base_config = do File::Spec->catfile( dirname(__FILE__), 'base.pl' );
+{
    %$base_config,
    'DBI' => [
        "dbi:SQLite:dbname=$dbpath",
        '', '',
        +{
            sqlite_unicode => 1,
        }
    ],
};
