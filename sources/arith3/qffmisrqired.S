/*M
.SH NAME
qffmisrqired - 
quadratic function field over modular integers, , sparse
representation, reduction of a real quadratic irrational

.SH SYNOPSIS
.nf
#include <_arith3.h>

pol qffmisrqired(M, D, Q, P, pP)
int M;
pol D, Q, P;
pol *pP;

Ql = qffmisrqired(M, D, Q, P, pP)

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in sparse representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B Q, P
are polynomials in k[X] in sparse representation, such that
a = ( P + Y ) / Q is a non-reduced, real quadratic irrational, 
i.e. Q | ( D - P^2 ) and deg(P - Y) >= deg(Q) or deg(P + Y) <= deg(Q).
.TP 4
.B Ql, *pP 
are polynomials in k[X] in sparse representation such that 
 (*pP + Y) / Ql is a reduced, real quadratic irrational. 
By using the continued fraction algorithm starting at a_1 = a,
the algorithm computes the reduced, real quadratic irrational
a_l = ( Pl + Y) / Ql
such that l > 0 is minimal with the property that deg(Q_l) < deg(D)/2.
Then, *pP = Pl.

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).

.SH SEE ALSO
.BR qffmirqired(),
.BR qffmsrqired(),
.BR qffmssrqired()
M*/

/*H
        Version 1       13.06.1994	A.Stein
	DATE qffmisrqired: 210297
H*/

#include <_arith3.h>

pol qffmisrqired(M,D,Q,P,pPr)
int M;
pol D,Q,P;
pol *pPr;
{        
	pol ai, d, Qim1, Qip1, Pip1, rim1, ri;
	bind(M,D,Q,P);
	init(ai,d,Qim1,Qip1,Pip1,rim1,ri);
	 
	/* pprincipal part */
	d = upmisrpp(M,D);
	/* initialisations */
	ai = pmisum(1,M,P,d); 
	ri = pmirem(1,M,ai,Q);
	Pip1 = pmidif(1,M,d,ri);; 	 
	Qip1 = pmiprod(1,M,Pip1,Pip1);
	Qip1 = pmidif(1,M,D,Qip1);
	Qip1 = pmiquot(1,M,Qip1,Q); 
		
	/* reduction */
	while ( lfirst(Q) >= lfirst(d) ) {
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
		ai = pmisum(1,M,P,d);
		ai = pmiqrem(1,M,ai,Q,&ri);
                Pip1 = pmidif(1,M,d,ri);
		Qip1 = pmidif(1,M,ri,rim1);
		Qip1 = pmiprod(1,M,ai,Qip1);
		Qip1 = pmisum(1,M,Qim1,Qip1); 
		} 

	*pPr = Pip1;
	return(Qip1);        
}
