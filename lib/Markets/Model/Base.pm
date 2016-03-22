package Markets::Model::Base;

sub new {

    # context object is passed as parameter "c"
    my ( $class, %params ) = @_;
    return bless \%params, $class;
}

sub c { shift->{c} }

1;
