#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $root;
my $nodes;
my $reverse;
my $tree;

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
	$root = $node;
    }
}

$tree = buildTree($root);
findInbalance($tree);

sub buildTree {
    my $parent = shift;

    my @children;
    my $sumweight = 0;
    
    foreach my $child (@{$nodes->{$parent}->{'children'}}) {
	push @children, buildTree($child); 
    }

    foreach my $child (@children) {
	$sumweight += $child->{'sumweight'};
    }
        
    $sumweight += $nodes->{$parent}->{'weight'};
    
    return {'node' => $parent, 'children' => \@children, 'weight' => $nodes->{$parent}->{'weight'}, 'sumweight' => $sumweight };

}

sub findInbalance {
    my $root = shift;

    my $cweights;
    my $deviatingWeight;
    my $correctWeight;
    my $res;
    foreach my $child (@{$root->{'children'}}) {
	$cweights->{$child->{'sumweight'}}++;
    }

   
    if(keys %{$cweights} > 1) {
	my @sortedcw = sort { $cweights->{$a} <=> $cweights->{$b} } keys %{$cweights};
	$deviatingWeight = $sortedcw[0];
	$correctWeight = $sortedcw[1];
    }


    if(defined($deviatingWeight)) {
	foreach my $child (@{$root->{'children'}}) {
	    if($child->{'sumweight'} == $deviatingWeight) {
		my $res = findInbalance($child);
		if($res) {
		    print $child->{'weight'} - ($child->{'sumweight'} - $correctWeight);
		}
	    }
	}
    }
    else {
	return 1;
    }
}
