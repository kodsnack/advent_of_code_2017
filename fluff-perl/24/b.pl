#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use Component;
use Bridge;

my %cs;
my @bs;
my $bestbridge = new Bridge();
while(my $r = <STDIN>) {
    chomp($r);
    $cs{$r} = new Component($r);
}

foreach my $c (values %cs) {
    cc($c, 0, \%cs, new Bridge()) if($c->hasPort(0));
}

sub cc {
    my $c = shift;
    my $usedport = shift;
    my $cs = shift;
    my $b = shift;

    $b->addComponent($c);
    delete $cs->{$c->getPortString()};
    my $foundcomp = 0;
    foreach my $cn (values %$cs) {
	if($cn->hasPort($c->getOtherPort($usedport))) {
	    cc($cn, $c->getOtherPort($usedport), { %$cs }, $b->clone());
	    $foundcomp = 1;
	}
    }

    if(!$foundcomp) {
	if(($bestbridge->getLength() < $b->getLength()) ||
	   ($bestbridge->getLength() == $b->getLength() && $bestbridge->getStrength() < $b->getStrength())
	    ) {
	    $bestbridge = $b->clone();
	}
    }
}
print $bestbridge->getStrength();
