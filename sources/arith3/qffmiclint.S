/*M
.SH NAME
qffmiclint - 
quadratic function field over modular integers
closest integer

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmiclint(M, D, d, Q, P, e, pQ, pP)
int M;
single e; 
pol D, d, Q, P, *pQ, *pP;

f = qffmiclint(M, D, d, Q, P, e, pQ, pP); 

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
 A := [ Q, P + Y ] = Q k[X] + (P + Y) k[X]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 Q | ( D - P^2 ), sgn(Q) = 1,
 deg(P) < deg(Q) < deg(D)/2. 
.RE
.RE
.TP 4
.B e
is an integer, 0 <= e < BASIS.
.TP 4
.B *pQ, *pP 
.RS
are polynomials in k[X] in dense representation such that
.RS
 B := [ *pQ, *pP + Y ]
.RE
is a reduced, principal ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ) < deg(D)/2.  
.RE
If d(A) resp. d(B) denote the distance of A resp. B, then
the computed ideal B is the reduced, principal
ideal closest to  d(A) + e.
.RE
.TP 4
.B f 
= d(B) - d(A) - e. f is in Z and -deg(D)/2 <= f <= 0.

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmiclint corresponds to the algorithm CLOSESTINT.

.SH SEE ALSO
.BR qffmibinary(),
.BR qffmibsrpi(),
.BR qffmiclsum(),
.BR qffmigsrpi(),
.BR qffmipower(),
.BR qffmsclint(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmiclint: 210297
H*/

#include <_arith3.h>

single qffmiclint(M,D,d,Q,P,e,pQ,pP)
int M;
single e;
pol D, d, Q, P;
pol *pQ, *pP;
{        
	single rd, delta;
	pol ai, Qim1, Qip1, Pip1, rim1, ri;
	bind(M,D,d,Q,P);
	init(ai,Qim1,Qip1,Pip1,rim1,ri);
	
	/* Initial */
	delta = lfirst(d) - lfirst(Q);
	if( delta > e ) {
	    /* the next reduced, principal ideal, computed
	       by Baby steps, would be right of d(A) + e */
		*pQ = Q;
		*pP = P;
		return( -e );
	}
    /* perform baby steps until close enough to the left */
	Qim1 = Q;
	ai = udpmisum(M,P,d); 
	udpmiqrem(M,ai,Qim1,&rim1);
	Pip1 = udpmidif(M,d,rim1);; 	 
	Q = udpmiprod(M,Pip1,Pip1);
	Q = udpmidif(M,D,Q);
	Q = udpmiquot(M,Q,Qim1); 
	while( delta <= e ) {
		P = Pip1; rd = delta;
		ai = udpmisum(M,P,d);
		ai = udpmiqrem(M,ai,Q,&ri);
		delta = delta + lfirst(ai);
		Pip1 = udpmidif(M,d,ri);
		Qip1 = udpmidif(M,ri,rim1);
		Qip1 = udpmiprod(M,ai,Qip1);
		Qip1 = udpmisum(M,Qim1,Qip1);
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
	}	
	
    /* compute the adapted k[x]-base */
	Qim1 = udpmimonic(M,Qim1);
	udpmiqrem(M,P,Qim1,&P);
	*pQ = Qim1;
	*pP = P;
	return( rd - e);        
}
