/*M
.SH NAME
qffmspidsqus - quadratic function field over modular singles primitive ideal square, special version

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmspidsqus(m, D, C1, Q1, P1, pQ, pP)
single m; 
pol D, C1, Q1, P1, *pQ, *pP;
      
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X] in dense representation, i.e. Z/mZ(X,D^(1/2)) is a quadratic function field.
.TP 4
.B C1, Q1, P1
are polynomials in Z/mZ[X] in dense representation, such that
    I1 := [ Q1, P1 + D^(1/2) ] 
is a primitive ideal given in adapted form, i.e.
    Q1 divides (D - P1^2), 
    deg(P1) < deg(Q1) and 
    sign(Q1) = sign(Q2) = 1.
.IP
Thereby,
    C1 = (D-P1^2)/Q1,
.IP
is an element in Z/mZ[X] and precomputed.   
.PP
qffmspidsqus computes three polynomials in Z/mZ[X] in dense representation, say G, Q and P, such that
.IP
I1 * I1 = (G) [ Q, P + D^(1/2) ]
.PP
is an integral ideal.
.PP
[ Q, P + D^(1/2) ] is a primitive ideal, given in adapted form, such that
    Q divides D-P^2,
    Deg(P) < Deg(Q),
    sign(Q) = 1,
    sign(G) = 1 holds.
.PP
qffmspidsqus returns G and writes Q and P to *pQ and *pP respectively.       

.SH SEE ALSO
qffmspidsqu

M*/
              
/*H
        Version 1       15.05.1991	A.Stein
	Version 2	25.11.1994	BIND-Fehler korrigiert.AS
   DATE qffmspidsqus  : 910715.9109__.9203__.9211__.941201
H*/

#include <_arith3.h>

pol qffmspidsqus(m,D,C1,Q1,P1,pQ,pP)
single m;
pol D,C1,Q1,P1;
pol *pQ,*pP;
{        
	pol G,Y;
	bind(C1,D,Q1,P1);
	init(G,Y);

    /* Berechne G,Y mit : G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = udpmssum(m,P1,P1);                                          
	G = udpmshegcd(m,Q1,Y,&Y);

    /*  Setze damit
	P = P1 + (Q1/G) * Y * C1 
	Q = ( Q1 / G ) ^ 2  und normiere Q. Dann ist
	P = P mod Q				    */

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
