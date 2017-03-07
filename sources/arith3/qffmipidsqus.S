/*M
.SH NAME
qffmipidsqus - quadratic function field over modular integers primitive ideal square, special version

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmipidsqus(M, D, C1, Q1, P1, pQ, pP)
int M;
pol D, C1, Q1, P1, *pQ, *pP;
 
.SH DESCRIPTION
.TP 4
.B M
is a prime number, M > 2.
.TP 4
.B D
is a polynomial in Z/MZ[X] in dense-representation, so Z/MZ(X,D^(1/2)) is a quadratic congruence function field.
.TP 4
.B C1, Q1, P1
are polynomials in Z/MZ[X] in dense representation, such that
.IP
I1 = [ Q1, P1 + D^(1/2) ] 
.PP
is a primitive ideal, given in adapted form, i.e.
.IP
.nf
Q1 divides (D - P1^2) 
deg(P1) < deg(Q1)
sign(Q1) = 1.
.PP
Thereby, 
.IP
C1 = ( D - P1^2 ) / Q1        
.PP
is an element in Z/MZ[X] and pre-computed.
.PP
qffmipidsqus computes polynomials in Z/MZ[X] in dense representation, 
say G, Q, P, such that [Q, P+D^(1/2)] is a primitive ideal given in 
adapted form, i.e.    
.IP
.nf
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
qffmipidsqus returns G and writes P and Q to *pP and *pQ respectively.
 

.SH SEE ALSO
.nf
qffmipidsqu
qffmipidpr
qffmipidprs

M*/
                 
/*H
        Version 1       14.06.1994	A.Stein
	Version 2	25.11.1994	BIND-Fehler korrigiert.AS
   DATE qffmipidsqus  : 941201
H*/

#include <_arith3.h>

pol qffmipidsqus(M,D,C1,Q1,P1,pQ,pP)
int M;
pol D,C1,Q1,P1;
pol *pQ,*pP;
{        
	pol G,Y;
	bind(M,D,C1,Q1,P1);
	init(G,Y);

    /* Berechne G,Y mit : G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = udpmisum(M,P1,P1);                                          
	G = udpmihegcd(M,Q1,Y,&Y);

    /*  Setze damit
	P = P1 + (Q1/G) * Y * C1 
	Q = ( Q1 / G ) ^ 2  und normiere Q. Dann ist
	P = P mod Q				    */

	C1 = udpmiprod(M,C1,Y);
	Q1 = udpmiquot(M,Q1,G);
        C1 = udpmiprod(M,C1,Q1);
	P1 = udpmisum(M,P1,C1);
	Q1 = udpmiprod(M,Q1,Q1);
	Q1 = udpmimonic(M,Q1);
	udpmiqrem(M,P1,Q1,&P1);
        
	*pQ = Q1;
	*pP = P1;
	return(G);        
}
