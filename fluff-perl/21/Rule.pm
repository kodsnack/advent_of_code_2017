package Rule;

use Data::Dumper;

sub new {
    my $class = shift;
    my $rule = shift;
    my $self = {};

    ($self->{rule}, $self->{replace}) = split(/\ \=\>\ /, $rule);

    $self->{oncount} = grep { $_ eq "#" } split(//, $self->{rule});
    
    bless $self, $class;
    return $self;
}

sub getreplacement {
    my $self = shift;
    return $self->{replace};
}

sub getrule {
    my $self = shift;
    return $self->{rule};
}

sub comparePixelCount {
    my $self = shift;
    my $count = shift;

    return $count == $self->{oncount};
}

sub match {
    my $self = shift;
    my $test = shift;

    return -1 if(length($test) != length($self->{rule}));
    for(0..3) {
	return $_ if($test eq $self->{rule});
	return 10 if(flip($test) eq $self->{rule});

	$test = rotate($test);
    }
    
    return -2;
}

sub rotate {
    my $test = shift;
    my @d;
    foreach my $row (split(/\//, $test)) {
	push @d, [split(//, $row)];
    }
    
    my @o;
    
    for(my $x = 0; $x <= $#d; $x++) {
	for(my $y = 0; $y <= $#d; $y++) {
	    $o[$x][$y] = $d[abs($y-$#d)][$x];
	}
    }
   
    return join("/", map { join("", @{$o[$_]}) } keys @o);
}

sub flip {
    my $test = shift;
    my @d;

    foreach my $row (split(/\//, $test)) {
	push @d, [split(//, $row)];
    }
    
    my @o;
    
    for(my $i = 0; $i <= $#d; $i++) {	
	$o[$i] = [reverse @{$d[$i]}];
    }
    
    return join("/", map { join("", @{$o[$_]}) } keys @o);
}


1;
