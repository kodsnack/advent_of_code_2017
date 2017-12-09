#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $score = 0;
while(<STDIN>) {
    chomp($_);

    while(/\!/) {
	s/\!.//;
    }

    while(/\</) {
	s/\<([^\>]*)\>//;
	$score += length($1);
    }
    
    print $score . "\n";
    $score = 0;
}
