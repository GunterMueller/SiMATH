/*M
.SH NAME
qffmsnearest\- 
quadratic function field over modular singles nearest
.\"(m, D, d, E, pQ, pP)

.SH SYNOPSIS
.nf
#include <_arith3.h>

qffmsnearest(m, D, d, E, pQ, pP)
single m;
int E;
pol D, d;
pol *pQ, *pP;

f = qffmsnearest(m, D, d, E, &pQ, &pP);

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS.
.TP 4
.B D 
is a monic, squarefree polynomial in Z/mZ[X] of even degree
in dense representation. This means that
Z/mZ(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in Z/mZ[X] in dense representation such that
d is the principal part of D^(1/2). (See upmssrpp)
.RE
Let d(.) denote the distance of a reduced, principal ideal to (1).
.RE
.TP 4
.B E
is an integer, E > 0.
.TP 4
.B *pQ, *pP 
.RS
are polynomials in Z/mZ[X] in dense representation, such that
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
qffmsnearest corresponds to the algorithms NEAREST.
	
.SH SEE ALSO
.BR qffminearest(),
.BR qffmspower(),
.BR qffmipower(),
.BR etc.
M*/
/*H
	Version 1	25.07.97	A. Stein
H*/

#include <_arith3.h>

single qffmsnearest(m, D, d, E, pQ, pP)
single m;
int E;
pol D, d;
pol *pQ, *pP;
{
	single f, r;
	int dA; 
	pol  Q, P, C;
	bind( D, d, E );
	init( Q, P, C, dA );

	f = lfirst( d );
   if( icomp( E, f ) < 0  ) { 
	*pQ = list2( 0, 1 ); 
	*pP = 0; 
	return( -E );
   }  
	Q = udpmsdif( m, D, udpmsprod( m, d, d ) );
	P = d;
        Q = udpmsmonic( m, Q );
        udpmsqrem( m, P, Q, &P );
	C = udpmsprod( m, P, P );
	C = udpmsdif( m, D, C );
	C = udpmsquot( m, C, Q );
	isqrem( E, f, &dA, &r );
        dA = qffmspower( m, D, d, C, Q, P, f, dA, &Q, &P );
	f = idif( E, dA ); 
	f = qffmsclint( m, D, d, Q, P, f, &Q, &P );

	*pQ = Q;
	*pP = P;
	return( f ); 
}
