#!/usr/bin/perl

use strict;
use warnings;
use POSIX;

use Data::Dumper;

my @layers;
my $severity = 0;

while(my $r = <STDIN>) {
    chomp($r);
    my @t = split(/\:\ /, $r);
    $layers[$t[0]] = $t[1];
}

for(my $picos = 0; $picos <= $#layers; $picos++) {
    if(defined($layers[$picos])) {
	$severity += $picos * $layers[$picos] if(scanpos($picos, $layers[$picos]) == 1);
    }
}

print $severity;


sub scanpos {
    my $picos = shift;
    my $range = shift;

    my $rt = ($range * 2) - 2;
    my $start = $rt < $picos ? POSIX::floor($picos/$rt) * $rt : 0;
    
    my $scanner = 1;
    my $dir = 1;
    for($start..($picos-1)) {
	if($scanner == $range) {
	    $dir = 0;
	}
	elsif($scanner == 1) {
	    $dir = 1;
	}

	$dir ? $scanner++ : $scanner--;
    }
    return $scanner;
}
