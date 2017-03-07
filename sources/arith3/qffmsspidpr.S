/*M
.SH NAME
qffmsspidpr - quadratic function field over modular singles, sparse
representation, primitive ideal product

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmsspidpr(m, D, Q1, P1, Q2, P2, pQ, pP)  
single m; 
pol D, Q1, P1, Q2, P2, *pQ, *pP;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS. Let k := Z/mZ. 
.TP 4
.B D
is a squarefree polynomial in k[X]
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a quadratic congruence function field.
.TP 4
.B Q1, P1, Q2, P2
.RS
are polynomials in k[X] in sparse representation, such that
Q1 | ( D - P1^2 ),  Q2 | ( D - P2^2 ) and
.RS
 A1 := [ Q1, P1 + Y ],
 A2 := [ Q2, P2 + Y ]
.RE
are primitive ideals.
.RE
.PP
qffmsspidpr computes polynomials G, Q, P in k[X] such that 
.RS
 A_1 A_2 = (G) [ Q, P + Y ],
.RE
where [ Q, P + Y ] is a primitive ideal in adapted form, i.e.
.RS
 Q | ( D - (P)^2 ), sgn(Q) = 1,
 deg(P) < deg(Q).
.RE
Also, sgn(G) = 1.
.RE  
.PP
qffmsspidpr writes Q and P to *pQ and *pP respectively and returns G.
        
.SH SEE ALSO
.nf
qffmsspidsqu
qffmsspidsqs
qffmsspidprs

M*/
              
/*H
        Version 1       06.07.1992	A.Stein
   DATE qffmsspidpr   : 921130
H*/


#include <_arith3.h>

pol qffmsspidpr(m,D,Q1,P1,Q2,P2,pQ,pP)
single m;
pol D, Q1, P1, Q2, P2;
pol *pQ,*pP;
{        
	single cG;
	pol G, G1, X1;
	bind(D,Q1,P1,Q2,P2);
	init(G,G1,X1);

    /* Bestimme die adaptierten Basen von I1 und I2 */
	Q1 = pmsmonic(1,m,Q1);
        if( lfirst(P1) >= lfirst(Q1) ) P1 = upmsrem(m,P1,Q1);
	Q2 = pmsmonic(1,m,Q2);
        if( lfirst(P2) >= lfirst(Q2) ) P1 = upmsrem(m,P1,Q1);

    /* Berechne G1,X1, sodass : G1 = ggt(Q1,Q2) = X1 * Q1 + X2 * Q2 */	                                                  		
	G1 = upmshegcd(m,Q2,Q1,&X1);

    /*  Hat G1 den Grad 0, d.h. G1 = cG ist Element von Z/mZ, so kann man
	X2 = 1, Y2 = 0 setzen, und rechnet:
	Q = Q1 * Q2 , P = P1 + (Q1/cG) * X1 * (P2 - P1) , G = 1)         */ 	

	if( !lfirst(G1) ) {
		cG = msinv(m,lsecond(G1));
		P2 = pmsdif(1,m,P2,P1);
		P2 = pmsprod(1,m,P2,X1);
		P2 = pmsprod(1,m,P2,Q1);
		P2 = pmsmsprod(1,m,P2,cG);
		P1 = pmssum(1,m,P1,P2);
		Q1 = pmsprod(1,m,Q1,Q2);
		P1 = upmsrem(m,P1,Q1);
		G = list2(0,1);
	}
        else {
		pol X2, Y2;
		init(X2,Y2);
   /* Hat G1 Grad > 0 so berechnet man G , X2, Y2 , sodass
		G = ggt(G1,P1+P2) = X2 * G1 + Y2 * (P1 + P2)
        Setze damit
	P = P1 + (Q1/G) [ X2 * X1 * (P2 -P1) + Y2 * (D - P1^2) / Q1 ]
	Q = ( Q1 / G ) * ( Q2 / G ) und normiere Q. Dann ist
	P = P mod Q ;						        */

		X2 = pmssum(1,m,P1,P2);
		G = upmsegcd(m,G1,X2,&X2,&Y2);		
		P2 = pmsdif(1,m,P2,P1);
		X2 = pmsprod(1,m,X2,P2);
		X2 = pmsprod(1,m,X2,X1);
		X1 = pmsprod(1,m,P1,P1);
		X1 = pmsdif(1,m,D,X1);
		X1 = pmsquot(1,m,X1,Q1);
		X1 = pmsprod(1,m,X1,Y2);
		Q1 = pmsquot(1,m,Q1,G);
		Q2 = pmsquot(1,m,Q2,G);
                X2 = pmssum(1,m,X2,X1);
		X2 = pmsprod(1,m,X2,Q1);
		P1 = pmssum(1,m,P1,X2);
		Q1 = pmsprod(1,m,Q1,Q2);
		Q1 = pmsmonic(1,m,Q1);
		P1 = upmsrem(m,P1,Q1);
        }
	*pQ = Q1;
	*pP = P1;
	return(G);        
}
