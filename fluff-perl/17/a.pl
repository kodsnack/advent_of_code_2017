#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $steps = 348;
my @buffer;
my $curpos = 0;
push @buffer, 0;

for(1..2017) {

    $curpos += $steps;
    $curpos %= $_;
	
    if($curpos == $#buffer) {
	push @buffer, $_;
    }
    else {
	@buffer = (@buffer[0..($curpos)], $_, @buffer[$curpos+1..$#buffer]);
    }
    $curpos++;
}

print $buffer[$curpos+1];
