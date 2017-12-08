#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $registers;
my $max;

while(my $r = <STDIN>) {

    chomp($r);

    my @parts = split(/\ /, $r);
    
    $registers->{$parts[4]} = 0 if(!defined($registers->{$parts[4]}));
    $registers->{$parts[0]} = 0 if(!defined($registers->{$parts[0]}));

    if(
	($parts[5] eq "==" && $registers->{$parts[4]} == $parts[6]) ||
	($parts[5] eq ">" && $registers->{$parts[4]} > $parts[6]) ||
	($parts[5] eq ">=" && $registers->{$parts[4]} >= $parts[6]) ||
	($parts[5] eq "<" && $registers->{$parts[4]} < $parts[6]) ||
	($parts[5] eq "<=" && $registers->{$parts[4]} <= $parts[6]) ||
	($parts[5] eq "!=" && $registers->{$parts[4]} != $parts[6])
	) {

	    if($parts[1] eq "inc") {
		$registers->{$parts[0]} += $parts[2];
	    }
	    elsif($parts[1] eq "dec") {
		$registers->{$parts[0]} -= $parts[2];
	    }

    }

}

foreach my $reg (keys %{$registers}) {
    $max = $registers->{$reg} if(!defined($max) ||$registers->{$reg} > $max);
}
print $max;

