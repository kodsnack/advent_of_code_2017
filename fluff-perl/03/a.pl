#!/usr/bin/perl

use strict;
use warnings;
use POSIX;

my $input = $ARGV[0];
chomp($input);

my $x = 0;
my $y = 0;
my $v = 0;
my $sidelength = 1;
my $steps = 0;
my $dir = 0;
while($v < $input) {

    $v++;
    last if($v == $input);
    if($dir == 0) {
	$y++;
    }
    elsif($dir == 1) {
	$x++;
    }
    elsif($dir == 2) {
	$y--;
    }
    elsif($dir == 3) {
	$x--;
    }

    if(($dir % 2 == 1 && abs($x) == ceil($sidelength/2)) || 
       ($dir % 2 == 0 && abs($y) == ceil($sidelength/2))) {
	$dir++;
	if($dir == 4) {
	    $dir = 0;
	    $sidelength += 2;
	}
    }

}
print abs($x) + abs($y);
