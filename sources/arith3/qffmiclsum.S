/*M
.SH NAME
qffmiclsum - 
quadratic function field over modular integers
closest sum

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmiclsum(M, D, d, Qm1, Q, P, Q2, P2, pQ, pP)
int M;
pol D, d, Qm1, Q, P, Q2, P2;
pol *pQ, *pP;

f = qffmiclsum(M, D, d, Qm1, Q, P, Q2, P2, pQ, pP); 

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
.B Q, P, Q2, P2
.RS
are polynomials in k[X] in dense representation, such that
.RS
 A := [ Q,  P  + Y ] = Q  k[X] + (P  + Y) k[X],
 B := [ Q2, P2 + Y ] = Q2 k[X] + (P2 + Y) k[X]  
.RE
are reduced, principal ideals in adapted form, i.e.
.RS
 Q  | ( D - P^2 ),  deg(P)  < deg(Q)  < deg(D)/2, 
 Q2 | ( D - P2^2 ), deg(P2) < deg(Q2) < deg(D)/2, 
 sgn(Q) = 1 = sgn(Q2).
.RE
.RE
.TP 4
.B *pQ, *pP 
.RS
are polynomials in k[X] in dense representation, such that
.RS
 C := [ *pQ, *pP + Y ]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ) < deg(D)/2.  
.RE
If d(.) denotes the distance of a reduced, principal ideal, then
the computed ideal C is the reduced, principal
ideal closest to  d(A) + d(B).
.RE
.TP 4
.B f 
= d(C) - d(A) - d(B). f is in Z and -deg(D)/2 <= f <= 0.

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmiclsum corresponds to the algorithm CLOSESTSUM. 
Since qffmiclsum is usually applied to 
a fixed ideal A, the polynomial Qm1 = ( D - P^2 ) / Q can be precomputed.
.SH SEE ALSO
.BR qffmibinary(),
.BR qffmibsrpi(),
.BR qffmiclint(),
.BR qffmigsrpi(),
.BR qffmipower(),
.BR qffmsclsum(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmiclsum: 210297
H*/

#include <_arith3.h>

single qffmiclsum(M,D,d,Qm1,Q,P,Q2,P2,pQ,pP)
int M;
pol D, d, Qm1, Q, P, Q2, P2;
pol *pQ, *pP;
{
	single f;
	bind(M, D, d, Qm1, Q, P, Q2, P2);

	f = qffmigsrpi(M,D,d,Qm1,Q,P,Q2,P2,&Q2,&P2);
	f  = qffmiclint(M,D,d,Q2,P2,(-f),&Q2,&P2);
	*pQ = Q2;
	*pP = P2;
	return( f );
}

