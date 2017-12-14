#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $input = $ARGV[0];
chomp($input);

my $maxpos = 255;
my @list;
my @disc;
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

    push @disc, [split(//, $bin)];

}



my @dr;
for(0..127) {
    my $i = $_;
#    print join("|", @{$disc[$i]}) . "\n";
    for(0..127) {
	$dr[$i][$_] = 0;
    }
}

my @seen;
my $region = 0;
for(my $row = 0; $row <= 127; $row++) {
    for(my $col = 0; $col <= 127; $col++) {
	if($disc[$row][$col] == 1 && $dr[$row][$col] == 0) {
	    $region++;
	    foreach my $p (checkNeighbours($row, $col)) {
		my ($x, $y) = split(/\|/, $p);
		if($dr[$x][$y] == 0) {
		    $dr[$x][$y] = $region;
		}
	    }
	}
    }
}

sub checkNeighbours {
    my $row = shift;
    my $col = shift;
    
    my $rout;

    my $jstr = join("|", $row, $col);
    push @{$rout}, $jstr;
    
    return if(grep {$jstr eq $_ } @seen);
    push @seen, $jstr;
    if($row > 0 && $disc[$row-1][$col] == 1) {
	$jstr = join("|", $row - 1, $col);
	unless(grep { $_ eq $jstr } @{$rout}) {
	    push @{$rout}, checkNeighbours($row - 1, $col);
	}
    }

    if($row < 127 && $disc[$row+1][$col] == 1) {
	$jstr = join("|", $row + 1, $col);
	unless(grep { $_ eq $jstr } @{$rout}) {
	    push @{$rout}, checkNeighbours($row + 1, $col);
	}
    }

    if($col < 127 && $disc[$row][$col+1] == 1) {
	$jstr = join("|", $row , $col + 1);
	unless(grep { $_ eq $jstr } @{$rout}) {
	    push @{$rout}, checkNeighbours($row, $col + 1);
	}
    }
    if($col > 0 && $disc[$row][$col-1] == 1) {
	$jstr = join("|", $row, $col - 1);
	unless(grep {$_ eq $jstr } @{$rout}) {
	    push @{$rout}, checkNeighbours($row, $col - 1);
	}
    }
    
    return @{$rout};
}	
print $region;

