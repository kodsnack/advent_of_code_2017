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
my $org = join("", @programs);

my $r = <STDIN>;
chomp($r);
my @input = split(/\,/, $r);
my @instr;
my $creps = 0;

foreach my $m (@input) {    
    if($m =~ /^s(\d+)/) {
	push @instr, [0, $1];
    }
    elsif($m =~ /^x(\d+)\/(\d+)/) {
	push @instr, [1, $1, $2];
    }
    elsif($m =~ /^p(.)\/(.)/) {
	push @instr, [2, uc($1), uc($2)];
    }
}


for(1..1000000000) {
    @programs = dance(@programs);
    
    if($org eq join("", @programs)) {
	$creps = 1000000000 % $_;
	last;
    }
}

@programs = split(//, $org);

for(1..$creps) {
    @programs = dance(@programs);
}

print lc(join("", @programs));

sub dance {
    my @programs = @_;
    foreach my $i (@instr) {
	if($i->[0] == 0) {
	    unshift @programs, splice(@programs, (1+$#programs-$i->[1]));
	}
	elsif($i->[0] == 1) {
	    my $c = $programs[$i->[1]];
	    
	    $programs[$i->[1]] = $programs[$i->[2]];
	    $programs[$i->[2]] = $c;

	}
	else {
	    my @p;
	    for(my $c = 0; $c <= $#programs; $c++) {
		if($programs[$c] eq $i->[1]) {
		    $p[0] = $c;
		}
		elsif($programs[$c] eq $i->[2]) {
		    $p[1] = $c;
		}
		last if(defined($p[0]) && defined($p[1]));
	    }
	    
	    $programs[$p[0]] = $i->[2];
	    $programs[$p[1]] = $i->[1];

	}
    }
    return @programs;
}
