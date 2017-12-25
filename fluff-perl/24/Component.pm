package Component;
sub new {
    my $class = shift;
    my $pin = shift;
    my $self = {};
    
    ($self->{p1}, $self->{p2}) = split(/\//, $pin);
    bless $self, $class;
    return $self;
}
    
sub hasPort {
    my $self = shift;
    my $test = shift;
    return ($self->{p1} == $test || $self->{p2} == $test);
}

sub hasPorts {
    my $self = shift;
    my $t1 = shift;
    my $t2 = shift;

    if(($self->{p1} == $t1 && $self->{p2} == $t2) ||
       ($self->{p2} == $t1 && $self->{p1} == $t2))
    {
	return 1;
    }
    else {
	return 0;
    }
}

sub getOtherPort {
    my $self = shift;
    my $test = shift;
    if($self->{p1} == $test) {
	return $self->{p2};
    }
    elsif($self->{p2} == $test) {
	return $self->{p1};
    }
    else {
	warn "Port $test doesn't match this Components configuration";
    }
}
sub getPortString {
    my $self = shift;
    return $self->{p1} . "/" . $self->{p2};
}

sub getValue {
    my $self = shift;

    return $self->{p1} + $self->{p2};
}

1;
