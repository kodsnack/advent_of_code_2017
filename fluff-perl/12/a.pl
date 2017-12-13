#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $programs;
my @seen;

while(my $r = <STDIN>) {
    chomp($r);

    my @t = split(/\ \<\-\>\ /, $r);
    $programs->{$t[0]} = [split(/\,\ /, $t[1])];
}

my $count = traverse(0);
print $count;

sub traverse {
    my $root = shift;
    my $count = 0;
    foreach my $p (@{$programs->{$root}}) {
	next if(grep {$p == $_} @seen);
	push @seen, $p;
	$count++;
	$count += traverse($p);
    }
    return $count;
}
