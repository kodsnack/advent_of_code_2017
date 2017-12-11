#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @steps;
my $r = <STDIN>;
chomp($r);
@steps = split(/\,/, $r);
my $x = 0;
my $y = 0;
my $max = 0;
foreach my $step (@steps) {
    if($step eq "n") {
	$y--;    
    }
    elsif($step eq "nw") {
	$x--;
    }
    elsif($step eq "sw") {
	$x--;
	$y++;
    }
    elsif($step eq "s") {
	$y++;
    }
    elsif($step eq "se") {
	$x++;
    }
    elsif($step eq "ne") {
	$x++;
	$y--;
    }

    $max = $x if(abs($x) > abs($max));
    $max = $y if(abs($y) > abs($max));	
}
print $max;
