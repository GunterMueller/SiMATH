/*M
.SH NAME
qffmsspidsqu - quadratic function field over modular singles, sparse representation, primitive ideal square

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmsspidsqu(m, D, Q1, P1, pQ, pP)
single m;
pol D, Q1, P1, *pQ, *pP;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS. Let k := Z/mZ.
.TP 4
.B D
is a squarefree polynomial in k[X], such that k(X,Y), where Y^2 = D, is a quadratic congruence function field.
.TP 4
.B Q1, P1
.RS
are polynomials in k[X] in sparse representation, such that
Q1 | ( D - P1^2 )
.RS
 A1 := [ Q1, P1 + Y ] = Q1 k[X] + (P1 + Y) k[X]
.RE
is a primitive ideal.
.PP
qffmsspidsqu computes polynomials G, Q, P in k[X] such that
.RS
 A_1 A_1 = (G) [ *pQ, *pP + Y ],
.RE
where [ *pQ, *pP + Y ] is a primitive ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ).
.RE
Also, sgn(G) = 1.
.RE 
qffmsspidsqu writes Q and P to *pQ and *pP respectively and returns G.  

.SH SEE ALSO
.nf
qffmsspidsqus
qffmsspidpr
qffmsspidprs

M*/
                     
/*H
        Version 1       06.07.1992	A.Stein
   DATE qffmsspidsqu  : 921130
H*/

#include <_arith3.h>

pol qffmsspidsqu(m,D,Q1,P1,pQ,pP)
single m;
pol D, Q1, P1;
pol *pQ, *pP;
{        
	pol C1, G, Y;
	bind(D,Q1,P1);
	init(G,C1,Y);

    /* Bestimme die adaptierte Basisv on I1 */
	Q1 = pmsmonic(1,m,Q1);
        if( lfirst(P1) >= lfirst(Q1) ) P1 = upmsrem(m,P1,Q1); 

    /* Berechne G,Y mit : G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = pmssum(1,m,P1,P1);                                          
	G = upmshegcd(m,Q1,Y,&Y);

    /*  Setze damit
	P = P1 + (Q1/G) * Y * (D - P1^2) / Q1 
	Q = ( Q1 / G ) ^ 2  und normiere Q. Dann ist
	P = P mod Q				    */

	C1 = pmsprod(1,m,P1,P1);
	C1 = pmsdif(1,m,D,C1);
	C1 = pmsquot(1,m,C1,Q1);
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
