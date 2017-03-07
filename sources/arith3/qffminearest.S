/*M
.SH NAME
qffminearest\- 
quadratic function field over modular singles nearest
.\"(M, D, d, E, pQ, pP)

.SH SYNOPSIS
.nf
#include <_arith3.h>

qffminearest(M, D, d, E, pQ, pP)
int M, E;
pol D, d;
pol *pQ, *pP;

f = qffminearest(M, D, d, E, &pQ, &pP);

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2.
.TP 4
.B D 
is a monic, squarefree polynomial in Z/MZ[X] of even degree
in dense representation. This means that
Z/MZ(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in Z/MZ[X] in dense representation such that
d is the principal part of D^(1/2). (See upmisrpp)
.RE
Let d(.) denote the distance of a reduced, principal ideal to (1).
.RE
.TP 4
.B E
is an integer, E > 0.
.TP 4
.B *pQ, *pP 
.RS
are polynomials in Z/MZ[X] in dense representation, such that
.RS
 B := [ *pQ, *pP + Y ]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ) < deg(D)/2.  
.RE
The computed ideal B is the reduced, principal
ideal closest to E.
.RE
.TP 4
.B f = d(B) - E. f is in Z and -deg(D)/2 <= f <= 0.

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffminearest corresponds to the algorithms NEAREST.
	
.SH SEE ALSO
.BR qffmipower(),
.BR qffmsnearest(),
.BR qffmspower()
.BR etc.
M*/
/*H
	Version 1	25.07.97	A. Stein
H*/

#include <_arith3.h>

single qffminearest(M, D, d, E, pQ, pP)
int M, E;
pol D, d;
pol *pQ, *pP;
{
	single f, r;
	int dA; 
	pol  Q, P, C;
	bind( M, D, d, E );
	init( Q, P, C, dA );

	f = lfirst( d );
   if( icomp( E, f ) < 0  ) { 
	*pQ = list2( 0, 1 ); 
	*pP = 0; 
	return( -E );
   }  
	Q = udpmidif( M, D, udpmiprod( M, d, d ) );
	P = d;
        Q = udpmimonic( M, Q );
        udpmiqrem( M, P, Q, &P );
	C = udpmiprod( M, P, P );
	C = udpmidif( M, D, C );
	C = udpmiquot( M, C, Q );
	isqrem( E, f, &dA, &r );
        dA = qffmipower( M, D, d, C, Q, P, f, dA, &Q, &P );
	f = idif( E, dA ); 
	f = qffmiclint( M, D, d, Q, P, f, &Q, &P );

	*pQ = Q;
	*pP = P;
	return( f ); 
}
