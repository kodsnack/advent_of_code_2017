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
    push @particles, $part;
}

for(1..1000) {
    my %plane;
    my @pcopy = @particles;
    for(my $i = 0; $i <= $#particles; $i++) {

	my $part = $particles[$i];
	my $p = $part->getPos();

	my $pstr = join("|", $p->getCoord());

	if(defined($plane{$pstr})) {
	    my $pos = $plane{$pstr};

	    delete $pcopy[$pos];
	    delete $pcopy[$i];
	}
	else {
	    $plane{$pstr} = $i;
	}
    }
    
    undef(@particles);
    foreach my $p (@pcopy) {
	if(defined($p)) {
	    push @particles, $p;
	}
    }
    
    for(my $i = 0; $i <= $#particles; $i++) {
	$particles[$i]->accelerate();
	$particles[$i]->updatepos();
    }
}

print ($#particles + 1);
