/*M
.SH NAME
qffmipitest \- 
quadratic function field over modular singles,
sort of principal ideal testing
.\" ( q, D, d, H1, B )

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmipitest( q, D, d, H1, B )
pol D, d;
int q, H1, B; 

h0 = qffmipitest( q, D, d, H1, B );

.SH DESCRIPTION
.TP 4
.B q
is a prime integer, q > 2. Let k := Z/qZ.

.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.

.TP 4
.B d 
= principal part of D^(1/2) in dense representation.

.TP 4
.B H1
is a multiple of the regulator R of k(X,Y) such that
 H1 = h0 * R and H1 < B.

.TP 4
.B B is an integer > 1. 
.TP 4
.B h0 
= h0 = H1 / R.

.SH LITERATURE
A. Stein, "Algorithmen in reell-quadratischen Kongruenz-
funktionenk"orpern",
PhD Thesis, Universit"at des Saarlandes, Saarbr"ucken, 1996.

A. Stein, H.C. Williams, "Some methods for evaluating the
regulator of a real quadratic function field",  1997.

.SH NOTE
The algorithm corresponds to PITEST, but first determines the integer 
factorization of H1 and then tries the factors of H1 up to B.

.SH SEE ALSO
.BR qffmsreglap(),
.BR qffmsreglapv(),
.BR qffmspitest()
M*/
/*H
        Version 1       12.08.1997	Andreas Stein  
H*/
#include <_arith3.h>

int qffmipitest( M, D, d, H1, B )
pol D, d;
int M, H1, B; 
{
	int a, HH, h0;
	list LP;
	pol Q, P;
	bind( M, D, d, H1, B );
	init( LP, a, HH, Q, P, h0 );

	LP = ifact( H1 );
	h0 = 1;
	while( LP != _0 && icomp( B, lfirst( LP ) ) >= 0 ) {
		a = lfirst( LP );
		LP = lred( LP );
		HH = iquot( H1, a );
		qffminearest( M, D, d, HH, &Q, &P );
		if( !lfirst( Q ) ) {
			h0 = iprod( a, h0 );
			B = isum( 1, iquot( B, a ) );
			H1 = iquot( H1, a );
		}
		else {
		   for( ;LP != _0 && !icomp( a, lfirst( LP ) ); LP = lred( LP ) ); 
		}
	}
	return( h0 );
}