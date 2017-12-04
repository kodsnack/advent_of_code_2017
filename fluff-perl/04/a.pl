#!/usr/bin/perl

use strict;
use warnings;

my $correctcount = 0;
while(my $r = <STDIN>) {
    chomp($r);
    my @w = sort { $a cmp $b } split(/\ /, $r);
    my $prev = "";
    my $valid = 1;
    foreach my $word (@w) {
	if($word eq $prev) {
	    $valid = 0;
	    last;
	}
	else {
	    $prev = $word;
	}
    }

    $correctcount++ if($valid);
}
print $correctcount;
