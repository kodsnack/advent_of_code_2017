#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $steps = $ARGV[0];
chomp($steps);

my $tape;
my $pos = 0;

$tape->{0} = 0;
my $nextstep = "A";

for(1..$steps) {
    $tape->{$pos} = 0 if(!defined($tape->{$pos}));
    
    if($nextstep eq "A") {
	if(!$tape->{$pos}) {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "B";
	}
	else {
	    $tape->{$pos} = 0;
	    $pos--;
	    $nextstep = "C";
	}
	next;
    }
    elsif($nextstep eq "B") {
	if(!$tape->{$pos}) {
	    $tape->{$pos} = 1;
	    $pos--;
	    $nextstep = "A";
	}
	else {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "C";
	}
	next;
    }
    elsif($nextstep eq "C") {
	if(!$tape->{$pos}) {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "A";
	}
	else {
	    $tape->{$pos} = 0;
	    $pos--;
	    $nextstep = "D";
	}
	next;
    }
    elsif($nextstep eq "D") {
	if(!$tape->{$pos}) {
	    $tape->{$pos} = 1;
	    $pos--;
	    $nextstep = "E";
	}
	else {
	    $tape->{$pos} = 1;
	    $pos--;
	    $nextstep = "C";
	}
	next;
    }
    elsif($nextstep eq "E") {
	if(!$tape->{$pos}) {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "F";
	}
	else {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "A";
	}
	next;
    }
    elsif($nextstep eq "F") {
	if(!$tape->{$pos}) {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "A";
	}
	else {
	    $tape->{$pos} = 1;
	    $pos++;
	    $nextstep = "E";
	}
	next;
    }
    else {
	warn "Unknown step $nextstep";
	die;
    }
}
my $count = 0;
grep { if($_) { $count++ } } values %$tape;
print $count;
