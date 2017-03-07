/*M
.SH NAME
qffmispidsqs - quadratic function field over modular integers, sparse representation, primitive ideal square, special version

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmispidsqs(M, D, C1, Q1, P1, pQ, pP)  
int M;
pol D, C1, Q1, P1, *pQ, *pP;
 
.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B D
is a squarefree polynomial in k[X]
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a quadratic congruence function field.
.TP 4
.B C1, Q1, P1 
are polynomials in k[X] such that
.IP
I1 := [Q1, P1 + D^(1/2)] 
.PP
is a primitive ideal, given in adapted form, i.e.
.IP
 Q1 divides (D - P1^2)
 deg(P1) < deg(Q1)
 sign(Q1) = 1.
.PP
Thereby,
.IP
C1 = ( D - P1^2 ) / Q1
.PP
is an element in Z/k[X] and precomputed. 
.PP
qffmipidsqus computes polynomials in Z/k[X], say G, Q, P, such that [Q, P+D^(1/2)] is a primitive ideal given in
adapted form, i.e.
.IP
 Q divides (D - P^2)
 deg(P) < deg(Q)
 sign(Q) = 1
.PP
and
.IP
I1 * I1 = (G) [ Q, P + D^(1/2) ]
.PP
is an integral ideal with sign(G) = 1.
.PP
qffmispidsqs returns G and writes P and Q to *pP and *pQ respectively.       

.SH SEE ALSO
.nf
qffmispidsqu
qffmispidpr
qffmispidprs

M*/         
                      
/*H
        Version 1      13.06.1994	A.Stein
	DATE qffmispidsqs: 210297
H*/

#include <_arith3.h>

pol qffmispidsqs(M,D,C1,Q1,P1,pQ,pP)
int M;
pol D, C1, Q1, P1;
pol *pQ, *pP;
{        
	pol G, Y;
	bind(M,D,C1,Q1,P1);
	init(G,Y);

    /* Berechne G, Y mit : G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = pmisum(1,M,P1,P1);                                          
	G = upmihegcd(M,Q1,Y,&Y);

    /*  Setze damit
	P = P1 + (Q1/G) * Y * C1 
	Q = ( Q1 / G ) ^ 2  und normiere Q. Dann ist
	P = P mod Q				    */

	C1 = pmiprod(1,M,C1,Y);
	Q1 = pmiquot(1,M,Q1,G);
        C1 = pmiprod(1,M,C1,Q1);
	P1 = pmisum(1,M,P1,C1);
	Q1 = pmiprod(1,M,Q1,Q1);
	Q1 = pmimonic(1,M,Q1);
	P1 = upmirem(M,P1,Q1);
        
	*pQ = Q1;
	*pP = P1;
	return(G);        
}
