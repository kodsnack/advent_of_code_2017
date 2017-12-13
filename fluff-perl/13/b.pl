#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use Data::Dumper;

my @layers;


while(my $r = <STDIN>) {
    chomp($r);
    my @t = split(/\:\ /, $r);
    $layers[$t[0]] = $t[1];
}

my $i = 0;
while(1) {
    $i++;
    my $score = travel($i);   
    if($score == 0) {
	print $i;
	last;
    }
}

sub travel {
    my $delay = shift;
    my $me = -1;
    my @detected;
    
    for(my $picos = $delay; $picos <= $delay + $#layers; $picos++) {
	$me++;
	
	if(defined($layers[$me])) {
	    my $scanner = scanpos($picos, $layers[$me]);
	    
	    return 1 if($scanner == 1);
	}
    }

    return 0;
}

sub scanpos {
    my $picos = shift;
    my $range = shift;

    my $rt = $range * 2 - 2;
    my $start =  $rt < $picos ? POSIX::floor($picos/$rt) * $rt : 0;
    
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
