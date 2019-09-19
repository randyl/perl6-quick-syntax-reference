#!/usr/bin/env perl6

use v6;

use lib <. Chapter10>;

use Cro::HTTP::Router;
use Cro::HTTP::Server;
use JSON::Fast;
use Draw-Two;

my $application = route {
    get -> 'cards' {
        content 'application/json', to-json draw-two;
    }
}

my Cro::Service $croupier = Cro::HTTP::Server.new:
    :host<localhost>, :port(%*ENV<CRO_PORT>), :$application;
$croupier.start;
say "Server started at %*ENV<CRO_PORT>";

react whenever signal(SIGINT) { $croupier.stop; exit; }
