#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

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

    if($valid) {
	$prev = "";

	my @anagrams = sort map { join("", sort split(//, $_)) } @w;
	
	foreach my $word (@anagrams) {
	    if($word eq $prev && $prev ne "") {
		$valid = 0;
		last;
	    }
	    else {
		$prev = $word;
	    }
	}
    }

    $correctcount+++ if($valid);
}
print $correctcount;
