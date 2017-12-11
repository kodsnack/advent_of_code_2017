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

my @moves = split(/\,/, $r);

@list[0..$maxpos] = 0..$maxpos;

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

print ($list[0] * $list[1]);
