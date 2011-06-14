use strict;
use warnings;

use lib 'lib';

use FixMyStreet::App;
use Plack::Builder;
use Plack::App::File;

FixMyStreet::App->setup_engine('PSGI');
my $app = sub { FixMyStreet::App->run(@_) };

builder {

    # enable 'Debug';

    # If request is from localhost then must be from a proxy
    enable_if { $_[0]->{REMOTE_ADDR} eq '127.0.0.1'; } "ReverseProxy";

    $app;
};
