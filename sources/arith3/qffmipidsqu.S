/*M
.SH NAME
qffmipidsqu - 
quadratic function field over modular integers 
primitive ideal square

.SH SYNOPSIS
.nf
#include <_arith3.h>

pol qffmipidsqu(M, D, Q1, P1, pQ, pP)
int M;
pol D, Q1, P1;
pol *pQ, *pP;

G = qffmipidsqu(M, D, Q1, P1, pQ, pP)

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B D 
is a squarefree polynomial in k[X]
in dense representation. This means that
k(X,Y), where Y^2 = D, is a quadratic congruence function field.
.TP 4
.B Q1, P1
.RS
are polynomials in k[X] in dense representation, such that
Q1 | ( D - P1^2 ) and
.RS
 A1 := [ Q1, P1 + Y ] = Q1 k[X] + (P1 + Y) k[X]  ,
.RE
is a primitive ideal.
.RE
.TP 4
.B G, *pQ, *pP 
.RS
are polynomials in k[X] in dense representation such that 
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

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).

.SH SEE ALSO
.BR qffmipidpr(),
.BR qffmipidsqus(),
.BR qffmispidsqu(),
.BR qffmspidsqu()
M*/

/*H
        Version 1       14.06.1994	A.Stein
	DATE qffmipidsqu: 210297
H*/

#include <_arith3.h>

pol qffmipidsqu(M,D,Q1,P1,pQ,pP)
int M;
pol D,Q1,P1;
pol *pQ,*pP;
{        
	pol C1,G,Y;
	bind(M,D,Q1,P1);
	init(G,C1,Y);

    /* compute the adapted k[X]-base of A_1 */
	Q1 = udpmimonic(M,Q1);
        if( lfirst(P1) >= lfirst(Q1) ) udpmiqrem(M,P1,Q1,&P1); 

    /* compute G,Y such that G = ggt(Q1,2*P1) = X * Q1 + Y * 2 * P1 */	
         
	Y = udpmisum(M,P1,P1);                                          
	G = udpmihegcd(M,Q1,Y,&Y);

    /*  let
	P = P1 + (Q1/G) * Y * (D - P1^2) / Q1 
	Q = ( Q1 / G ) ^ 2  and normalize Q, and
	P = P mod Q				    */

	C1 = udpmiprod(M,P1,P1);
	C1 = udpmidif(M,D,C1);
	C1 = udpmiquot(M,C1,Q1);
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
