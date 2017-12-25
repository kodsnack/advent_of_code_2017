package Bridge;

use parent 'Clone';

sub new {
    my $class = shift;
    my $self = {};

    bless $self, $class;
    return $self;
}

sub addComponent {
    my $self = shift;
    my $c = shift;

    push @{$self->{cs}}, $c;
}

sub getCompString {
    my $self = shift;

    return join(" + ", map { $_->getPortString() } @{$self->{cs}});
}

sub getStrength {
    my $self = shift;

    my $s = 0;
    foreach my $c (@{$self->{cs}}) {
	$s += $c->getValue();
    }

    return $s;
}

sub getLength {
    my $self = shift;
    
    return defined($self->{cs}) ? $#{$self->{cs}} : 0;
}

1;
