#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $sum = 0;
while(my $r = <STDIN>) {
    chomp($r);
    my @n = sort {$a <=> $b} split(/\t/, $r);
    for(my $i = 0; $i <= $#n; $i++) {
	for(my $j = 0; $j <= $#n; $j++) {
	    next if($i == $j);
	    $sum += $n[$i]/$n[$j] if($n[$i]/$n[$j] == int($n[$i]/$n[$j]));		
	}
    }
}
print $sum;
