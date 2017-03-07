/*M
.SH NAME
qffmsgsdrpi - 
quadratic function field over modular singles 
giant step double of reduced, principal ideals

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmsgsdrpi(m, D, d, Q, P, pQ, pP)
single m;
pol D, d, Q, P;
pol *pQ, *pP;
	
f = qffmsgsdrpi(m, D, d, Q, P, pQ, pP);

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
.B Q, P
.RS
are polynomials in k[X] in dense representation, such that
.RS
 A := [ Q,  P  + Y ] = Q  k[X] + (P  + Y) k[X]  ,
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
 A o A = C := [ *pQ, *pP + Y ] 
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
qffmsgsdrpi corresponds to the algorithm GIANTSTEP (see qffmsgsrpi),
where, in this particular case, the input ideals are equal.

.SH SEE ALSO
.BR qffmigsdrpi(),
.BR qffmsclsum(),
.BR qffmsgsrpi(),
.BR qffmspidsqu(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmsgsdrpi: 210297
H*/

#include <_arith3.h>

single qffmsgsdrpi(m,D,d,Q,P,pQ,pP)
single m;
pol D, d, Q, P;
pol *pQ, *pP;
{
	single f;
	pol G, Qm1;
	bind(D, d, Q, P);

    /* Qm1 = (D-P^2)/Q */
	Qm1 = udpmsprod(m,P,P);
	Qm1 = udpmsdif(m,D,Qm1);
	Qm1 = udpmsquot(m,Qm1,Q);

    /* ideal product  */
	G = qffmspidsqus(m,D,Qm1,Q,P,&Q,&P);
	f = - lfirst(G); 
	 
    /* ideal reduction */
	if( lfirst(Q) >= lfirst(d) ) f += qffmsrpidred(m,D,d,Q,P,&Q,&P);
	  
    /* compute the adapted k[X]-base */
	Q = udpmsmonic(m,Q);
	udpmsqrem(m,P,Q,&P);
	*pQ = Q;
	*pP = P;
	return( f );
}
