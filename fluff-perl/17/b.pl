#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $steps = 348;
my @buffer;
my $curpos = 0;
push @buffer, 0;

my $afterzero = 0;

for(1..50000000) {
 
    $curpos += $steps;
    $curpos %= $_;
    

    $afterzero = $_ if($curpos == 0);
    
    $curpos++;
}
print $afterzero;
