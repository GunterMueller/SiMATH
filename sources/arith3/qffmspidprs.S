/*M
.SH NAME
qffmspidprs - quadratic function field over modular singles primitive ideal product, special version

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmspidprs(m, D, C1, Q1, P1, Q2, P2, pQ, pP)  
single m; 
pol D, C1, Q1, P1, Q2, P2, *pQ, *pP;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a squarefree polynomial in Z/mZ[X] in dense representation, i.e. Z/mZ(X,D^(1/2)) is a quadratic function field.
.TP 4
.B C1, Q1, P1, Q2 and P2
are polynomials in Z/mZ[X] in dense representation, such that
    I1 := [ Q1, P1 + D^(1/2) ] and
    I2 := [ Q2, P2 + D^(1/2) ]
.IP
are primitive ideals given in adapted form, i.e.
    Q1 divides (D - P1^2), 
    Q2 divides (D - P2^2),
    deg(P1) < deg(Q1),
    deg(P2) < deg(Q2) and
    sign(Q1) = sign(Q2) = 1.
.IP
Thereby, 
    C1 = (D-P1^2)/Q1,
.IP
is an element in Z/mZ[X] and precomputed.
.PP
qffmspidpris computes three polynomials in Z/mZ[X] in dense representation, say G, Q and P, such that
.IP
I1 * I2 = (G) [ Q, P + D^(1/2) ] 
.PP
is an integral ideal.
.PP
[ Q, P + D^(1/2) ] is a primitive ideal, given in adapted form, such that
    Q divides D-P^2,
    Deg(P) < Deg(Q),
    sign(Q) = 1,
    sign(G) = 1 holds.
.PP
qffmspidprs returns G and writes Q and P to *pQ and *pP respectively.

.SH SEE ALSO
.nf
qffmspidpr                                            

M*/
                  
/*H
        Version 1       15.05.1991	A.Stein
   DATE qffmspidprs   : 910715.9109__.9203__.9211__
H*/


#include <_arith3.h>

pol qffmspidprs(m,D,C1,Q1,P1,Q2,P2,pQ,pP)
single m;
pol D,C1,Q1,P1,Q2,P2;
pol *pQ,*pP;
{        
	single cG;
	pol G,G1,X1;
	bind(D,C1,Q1,P1,Q2,P2);
	init(G,G1,X1);

    /* Berechne G1,X1, sodass : G1 = ggt(Q1,Q2) = X1 * Q1 + X2 * Q2 */	
                                                   
	G1 = udpmshegcd(m,Q2,Q1,&X1);

    /*  Hat G1 den Grad 0, d.h. G1 = cG ist Element von Z/mZ, so kann man
	X2 = 1, Y2 = 0 setzen, und rechnet:
	Q = Q1 * Q2 , P = P1 + (Q1/cG) * X1 * (P2 - P1) , G = 1)         */ 	

	if( !lfirst(G1) ) {
		cG = msinv(m,lsecond(G1));
		P2 = udpmsdif(m,P2,P1);
		P2 = udpmsprod(m,P2,X1);
		P2 = udpmsprod(m,P2,Q1);
		P2 = udpmsmsprod(m,P2,cG);
		P1 = udpmssum(m,P1,P2);
		Q1 = udpmsprod(m,Q1,Q2);
		udpmsqrem(m,P1,Q1,&P1);
		G = list2(0,1);
	}
        else {
		pol X2, Y2;
		init(X2,Y2);

    /* Hat G1 Grad > 0 so berechnet man G , X2, Y2 , sodass
		G = ggt(G1,P1+P2) = X2 * G1 + Y2 * (P1 + P2)
        Setze damit
	P = P1 + (Q1/G) [ X2 * X1 * (P2 -P1) + Y2 * C1 ]
	Q = ( Q1 / G ) * ( Q2 / G ) und normiere Q. Dann ist
	P = P mod Q ;						        */

		X2 = udpmssum(m,P1,P2);
		G = udpmsegcd(m,G1,X2,&X2,&Y2);
		
		P2 = udpmsdif(m,P2,P1);
		X2 = udpmsprod(m,X2,P2);
		X2 = udpmsprod(m,X2,X1);
		X1 = udpmsprod(m,C1,Y2);
		Q1 = udpmsquot(m,Q1,G);
		Q2 = udpmsquot(m,Q2,G);
                X2 = udpmssum(m,X2,X1);
		X2 = udpmsprod(m,X2,Q1);
		P1 = udpmssum(m,P1,X2);
		Q1 = udpmsprod(m,Q1,Q2);
		Q1 = udpmsmonic(m,Q1);
		udpmsqrem(m,P1,Q1,&P1);
        }

	*pQ = Q1;
	*pP = P1;
	return(G);        
}
