package Coord;

use parent 'Clone';

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    for(qw/x y z/) {
	$self->{$_} = 0;
    }
    return $self;
}

sub setCoord {
    my $self = shift;
    my $x = shift;
    my $y = shift;
    my $z = shift;

    $self->{x} = $x;
    $self->{y} = $y;
    $self->{z} = $z;
}

sub getCoord {
    my $self = shift;
    return $self->{x}, $self->{y}, $self->{z};
}

sub get {
    my $self = shift;
    my $axis = shift;
    return $self->{$axis};
}

sub set {
    my $self = shift;
    my $axis = shift;
    my $val = shift;
    $self->{$axis} = $val;
}

sub add {
    my $self = shift;
    my $axis = shift;
    my $val = shift;
    $self->{$axis} += $val;

    return $self->{$axis};
}

1;
