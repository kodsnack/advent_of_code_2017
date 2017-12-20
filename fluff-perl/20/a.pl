#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use Particle;
use Coord;

my @particles;


while(my $r = <STDIN>) {
    chomp($r);

    my $part = new Particle();
    
    for(qw/p v a/) {
	$r =~ /$_\=\<\ ?(\-?[\d]+)\,\ ?(\-?[|\d]+)\,\ ?(\-?[\d]+)\>/;
	my $c = new Coord();
	$c->setCoord($1, $2, $3);
	$part->set($_, $c);
    }
    $part->accelerate();
    $part->updatepos();
    $part->accelerate();
    $part->updatepos();
    push @particles, $part;
}

my @winners;
for(1..1000) {
    my $bestparticle;
    my $closest;
    for(my $i = 0; $i <= $#particles; $i++) {

	my $part = $particles[$i];
	my $dist = $part->getmd();
	if(!defined($closest) || $dist < $closest) {
	    $closest = $dist;
	    $bestparticle = $i;
	}

	$particles[$i]->accelerate();
	$particles[$i]->updatepos();
	
    }
    
    push @winners, $bestparticle;
}

print $winners[-1];
