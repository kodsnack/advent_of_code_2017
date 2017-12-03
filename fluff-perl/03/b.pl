#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use Data::Dumper;

my $input = $ARGV[0];
chomp($input);

my $x = 0;
my $y = 0;
my $v = 1;
my $sidelength = 1;
my $steps = 0;
my $dir = 0;
my $squares;

while(1) {
    
    $squares->{$x}->{$y} = $v;
    last if($v > $input);
    
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


    $v = sumAdjecent($x, $y);
    
    
    if(($dir % 2 == 1 && abs($x) == ceil($sidelength/2)) || 
       ($dir % 2 == 0 && abs($y) == ceil($sidelength/2))) {
	$dir++;
	if($dir == 4) {
	    $dir = 0;
	    $sidelength += 2;
	}
    }

}
print $v;

sub sumAdjecent {
    my $x = shift;
    my $y = shift;
    my $sum = 0;
    for(my $xl = $x - 1; $xl <= $x + 1; $xl++) {
	for(my $yl = $y - 1; $yl <= $y + 1; $yl++) {
	    $sum += $squares->{$xl}->{$yl} if(defined($squares->{$xl}->{$yl}));
	}
    }
    
    return $sum;
}
