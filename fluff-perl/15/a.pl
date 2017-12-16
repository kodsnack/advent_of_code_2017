#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @v = qw/699 124/;
my @mul = qw/16807 48271/;
my $div = 2147483647;
my @bins;

my $count = 0;

for(0..40000000) {
    for(0,1) {
	$v[$_] = ($v[$_] * $mul[$_]) % $div;
	
	$bins[$_] = substr(sprintf("%032b", $v[$_]), 16, 16);

    }
    
    $count++ if($bins[0] eq $bins[1]);
}
print $count;
