#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $bottom;
my $nodes;
my $reverse;

while(my $r = <STDIN>) {
    chomp($r);

    my @children;
    $r =~ /^(\w+)\ \((\d+)\)(\ \-\>\ )?(.*)?/;

    my $node = $1;
    
    if(defined($3)) {
	@children = split(/\,\ /, $4);
    }	
    
    $nodes->{$node} = {
	'weight' => $2,
	'children' => \@children
    };

    foreach my $child (@children) {
	$reverse->{$child} = $node;
    }
}

foreach my $node (keys %{$nodes}) {
    if(!grep { $node eq $_ } keys %{$reverse}) {
	print $node . " has no parents.\n";
    }
}
