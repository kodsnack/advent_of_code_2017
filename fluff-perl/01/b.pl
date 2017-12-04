#!/usr/bin/perl

use strict;
use warnings;

my @a = grep { /^\d$/ } split(//, <STDIN>);
my $sum = 0;
my $h = ($#a + 1) / 2;
for(my $i = -1 * $h; $i < $h; $i++) {
    $sum += $a[$i] if($a[$i] == $a[$i + $h]);
}
print $sum;
