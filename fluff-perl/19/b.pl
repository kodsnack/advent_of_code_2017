#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @maze;
my %pos;
my @seen;
my $dir = "s";
my $steps = 0;

my $i = 0;
while(my $r = <STDIN>) {
    chomp($r);
    my @cols = split(//, $r);

    $maze[$i] = [@cols];
    $i++;
}

my $x = 0;
my $y = 0;
for($y = 0; $y <= $#{$maze[0]}; $y++) {
    last if($maze[0][$y] ne " ");
}

while(1) {
    $steps++;
    
    if($dir eq "n") {
	$x--;
    }
    elsif($dir eq "e") {
	$y++;
    }
    elsif($dir eq "s") {
	$x++;
    }
    elsif($dir eq "w") {
	$y--;
    }
    
    my $char = $maze[$x][$y];
    
    if(($char eq "|" && $dir =~ /e|w/) ||
       ($char eq "-" && $dir =~ /n|s/)
	) {
	$steps++;
	if($dir eq "w" && $maze[$x][$y-1] =~ /[A-Z]|-/) {
	    $y--;
	}
	elsif($dir eq "e" && $maze[$x][$y+1] =~ /[A-Z]|-/) {
	    $y++;
	}		
	elsif($dir eq "n" && $maze[$x-1][$y] =~ /[A-Z]|\|/) {
	    $x--;
	}
	elsif($dir eq "s" && $maze[$x+1][$y] =~ /[A-Z]|\|/) {
	    $x++;
	}

	push @seen, $maze[$x][$y] if($maze[$x][$y] =~ /^[A-Z]$/);
    }
    elsif($char eq  "+") {
	my @dirs = intersection($x, $y, $dir);
	$dir = $dirs[0];
    }
    elsif($char =~ /^[A-Z]$/) {
	push @seen, $char;
    }
    elsif($char eq " ") {
	last;
    }
}
print $steps;

sub intersection {
    my $x = shift;
    my $y = shift;
    my $dir = shift;

    my %ways;

    $ways{n} = $maze[$x-1][$y] if(defined($maze[$x-1][$y]) && $dir ne "s");
    $ways{e} = $maze[$x][$y+1] if(defined($maze[$x][$y+1]) && $dir ne "w");
    $ways{s} = $maze[$x+1][$y] if(defined($maze[$x+1][$y]) && $dir ne "n");
    $ways{w} = $maze[$x][$y-1] if(defined($maze[$x][$y-1]) && $dir ne "e");

    foreach my $k (keys %ways) {
	delete $ways{$k} if($ways{$k} =~ /\ /);
    }
   
    return keys %ways;
}
