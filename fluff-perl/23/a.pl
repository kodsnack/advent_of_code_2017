#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @instructions;
my @reg;
my @queues;
my $lastplayed;
my %registers;
my $count = 0;

for(qw/a b c d e f g h/) {
    $registers{$_} = 0;
}

while(my $r = <STDIN>) {
    chomp($r);
    push @instructions, [split(/\ /, $r)];
}

my $i = 0;
while($i < $#instructions) {
    my $instr = $instructions[$i];
    
    if($instr->[0] eq "set") {
	$registers{$instr->[1]} = get($instr->[2]);
    }
    elsif($instr->[0] eq "sub") {
	$registers{$instr->[1]} -= get($instr->[2]);
    }
    elsif($instr->[0] eq "mul") {
	$registers{$instr->[1]} *= get($instr->[2]);
	$count++;
    }
    elsif($instr->[0] eq "jnz") {
	if(get($instr->[1]) != 0) {
	    $i += get($instr->[2]);
	    next;
	}
    }
    $i++;
}
print $count;

sub get {
    my $t = shift;
    
    return $t =~ /^(\-?\d+)$/ ? $t : $registers{$t};
}
