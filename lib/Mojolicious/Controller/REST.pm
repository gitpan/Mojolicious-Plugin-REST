package Mojolicious::Controller::REST;

use Mojo::Base 'Mojolicious::Controller';

sub data {
	my $self = shift;
	my %data = @_;

	my $json = $self->stash('json');

	if ( defined( $json->{data} ) ) {
		@{ $json->{data} }{ keys %data } = values %data;
	}
	else {
		$json->{data} = {%data};
	}

	$self->stash( json => $json );
	return $self;

}

sub message {
	my $self = shift;
	my ( $message, $severity ) = @_;

	$severity //= 'warn';

	my $json = $self->stash('json');

	if ( defined( $json->{messages} ) ) {
		push( $json->{messages}, { text => $message, severity => $severity } );
	}
	else {
		$json->{messages} = [ { text => $message, severity => $severity } ];
	}

	$self->stash( json => $json );
	return $self;
}

sub message_info { $_[0]->message( $_[1], 'info' ) }

sub status {
	my $self   = shift;
	my $status = shift;
	$self->stash( 'status' => $status );
	return $self;
}

1;

__END__

=pod

=head1 NAME

Mojolicious::Controller::REST

=head1 VERSION

version 0.001

=head1 AUTHOR

Abhishek Shende <abhishekisnot@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Abhishek Shende.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
