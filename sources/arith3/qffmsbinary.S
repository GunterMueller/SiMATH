/*M
.SH NAME
qffmsbinary - 
quadratic function field over modular singles binary step

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmsbinary(m, D, d, Qm1, Q, P, Q2, P2, f0, i, pQ, pP)
single m, f0, i;
pol D, d, Qm1, Q, P, Q2, P2;
pol *pQ, *pP;

f = qffmsbinary(m, D, d, Qm1, Q, P, Q2, P2, f0, i, pQ, pP)

.SH DESCRIPTION
.TP 4
.B m
is a prime integer, 2 < m < BASIS. Let k := Z/mZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in k[X] in dense representation such that
d is the principal part of D^(1/2). (See upmssrpp)
.TP 4
.B Qm1 
= ( D - P^2 ) / Q is in k[X] in dense representation.
.TP 4
.B Q, P, Q2, P2
.RS
are polynomials in k[X] in dense representation, such that
.RS
 A := [ Q , P   + Y ] = Q  k[X] + (P  + Y) k[X],
 B := [ Q2, P2  + Y ] = Q2 k[X] + (P2 + Y) k[X]
.RE
are reduced, principal ideals in adapted form, i.e.
.RS
 Q  | ( D - P^2 ),  deg(P)  < deg(Q)  < deg(D)/2, 
 Q2 | ( D - P2^2 ), deg(P2) < deg(Q2) < deg(D)/2, 
 sgn(Q) = 1 = sgn(Q2).
.RE
Let d(.) denote the distance of a reduced, principal ideal to (1).
For a not necessary known integer s > 0, it is required that
B is the reduced, principal ideal closest to   s d(A). 
.RE
.TP 4
.B f0 
= d(B) - s d(A). f0 is in Z and -deg(D)/2 <= f0 <= 0.
.TP 4
.B i
is in {0,1}.
.TP 4
.B *pQ, *pP 
.RS
are polynomials in k[X] in dense representation such that
.RS
C := [ *pQ, *pP + Y ]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ) < deg(D)/2. 
.RE
The computed ideal C is the reduced, principal
ideal closest to   ( 2 s + i ) d(A).
.RE
.TP 4
.B f 
= d(C) - ( 2 s + i ) d(A). f is in Z and 
 -deg(D)/2 <= f <= 0.

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmsbinary corresponds to the algorithm BINARY. It performs one iteration
in the binary exponentiation. Note that the integer s itself can be large,
but must not be precomputed. Since qffmsbinary is usually applied to 
a fixed ideal A, the polynomial Qm1 = ( D - P^2 ) / Q can be precomputed.

.SH SEE ALSO
.BR qffmibinary(),
.BR qffmsclint(),
.BR qffmsclsum(),
.BR qffmsgsrpi(),
.BR qffmspower(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmsbinary: 210297
H*/

#include <_arith3.h>

single qffmsbinary(m,D,d,Qm1,Q,P,Q2,P2,f0,i,pQ,pP)
single m, f0, i;
pol D, d, Qm1, Q, P, Q2, P2;
pol *pQ, *pP;
{
	single l, f;
	bind(D, d, Qm1, Q, P, Q2, P2);

	l = qffmscld(m,D,d,Q2,P2,&Q2,&P2);        /* CLOSESTSUM of B and B */
	f  = qffmsclint(m,D,d,Q2,P2,(-l-2*f0),&Q2,&P2);      /* CLOSESTINT */
	if( i ) {
		l = qffmsclsum(m,D,d,Qm1,Q,P,Q2,P2,&Q2,&P2); /* CLOSESTSUM */
		f = qffmsclint(m,D,d,Q2,P2,(-l-f),&Q2,&P2);  /* CLOSESTINT */
	}
	*pQ = Q2;
	*pP = P2;
	return( f );
}

