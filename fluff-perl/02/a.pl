#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $sum = 0;
while(my $r = <STDIN>) {
    chomp($r);
    my @n = sort {$a <=> $b} split(/\t/, $r);
    $sum += $n[-1] - $n[0];
}
print $sum;
