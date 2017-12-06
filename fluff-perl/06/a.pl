#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my @seen;
my @banks;
my $cycles = 0;

my $r = <STDIN>;
chomp($r);
@banks = split(/\t/, $r);

while(1) {

    my $maxpos = -1;
    my $reallocate = -1;
    for(my $i = 0; $i <= $#banks; $i++) {
	if($banks[$i] > $reallocate) {
	    $reallocate = $banks[$i];
	    $maxpos = $i;
	}
    }

    my $curpos = $maxpos;
    $banks[$curpos] = 0;
    for(my $i = 0; $i < $reallocate; $i++) {

	$curpos++;
	if($curpos > $#banks) {
	    $curpos = 0;
	}
	$banks[$curpos]++;
    }

    $cycles++;

    my $configstr = join("|", @banks);
    if(grep { $configstr eq $_ } @seen) {
	last;
    }
    else {
	push @seen, $configstr;
    }
}
print "$cycles;"
