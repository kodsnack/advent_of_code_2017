#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

use Rule;

my $iters = $ARGV[0];
chomp($iters);

my @rules;
while(my $r = <STDIN>) {
    chomp($r);
    my $rule = new Rule($r);
    push @rules, $rule;
}

my $image = ".#./..#/###";

for(1..$iters) {
    my @parts = splitimage($image);
    my @results;
    foreach my $part (@parts) {
	push @results, process($part);
    }

    $image = $#results > 0 ? mergeimage(@results) : $results[0];

    my $count = grep { $_ eq "#" } split(//, $image);
    print "$_ => $count\n";
}


sub splitimage {
    my $image = shift;
    
    my @pixels;
    my @rows = split(/\//, $image);
    foreach my $row (@rows) {
	push @pixels, [split(//, $row)];
    }

    my $split = ($#rows + 1) % 2 == 0 ? 2 : 3;
    
    my @parts;
    for(my $x = 0; $x < $#rows; $x += $split) {
	for(my $y = 0; $y < $#rows; $y += $split) {
	    my $image = "";
	    for($x..$x+$split-1) {
		$image .= join("", @{$pixels[$_]}[$y..$y+$split-1]) . "/";
	    }
	    $image =~ s/\/$//;
	    push @parts, $image;
	}
    }

    return @parts;
}

sub mergeimage {

    my @parts = @_;
    $parts[0] =~ /^([^\/]+)\//;
    my $rs = length($1); 
    my $size = sqrt(($#parts+1) * ($rs*$rs));

    my @out;
    my $x = 0;
    my $y = 0;

    foreach my $part (@parts) {
	my $xc = 0;
	foreach my $row (split(/\//, $part)) {
	    my @bits = split(//, $row);
	    @{$out[$x+$xc]}[$y..($y+$rs-1)] = @bits;
	    $xc++;
	}

	$y += $rs;
	if($y == $size) {
	    $y = 0;
	    $x += $rs;
	}
    }

    return join("/", map { join("", @{$out[$_]}) } keys @out);
}

sub process {
    my $image = shift;
    
    foreach my $rule (@rules) {
	my $pc = grep { $_ eq "#" } split(//, $image);
	return $rule->getreplacement() if($rule->comparePixelCount($pc) && $rule->match($image) >= 0);
    }
}
