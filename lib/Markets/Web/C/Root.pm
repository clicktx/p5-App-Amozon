package Markets::Web::C::Root;
use strict;
use warnings;
use utf8;

sub index {
    my ( $class, $c ) = @_;

    my $model = $c->model('Data::Foo');
    my $logic = $c->model('Logic::Hoge');

    # logging sample
    $c->debug("debug log!");
    warn 'warn';

    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set( 'counter' => $counter );
    return $c->render(
        'index.tx',
        {
            counter => $counter,
            keys    => {
                model => $model->hello,
                logic => $logic->hoge,
            },
        }
    );
}

sub reset_counter {
    my ( $class, $c ) = @_;

    $c->session->remove('counter');
    return $c->redirect('/');
}

1;
