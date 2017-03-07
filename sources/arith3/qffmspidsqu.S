/*M
.SH NAME
qffmspidsqu - quadratic function field over modular singles primitive ideal square

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmspidsqu(m, D, Q1, P1, pQ, pP)  
single m; 
pol D, Q1, P1, *pQ, *pP;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X] in dense representation, i.e. Z/mZ(X,D^(1/2)) is a quadratic function field.
.TP 4
.B Q1, P1
are polynomials in Z/mZ[X] in dense representation, such that
    I1 := [ Q1, P1 + D^(1/2) ]
.IP
is a primitive ideal, i.e
    Q1 divides (D - P1^2).
.PP
qffmspidsqu computes three polynomials in Z/mZ[X] in dense representation, say G, Q and P, such that
.IP
I1 * I1 = (G) [ Q, P + D^(1/2) ].
.PP
[ Q, P + D^(1/2) ] is a primitive ideal, given in adapted form, such that
    Q divides D-P^2,
    Deg(P) < Deg(Q),
    sign(Q) = 1,
    sign(G) = 1 holds.
.PP
qffmspidsqu returns G and writes Q and P to *pQ and *pP respectively.
                
.SH SEE ALSO
qffmspidsqus

M*/
           
/*H
        Version 1       15.05.1991	A.Stein
   DATE qffmspidsqu   : 910715.9203__
H*/


#include <_arith3.h>

pol qffmspidsqu(m,D,Q1,P1,pQ,pP)
single m;
pol D,Q1,P1;
pol *pQ,*pP;
{        
	pol C1,G,Y;
	bind(D,Q1,P1);
	init(G,C1,Y);

    /* Bestimme die adaptierte Basisv on I1 */
	Q1 = udpmsmonic(m,Q1);
        if( lfirst(P1) >= lfirst(Q1) ) udpmsqrem(m,P1,Q1,&P1); 

    /* Berechne G,Y mit : G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = udpmssum(m,P1,P1);                                          
	G = udpmshegcd(m,Q1,Y,&Y);

    /*  Setze damit
	P = P1 + (Q1/G) * Y * (D - P1^2) / Q1 
	Q = ( Q1 / G ) ^ 2  und normiere Q. Dann ist
	P = P mod Q				    */

	C1 = udpmsprod(m,P1,P1);
	C1 = udpmsdif(m,D,C1);
	C1 = udpmsquot(m,C1,Q1);
	C1 = udpmsprod(m,C1,Y);
	Q1 = udpmsquot(m,Q1,G);
        C1 = udpmsprod(m,C1,Q1);
	P1 = udpmssum(m,P1,C1);
	Q1 = udpmsprod(m,Q1,Q1);
	Q1 = udpmsmonic(m,Q1);
	udpmsqrem(m,P1,Q1,&P1);
        
	*pQ = Q1;
	*pP = P1;
	return(G);        
}
