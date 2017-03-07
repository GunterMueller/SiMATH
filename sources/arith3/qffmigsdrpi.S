/*M
.SH NAME
qffmigsdrpi - 
quadratic function field over modular integers 
giant step double of reduced, principal ideals

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmigsdrpi(M, D, d, Q, P, pQ, pP)
int M;
pol D, d,  Q, P;
pol *pQ, *pP;
	
f = qffmigsdrpi(M, D, d, Q, P, pQ, pP)

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
.B Q, P
.RS
are polynomials in k[X] in dense representation, such that
.RS
 A := [ Q,  P  + Y ] = Q  k[X] + (P  + Y) k[X] 
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 Q  | ( D - P^2 ), sgn(Q) = 1,
 deg(P)  < deg(Q)  < deg(D)/2.
.RE
.RE
.TP 4
.B *pQ, *pP 
.RS
are polynomials in k[X] in dense representation. If o denotes
the giant step operation (multiply/reduce), then
.RS
 A o A = C := [ *pQ, *pP + Y ], 
.RE
and this operation yields a reduced, principal ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ) < deg(D)/2.
.RE
.RE
.TP 4
.B f 
= d(C) - 2 d(A) and 2 - deg(D) <= f <= 0, where f is in Z and 
d(.) denotes the distance of a reduced principal ideal to (1).

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmigsdrpi corresponds to the algorithm GIANTSTEP (see qffmigsrpi),
where, in this particular case, the input ideals are equal.
.SH SEE ALSO
.BR qffmiclsum(),
.BR qffmigsrpi(),
.BR qffmipidsqu(),
.BR qffmsgsdrpi(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein	
	DATE qffmigsdrpi: 210297
H*/

#include <_arith3.h>

single qffmigsdrpi(M,D,d,Q,P,pQ,pP)
int M;
pol D, d,  Q, P;
pol *pQ, *pP;
{
	single f;
	pol G, Qm1;
	bind(M, D, d, Q, P);

    /* Qm1 = (D-P^2)/Q */
	Qm1 = udpmiprod(M,P,P);
	Qm1 = udpmidif(M,D,Qm1);
	Qm1 = udpmiquot(M,Qm1,Q);

    /* ideal product  */
	G = qffmipidsqus(M,D,Qm1,Q,P,&Q,&P);
	f = - lfirst(G);  
	 
    /* ideal reduction */
	if( lfirst(Q) >= lfirst(d) ) f += qffmirpidred(M,D,d,Q,P,&Q,&P);  
	  
    /* Compute the adapted k[X]-base */
	Q = udpmimonic(M,Q);
	udpmiqrem(M,P,Q,&P);
	*pQ = Q;
	*pP = P;
	return( f );
}
