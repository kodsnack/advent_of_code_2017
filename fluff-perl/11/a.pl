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
}

print ((reverse sort abs($x), abs($y))[0]);
