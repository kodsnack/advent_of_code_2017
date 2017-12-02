#!/usr/bin/perl

use strict;
use warnings;

my $sum = 0;
while(my $r = <STDIN>) {
    chomp($r);
    my @n = sort {$a <=> $b} split(/\t/, $r);
    for(my $i = 0; $i <= $#n; $i++) {
	for(my $j = 0; $j <= $#n; $j++) {
	    next if($i == $j);
	    my $div = $n[$i]/$n[$j];
	    $sum += $div if($div == int($div));		
	}
    }
}
print $sum;
