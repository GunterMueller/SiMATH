/*M
.SH NAME
qffmirqired - 
quadratic function field over modular integers, real case, 
reduction of a real quadratic irrational

.SH SYNOPSIS
.nf
#include <_arith3.h>

pol qffmirqired(M, D, d, Q, P, pP)
int M;
pol D, d, Q, P;
pol *pP;

Ql = qffmirqired(M, D, d, Q, P, pP)

.SH DESCRIPTION
.TP 4
.B M
is a prime integer, M > 2. Let k := Z/MZ.
.TP 4
.B D 
is a monic, squarefree polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in k[X] in dense representation such that
d is the principal part of D^(1/2). (See upmisrpp)
.TP 4
.B Q, P
.RS
are polynomials in k[X] in dense representation, such that
a = ( P + Y ) / Q is a non-reduced, real quadratic irrational, 
i.e. Q | ( D - P^2 ) and deg(P - Y) >= deg(Q) or deg(P + Y) <= deg(Q).
.RE
.TP 4
.B Ql, *pP 
are polynomials in k[X] in dense representation such that 
(*pP + Y) / Ql
is a reduced, real quadratic irrational. 
By using the continued fraction algorithm starting at a_1 = a,
the algorithm computes the reduced, real quadratic irrational
a_l = ( Pl + Y) / Ql,
such that l > 0 is minimal with the property that deg(Ql) < deg(D)/2.
Then, *pP = Pl .

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).

.SH SEE ALSO
.BR qffmisrqired(),
.BR qffmsrqired()
M*/

/*H
        Version 1       13.06.1994	A.Stein	
	DATE qffmirqired: 210297
H*/

#include <_arith3.h>

pol qffmirqired(M,D,d,Q,P,pP)
int M;
pol D, d, Q, P;
pol *pP;
{        
	pol ai,  Qim1, Qip1, Pip1, rim1, ri;
	bind(M,D,d,Q,P);
	init(ai,Qim1,Qip1,Pip1,rim1,ri);
	
	/* initialisations */
	ai = udpmisum(M,P,d); 
	udpmiqrem(M,ai,Q,&ri);
	Pip1 = udpmidif(M,d,ri);; 	 
	Qip1 = udpmiprod(M,Pip1,Pip1);
	Qip1 = udpmidif(M,D,Qip1);
	Qip1 = udpmiquot(M,Qip1,Q); 
		
	/* reduction */
	while ( lfirst(Q) >= lfirst(d) ) {
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
 		ai = udpmisum(M,P,d);
		ai = udpmiqrem(M,ai,Q,&ri);
                Pip1 = udpmidif(M,d,ri);
		Qip1 = udpmidif(M,ri,rim1);
		Qip1 = udpmiprod(M,ai,Qip1);
		Qip1 = udpmisum(M,Qim1,Qip1); 
		} 

	*pP = Pip1;
	return(Qip1);        
}
