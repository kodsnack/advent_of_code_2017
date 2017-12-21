package Particle;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;

    return $self;
}

sub set {
    my $self = shift;
    my $var = shift;
    my $coord = shift;

    $self->{$var} = $coord;
}

sub setPos {
    my $self = shift;
    my $coord = shift;

    $self->{p} = $coord;
}

sub getPos {
    my $self = shift;

    return $self->{p};
}

sub setVelocity {
    my $self = shift;
    my $velocity = shift;

    $self->{v} = $velocity;
}

sub accelerate {
    my $self = shift;

    for(qw/x y z/) {
	$self->{v}->add($_, $self->{a}->get($_));
    }
}

sub updatepos {
    my $self = shift;

    push @{$self->{h}}, $self->{p}->clone;
    
    for(qw/x y z/) {
	$self->{p}->add($_, $self->{v}->get($_));
    }
    return $self->{p};
}

sub getmd {
    my $self = shift;
    my $d = $self->{h}[-1];

    my $sum = 0;
    for(qw/x y z/) {
	$sum += abs($self->{p}->get($_) - $d->get($_));
    }

    return $sum;
}

1;
