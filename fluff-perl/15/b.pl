#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @v = qw/699 124/;

my @mul = qw/16807 48271/;
my @val = qw/4 8/;
my $div = 2147483647;
my @bins;

my $count = 0;

for(0..40000000) {
    for(0,1) {
	$v[$_] = ($v[$_] * $mul[$_]) % $div;
	if($v[$_] % $val[$_] == 0) {
	    push @{$bins[$_]}, substr(sprintf("%032b", $v[$_]), 16, 16);
	}
    }
    
}

my $maxiter = 5000000;
$maxiter = $#{$bins[0]} if($#{$bins[0]} < $maxiter);
$maxiter = $#{$bins[1]} if($#{$bins[1]} < $maxiter);

for(0..$maxiter) {
    $count++ if($bins[0][$_] eq $bins[1][$_]);
}
print $count;
