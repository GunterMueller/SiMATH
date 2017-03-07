/*M
.SH NAME
qffmsgsrpi - 
quadratic function field over modular singles 
giant step of reduced, principal ideals

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmsgsrpi(m, D, d, Qm1, Q, P, Q2, P2, pQ, pP)
single m;
pol D, d, Qm1, Q, P, Q2, P2;
pol *pQ, *pP;
	
f = qffmsgsrpi(m, D, d, Qm1, Q, P, Q2, P2, pQ, pP);

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
= ( D - P^2 ) / Q is a polynomial in k[X] in dense representation.
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
are polynomials in k[X] in dense representation. If o denotes
the giant step operation (multiply/reduce), then
.RS
 A o B = C := [ *pQ, *pP + Y ], 
.RE
and this operation yields a reduced, principal ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ) < deg(D)/2. 
.RE
.RE
.TP 4
.B f 
= d(C) - d(A) - d(B) and 2 - deg(D) <= f <= 0, where f is in Z and
d(.) denotes the distance of a reduced, principal ideal to (1).

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmsgsrpi corresponds to the algorithm GIANTSTEP.
Since qffmsgsrpi is usually applied to a fixed ideal A,
the polynomial Qm1 = ( D - P^2 ) / Q can be precomputed.

.SH SEE ALSO
.BR qffmigsrpi(),
.BR qffmsgsdrpi(),
.BR qffmsclsum(),
.BR qffmspidpr(),
.BR etc. 
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmsgsrpi: 210297
H*/

#include <_arith3.h>

single qffmsgsrpi(m,D,d,Qm1,Q,P,Q2,P2,pQ,pP)
single m;
pol D, d, Qm1, Q, P, Q2, P2;
pol *pQ, *pP;
{
	single f;
	pol G;
	bind(D, d, Qm1, Q, P, Q2, P2);

    /* ideal product  */
	G = qffmspidprs(m,D,Qm1,Q,P,Q2,P2,&Q2,&P2);
	f = - lfirst(G); 
	 
    /* ideal reduction */
	if( lfirst(Q2) >= lfirst(d) ) f += qffmsrpidred(m,D,d,Q2,P2,&Q2,&P2);
	  
    /* compute the adapted k[X]-base */
	Q2 = udpmsmonic(m,Q2);
	udpmsqrem(m,P2,Q2,&P2);
	*pQ = Q2;
	*pP = P2;
	return( f );
}
