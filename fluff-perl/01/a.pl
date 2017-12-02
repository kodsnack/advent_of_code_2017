#!/usr/bin/perl

use strict;
use warnings;

my @a = grep { /^\d$/ } split(//, <STDIN>);
my $sum = 0;
for(my $i = -1; $i < $#a; $i++) {
    $sum += $a[$i] if($a[$i] == $a[$i+1]);
}
print $sum;
