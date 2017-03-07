/*M
.SH NAME
qffmsspidsqs - quadratic function field over modular singles, sparse representation, primitive ideal square, special version

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmsspidsqs(m, D, C1, Q1, P1, pQ, pP)
single m; 
pol D ,C1 ,Q1 ,P1; pol *pQ, *pP;
  
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS. Let k := Z/mZ.    
.TP 4
.B D
is a squarefree polynomial in k[X], such that k(X,Y), where Y^2 = D, is a quadratic congruence function field.
.TP 4
.B C1
= ( D - P1^2 ) / Q1 is in k[X] in sparse representation.    
.TP 4 
.B  Q1, P1
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
qffmsspidsqs computes polynomials G, Q, P in k[X] such that  
such that [Q, P+D^(1/2)] is a primitive ideal given in
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
qffmsspidsqs returns G and writes P and Q to *pP and *pQ respectively.

.SH SEE ALSO
.nf 
qffmsspidsqs
qffmsspidpr
qffmsspidprs

M*/
                     
/*H
        Version 1      	06.07.1992	A.Stein
	Version 2	25.11.1994	BIND-Fehler korrigiert.AS
   DATE qffmsspidsqs  : 921130.941201
H*/

#include <_arith3.h>

pol qffmsspidsqs(m,D,C1,Q1,P1,pQ,pP)
single m;
pol D, C1, Q1, P1;
pol *pQ, *pP;
{        
	pol G, Y;
	bind(D,C1,Q1,P1);
	init(G,Y);

    /* Berechne G, Y mit : G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = pmssum(1,m,P1,P1);                                          
	G = upmshegcd(m,Q1,Y,&Y);

    /*  Setze damit
	P = P1 + (Q1/G) * Y * C1 
	Q = ( Q1 / G ) ^ 2  und normiere Q. Dann ist
	P = P mod Q				    */

	C1 = pmsprod(1,m,C1,Y);
	Q1 = pmsquot(1,m,Q1,G);
        C1 = pmsprod(1,m,C1,Q1);
	P1 = pmssum(1,m,P1,C1);
	Q1 = pmsprod(1,m,Q1,Q1);
	Q1 = pmsmonic(1,m,Q1);
	P1 = upmsrem(m,P1,Q1);
        
	*pQ = Q1;
	*pP = P1;
	return(G);        
}
