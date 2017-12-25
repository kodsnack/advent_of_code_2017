#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @instructions;
my @reg;
my @queues;

$reg[0]->{p} = 0;
$reg[1]->{p} = 1;

my @p = qw/0 0/;
my @status = qw/1 1/;
my @sendcount = qw/0 0/;
my @jumpval = qw/0 0/;

while(my $r = <STDIN>) {
    chomp($r);
    push @instructions, [split(/\ /, $r)];
}

while(1) {
    for(0, 1) {
	if($status[$_] == 1 || ($status[$_] == 2 && $#{$queues[$_]} >= 0)) {
	    my $c = $p[$_];
	    %{$reg[$_]} = computer($_, $p[$_], \%{$reg[$_]});
	    
	    $p[$_] += $jumpval[$_];
	    $jumpval[$_] = 0;
	    $status[$_] = 0 if($p[$_] >= $#instructions);
	}
    }

    if(join("", @status) eq "00" || join("", @status) eq "22") {
	last;
    }
}
print $sendcount[1];

sub computer {
    my $pgm = shift;
    my $pos = shift;
    my $r = shift;
    my %registers = %{$r};
    my $instr = $instructions[$pos];
    my $key;
    my $checkval = 0;
    my $val = "";
    my $other = $pgm == 0 ? 1 : 0;

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
    $jumpval[$pgm] = 1;
    
    if($instr->[0] eq "snd") {
	my $freq = $registers{$key};
	push @{$queues[$other]}, $freq;
 	$sendcount[$pgm]++;
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
	if($#{$queues[$pgm]} >= 0) {
	    my $rcv = shift @{$queues[$pgm]};
	    $registers{$key} = $rcv;
	    $status[$pgm] = 1;
	}
	else {
	    $status[$pgm] = 2;
	    $jumpval[$pgm] = 0;
	}
    }
    elsif($instr->[0] eq "jgz") {
	if(defined($key) && $registers{$key} > 0) {
	    $jumpval[$pgm] = $val;
	}
	elsif(defined($checkval) && $checkval > 0) {
	    $jumpval[$pgm] = $val;
	}
    }

    return %registers;
}
