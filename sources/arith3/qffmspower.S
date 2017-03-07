/*M
.SH NAME
qffmspower - 
quadratic function field over modular singles power

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmspower(m, D, d, Qm1, Q, P, dA, E, pQ, pP)
single m;
int dA, E;
pol D, d, Qm1, Q, P;
pol *pQ, *pP;

dB = qffmspower(m, D, d, Qm1, Q, P, dA, E, pQ, pP)

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
.TP 4
.B Qm1 
= ( D - P^2 ) / Q is in Z/mZ[X] in dense representation.
.TP 4
.B Q, P 
.RS
are polynomials in Z/mZ[X] in dense representation, such that
.RS
A := [ Q, P + Y ] = Q k[X] + (P + Y) k[X]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 Q | ( D - P^2 ), sgn(Q) = 1,
 deg(P) < deg(Q) < deg(D)/2. 
.RE
Let d(.) denote the distance of a reduced, principal ideal to (1).
.RE
.TP4
.B dA
= d(A) or 0 , optionally, depending on whether or not d(B) shall be computed.
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
ideal closest to  E d(A).
.RE
.TP 4
.B dB
= 0, if dA = 0.
.TP 4
.B dB
= d(B), otherwise.

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmspower corresponds to the algorithms POWER and POWERDIST. By leaving d(A)
as an optional input, both algorithms are combined in one. 
Since qffmspower is usually applied to 
a fixed ideal A, the polynomial Qm1 = ( D - P^2 ) / Q can be precomputed.
	
.SH SEE ALSO
.BR qffmipower(),
.BR qffmsbinary(),
.BR qffmsclsum(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmspower: 210297
H*/

#include <_arith3.h>

int qffmspower(m,D,d,Qm1,Q,P,dA,E,pQ,pP)
single m;
int dA, E;
pol D, d, Qm1, Q, P;
pol *pQ, *pP;
{
	single j, f = 0, i;
	unsigned e1;
	pol  Q2, P2;
	bind(D, d, Qm1, Q, P, E, dA );
	init( Q2, P2 );

    /* the usual binary exponentiation in SIMATH */
	P2 = P;
	Q2 = Q;
	if( dA ) dA = iprod(dA,E); /* dA = d(A) != 0 */
	if( issingle(E) ) { e1 = E; E = _0; }
	else { E = lcinv(E); e1 = lfirst(E); E = lred(E); }
	for(j = BLOG2; !(e1 & (1<< --j)); );
	for ( ; j; ) {
		i = e1 & (1<< --j);
		f = qffmsbinary(m,D,d,Qm1,Q,P,Q2,P2,f,i,&Q2,&P2);
	}
	while( E != _0 ) {
		e1 = lfirst(E);
		E = lred(E);
		for( j=BLOG2; j; ) {
			i = e1 & (1<< --j);
			f = qffmsbinary(m,D,d,Qm1,Q,P,Q2,P2,f,i,&Q2,&P2);
		}
	}
	*pQ = Q2;
	*pP = P2;
	if( dA ) dA = isum(dA,f); /* dA = d(A) != 0 */
	return( dA ); 
}
