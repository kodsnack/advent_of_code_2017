#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @instructions;
my $steps = 0;
my $current = 0;
my $nextmove = 0;

while(<STDIN>) {
    chomp();
    push @instructions, $_;
}

while(1) {
    $nextmove = $instructions[$current];

    $steps++;
    $instructions[$current]++;
    $current += $nextmove;

    if($current > $#instructions || $current < 0) {
	last;
    }    
}

print $steps;
