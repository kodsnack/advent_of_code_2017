#!/usr/bin/perl

use strict;
use warnings;

my %reg;
my $in = $ARGV[0];
chomp($in);

for(qw/a b c d e f g h/) {
    $reg{$_} = 0;
}

$reg{b} = $in;

$reg{b} *= 100;
$reg{b} += 100000;

$reg{c} = $reg{b} + 17000;

while(1) {
    $reg{f} = 1;
    $reg{d} = 2;
    $reg{e} = 2;
    my $bstart = $reg{b};
    while($bstart == $reg{b}) {

	$reg{f} = 0 if($reg{b} % $reg{d} == 0);
	$reg{d}++;
	next if($reg{d} != $reg{b});
	$reg{h}++ if($reg{f} == 0);
	if($reg{b} == $reg{c}) {
	    print $reg{h};
	    exit;
	}
	$reg{b} += 17;
    }
}
