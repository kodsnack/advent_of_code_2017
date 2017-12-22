#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use POSIX;

my $map;
my $count = 0;
my $dir = 0;
my $rowcount = -1;

while(my $r = <STDIN>) {
    chomp($r);
    $rowcount++;    
    my @row = split(//, $r);
    for(my $y = 0; $y <= $#row ; $y++) {
	$map->{$rowcount}->{$y} = $row[$y];
    }
}

my @pos = (POSIX::ceil($rowcount/2), POSIX::ceil($rowcount/2));

for(1..10000000) {
    $map->{$pos[0]}->{'0'} = "." if(!defined($map->{$pos[0]}));
    $map->{$pos[0]}->{$pos[1]} = "." if(!defined($map->{$pos[0]}->{$pos[1]}));
    
    if($map->{$pos[0]}->{$pos[1]} eq "#") {
	$dir = ++$dir % 4;
    }
    elsif($map->{$pos[0]}->{$pos[1]} eq ".") {
	$dir = --$dir % 4;
    }
    elsif($map->{$pos[0]}->{$pos[1]} eq "F") {
	$dir  = ($dir - 2) % 4;
    }

    if($map->{$pos[0]}->{$pos[1]} eq ".") {
	$map->{$pos[0]}->{$pos[1]} = "W";
    }
    elsif($map->{$pos[0]}->{$pos[1]} eq "W") {
	$map->{$pos[0]}->{$pos[1]} = "#";
	$count++;
    }
    elsif($map->{$pos[0]}->{$pos[1]} eq "#") {
	$map->{$pos[0]}->{$pos[1]} = "F";
    }
    elsif($map->{$pos[0]}->{$pos[1]} eq "F") {
	$map->{$pos[0]}->{$pos[1]} = ".";
    }

    $pos[$dir % 2] += ($dir == 1 || $dir == 2) ? 1 : -1;
}
print $count;
