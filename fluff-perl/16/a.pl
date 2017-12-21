#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @programs;
my $length = $ARGV[0];
chomp($length);

for(my $i = 65; $i < 65 + $length; $i++) {
    $programs[($i - 65)] = chr($i);
}

my $r = <STDIN>;
chomp($r);

foreach my $m (split(/\,/, $r)) {

    if($m =~ /^s(\d+)/) {
	unshift @programs, splice(@programs, (1+$#programs-$1));
    }
    elsif($m =~ /^x(\d+)\/(\d+)/) {
	$_ = $programs[$2];
	$programs[$2] = $programs[$1];
	$programs[$1] = $_;
    }
    elsif($m =~ /^p(.)\/(.)/) {
	my @p;
	for(my $i = 0; $i <= $#programs; $i++) {
	    if($programs[$i] eq uc($1)) {
		$p[0] = $i;
	    }
	    elsif($programs[$i] eq uc($2)) {
		$p[1] = $i;
	    }
	}

	$programs[$p[0]] = uc($2);
	$programs[$p[1]] = uc($1);

    }
}
print lc(join("", @programs)) . "\n";
