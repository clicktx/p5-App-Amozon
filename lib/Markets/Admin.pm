package Markets::Admin;
use strict;
use warnings;
use utf8;
use parent qw(Markets Amon2::Web);
use File::Spec;

# dispatcher
use Markets::Admin::Dispatcher;

sub dispatch {
    return (
        Markets::Admin::Dispatcher->dispatch( $_[0] )
          or die "response is not generated"
    );
}

# setup view
use Markets::Admin::View;
{

    sub create_view {
        my $view = Markets::Admin::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *Markets::Admin::create_view = sub { $view };    # Class cache.
        $view;
    }
}

# load plugins
__PACKAGE__->load_plugins( 'Web::FillInFormLite', );

sub show_error {
    my ( $c, $msg, $code ) = @_;
    my $res = $c->render( 'error.tx', { message => $msg } );
    $res->code( $code || 500 );
    return $res;
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

# http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

use HTTP::Session2::ClientStore2;
use Crypt::CBC;
use Crypt::Rijndael;

__PACKAGE__->add_trigger(
    BEFORE_DISPATCH => sub {
        my ($c) = @_;
        if ( $c->req->method ne 'GET' && $c->req->method ne 'HEAD' ) {
            my $token =
              $c->req->header('X-XSRF-TOKEN') || $c->req->param('XSRF-TOKEN');
            unless ( $c->session->validate_xsrf_token($token) ) {
                return $c->create_simple_status_page( 403, 'XSRF detected.' );
            }
        }
        return;
    },
);

my $cipher = Crypt::CBC->new(
    {
        key    => '4UmqoEoVC6xtAvTxiR_NeTwbIdPPCWic',
        cipher => 'Rijndael',
    }
);

sub session {
    my $self = shift;

    if ( !exists $self->{session} ) {
        $self->{session} = HTTP::Session2::ClientStore2->new(
            env    => $self->req->env,
            secret => '68XMbdfdGZag883WbDTtik-y4zVCXFqb',
            cipher => $cipher,
        );
    }
    return $self->{session};
}

__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;
        if ( $c->{session} && $res->can('cookies') ) {
            $c->{session}->finalize_plack_response($res);
        }
        return;
    },
);

1;
