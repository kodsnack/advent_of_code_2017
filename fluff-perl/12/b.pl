#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $programs;
my @seen;
my @allkeys;
my $groups = 0;
while(my $r = <STDIN>) {
    chomp($r);

    my @t = split(/\ \<\-\>\ /, $r);
    $programs->{$t[0]} = [split(/\,\ /, $t[1])];
    push @allkeys, $t[0];
}

while($#allkeys > -1) {
    my $count = traverse(shift @allkeys);
    $groups++ if($count > 0);
}
print $groups;

sub traverse {
    my $root = shift;
    my $count = 0;
    foreach my $p (@{$programs->{$root}}) {
	next if(grep {$p == $_} @seen);
	push @seen, $p;
	$count++;
	$count += traverse($p);
	delete $programs->{$p};
    }
    return $count;
}
