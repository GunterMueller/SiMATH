/*M
.SH NAME
qffmipower - 
quadratic function field over modular integers power

.SH SYNOPSIS
.nf
#include <_arith3.h>

int qffmipower(M, D, d, Qm1, Q, P, dA, E, pQ, pP)
int M, dA, E;
pol D, d, Qm1, Q, P;
pol *pQ, *pP;

dB = qffmipower(M, D, d, Qm1, Q, P, dA, E, pQ, pP)

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in k[X] in dense representation such that
d is the principal part of D^(1/2). (See upmisrpp)
.TP 4
.B Qm1 
= ( D - P^2 ) / Q is in k[X] in dense representation.
.TP 4
.B Q, P 
.RS
are polynomials in k[X] in dense representation, such that
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
are polynomials in k[X] in dense representation, such that
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
qffmipower corresponds to the algorithms POWER and POWERDIST. By leaving d(A)
as an optional input, both algorithms are combined in one. 
Since qffmipower is usually applied to 
a fixed ideal A, the polynomial Qm1 = ( D - P^2 ) / Q can be precomputed.
	
.SH SEE ALSO
.BR qffmibinary(),
.BR qffmiclsum(),
.BR qffmspower(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein	
	DATE qffmipower: 210297
H*/

#include <_arith3.h>

int qffmipower(M,D,d,Qm1,Q,P,dA,E,pQ,pP)
int M, dA, E;
pol D, d, Qm1, Q, P;
pol *pQ, *pP;
{
	single j, f = 0, i;
	unsigned e1;
	pol  Q2, P2;
	bind(M, D, d, Qm1, Q, P, E, dA );
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
		f = qffmibinary(M,D,d,Qm1,Q,P,Q2,P2,f,i,&Q2,&P2);
	}
	while( E != _0 ) {
		e1 = lfirst(E);
		E = lred(E);
		for( j=BLOG2; j; ) {
			i = e1 & (1<< --j);
			f = qffmibinary(M,D,d,Qm1,Q,P,Q2,P2,f,i,&Q2,&P2);
		}
	}
	*pQ = Q2;
	*pP = P2;
	if( dA ) dA = isum(dA,f); /* dA = d(A) != 0 */
	return( dA ); 
}
