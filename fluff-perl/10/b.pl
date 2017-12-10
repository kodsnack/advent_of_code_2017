#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @list;
my $skipsize = 0;
my $curpos = 0;
my $maxpos = $ARGV[0];

chomp($maxpos);
my $r = <STDIN>;
chomp($r);

my @moves = map { ord($_) } split(//, $r);
push @moves, split(/\ /, "17 31 73 47 23");

@list[0..$maxpos] = 0..$maxpos;

for(1..64) {
    foreach my $move (@moves) {
	my @sublist;
	push @sublist, @list, @list;
	
	my $i = $curpos;
	foreach my $p (reverse @sublist[$curpos..($curpos + $move - 1)]) {
	    $list[$i++ % ($maxpos + 1)] = $p;
	}

	$curpos = ($curpos + $move + $skipsize) % ($maxpos + 1);
	$skipsize++;

    }
}

my @dense;
for(my $i = 0; $i <= $maxpos; $i += 16) {
    my $sum = $list[$i] ^ $list[$i+1];
    for(my $j = $i + 2; $j < $i + 16; $j++) {
	$sum = $sum ^ $list[$j];
    }
    
    push @dense, $sum;
}

print join("", map { sprintf("%02x", $_) } @dense) . "\n";
