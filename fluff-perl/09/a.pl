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

    s/\<([^\>]*)\>//g;

    s/\,//g;

    my $depth = 0;
    foreach my $char (split(//, $_)) {
	if($char eq "{") {
	    $depth++;
	}
	elsif($char eq "}") {
	    $score += $depth;
	    $depth--;
	}
	
    }
    print $score . "\n";
    $score = 0;
}
