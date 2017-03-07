/*M
.SH NAME
qffmispidprs - 
quadratic function field over modular integers, sparse 
representation, primitive ideal product, special version

.SH SYNOPSIS
.nf
#include <_arith3.h>

pol qffmispidprs(M, D, C1, Q1, P1, Q2, P2, pQ, pP)
int M;
pol D, C1, Q1, P1, Q2, P2;
pol *pQ, *pP;

G = qffmipidpr(M, D, C1, Q1, P1, Q2, P2, pQ, pP)

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
.B C1 
= ( D - P1^2 ) / Q1 is in k[X] in sparse representation.
.TP 4
.B Q1, P1, Q2, P2
.RS
are polynomials in k[X] in sparse representation, such that
.RS
 A1 := [ Q1, P1 + Y ] = Q1 k[X] + (P1 + Y) k[X],
 A2 := [ Q2, P2 + Y ] = Q2 k[X] + (P2 + Y) k[X] 
.RE
are primitive ideals in adapted form, i.e.
.RS
 Q1 | ( D - P1^2 ), deg(P1) < deg(Q1), sgn(Q1) = 1,
 Q2 | ( D - P2^2 ), deg(P2) < deg(Q2), sgn(Q2) = 1.
.RE
.RE
.TP 4
.B G, *pQ, *pP 
.RS
are polynomials in k[X] in sparse representation such that 
.RS
 A_1 A_2 = (G) [ *pQ, *pP + Y ],
.RE
where [ *pQ, *pP + Y ] is a primitive ideal in adapted form, i.e.
.RS
 *pQ | ( D - (*pP)^2 ), sgn(*pQ) = 1,
 deg(*pP) < deg(*pQ). 
.RE
Also, sgn(G) = 1.
.RE

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).

.SH SEE ALSO
.BR qffmispidpr(),
.BR qffmipidprs(),
.BR qffmispidsqs(),
.BR qffmsspidprs()
M*/

/*H
        Version 1       13.06.1994	A.Stein
	DATE qffmispidprs: 210297
H*/

#include <_arith3.h>

pol qffmispidprs(M,D,C1,Q1,P1,Q2,P2,pQ,pP)
int M;
pol D, C1, Q1, P1, Q2, P2;
pol *pQ, *pP;
{        
	int cG;
	pol G, G1, X1;
	bind(M,D,C1,Q1,P1,Q2,P2);
	init(G,G1,X1);

    /* compute G1,X1, such that : G1 = ggt(Q1,Q2) = X1 * Q1 + X2 * Q2 */
                                                   
	G1 = upmihegcd(M,Q2,Q1,&X1);


    /*  if deg(G1) = 0, i.e. G1 = cG is in k, then X2 = 1, Y2 = 0 and:	
	Q = Q1 Q2 , P = P1 + (Q1/cG) X1 (P2 - P1) , G = 1        */ 	

	if( !lfirst(G1) ) {
		P2 = pmidif(1,M,P2,P1);
		P2 = pmiprod(1,M,P2,X1);
		P2 = pmiprod(1,M,P2,Q1);
		cG = miinv(M,lsecond(G1));
		P2 = pmimiprod(1,M,P2,cG);
		P1 = pmisum(1,M,P1,P2);
		Q1 = pmiprod(1,M,Q1,Q2);
		P1 = upmirem(M,P1,Q1);
		G = list2(0,1);
	}
        else {
		pol X2, Y2;
		init(X2,Y2);

    /* if deg(G1) > 0, then compute G , X2, Y2 such that
		G = ggt(G1,P1+P2) = X2 * G1 + Y2 * (P1 + P2)
        Then, 
	P = P1 + (Q1/G) [ X2 * X1 * (P2 -P1) + Y2 * C1 ]
	Q = ( Q1 / G ) * ( Q2 / G ) and normalize Q. Finally
	P = P mod Q ;						        */

		X2 = pmisum(1,M,P1,P2);
		G = upmiegcd(M,G1,X2,&X2,&Y2);
		
		P2 = pmidif(1,M,P2,P1);
		X2 = pmiprod(1,M,X2,P2);
		X2 = pmiprod(1,M,X2,X1);
		X1 = pmiprod(1,M,C1,Y2);
		Q1 = pmiquot(1,M,Q1,G);
		Q2 = pmiquot(1,M,Q2,G);
                X2 = pmisum(1,M,X2,X1);
		X2 = pmiprod(1,M,X2,Q1);
		P1 = pmisum(1,M,P1,X2);
		Q1 = pmiprod(1,M,Q1,Q2);
		Q1 = pmimonic(1,M,Q1);
		P1 = upmirem(M,P1,Q1);
        }

	*pQ = Q1;
	*pP = P1;
	return(G);        
}
