#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @instructions;
my @reg;
my @queues;
my $lastplayed;
my %registers;
while(my $r = <STDIN>) {
    chomp($r);
    push @instructions, [split(/\ /, $r)];
}


for(my $i = 0; $i <= $#instructions; $i++) {

    my $instr = $instructions[$i];
    my $key;
    my $val = "";
    my $checkval;
    
    if($instr->[1] =~ /^(-?\d+)/) {
	$checkval = $1;
    }
    elsif($instr->[1] =~ /^(.+)/) {
	$key = $1;
    }

    if(defined($instr->[2])) {
	if($instr->[2] =~ /^(\-?\d+)/) {
	    $val = $1;
	}
	elsif($instr->[2] =~ /^(.+)/) {
	    $val = $registers{$1};
	}
    }

    $registers{$key} = 0 if(defined($key) && !defined($registers{$key}));
  
    if($instr->[0] eq "snd") {
	my $freq = $registers{$key};
	$lastplayed = $freq;
    }
    elsif($instr->[0] eq "set") {
	$registers{$key} = $val;
    }
    elsif($instr->[0] eq "add") {
	$registers{$key} += $val;
    }
    elsif($instr->[0] eq "mul") {
	$registers{$key} *= $val;
    }
    elsif($instr->[0] eq "mod") {
	$registers{$key} %= $val;
    }
    elsif($instr->[0] eq "rcv") {
	if($registers{$key} > 0) {
	    last;
	}
    }
    elsif($instr->[0] eq "jgz") {
	if(defined($key) && $registers{$key} > 0) {
	    $i += ($val - 1);
	}
	elsif(defined($checkval) && $checkval > 0) {
	    $i += ($val - 1);
	}
    }
}
print "$lastplayed";
