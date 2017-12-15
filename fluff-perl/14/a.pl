#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $input = $ARGV[0];
chomp($input);

my $maxpos = 255;
my @list;
my $score = 0;

for(0..127) {

    my $hashinput = $input . "-" . $_;
    @list[0..255] = 0..255;
    my $skipsize = 0;
    my $curpos = 0;
    my @moves = map { ord($_) } split(//, $hashinput);
    push @moves, split(/\,\ /, "17, 31, 73, 47, 23");
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

    my $hash = join("", map { sprintf("%02x", $_) } @dense);
    my @h = map { hex($_) } split(//, $hash);
    my $bin = "";
    foreach(@h) {
	$bin .= sprintf("%04b", $_);
    }

    $score += grep { $_ == 1 } split(//, $bin);
}
print $score;
