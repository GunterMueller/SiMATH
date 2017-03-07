/*M
.SH NAME
qffmicld - 
quadratic function field over modular integers
closest double

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmicld(M, D, d, Q, P, pQ, pP)
int M;
pol D, d, Q, P, *pQ, *pP;

f = qffmicld(M, D, d, Q, P, pQ, pP); 

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
ideal closest to  2 d(A).
.RE
.TP 4
.B f 
= d(B) - 2 d(A). f is in Z and -deg(D)/2 <= f <= 0.

.SH LITERATURE
R. Scheidler, A. Stein, H. C. Williams:	
"Key-exchange in real quadratic congruence function fields",
Designs, Codes and Cryptography 7, No. 1/2 (1996), 153-174.

.SH NOTE
qffmicld corresponds to the algorithm CLOSESTSUM (see qffmiclsum), 
where, in this particular case, the input ideals are equal.

.SH SEE ALSO
.BR qffmibinary(),
.BR qffmiclsum(),
.BR qffmigsrpi(),
.BR qffmscld(),
.BR etc.
M*/
/*H
	Version 1	30.11.1994	A. Stein
	DATE qffmicld: 210297
H*/

#include <_arith3.h>

single qffmicld(M,D,d,Q,P,pQ,pP)
int M;
pol D, d, Q, P;
pol *pQ, *pP;
{
	single f;
	bind(M, D, d, Q, P);

	f = qffmigsdrpi(M,D,d,Q,P,&Q,&P);     /* GIANTSTEP  */
	f = qffmiclint(M,D,d,Q,P,(-f),&Q,&P); /* CLOSESTINT */
	*pQ = Q;
	*pP = P;
	return( f );
}
