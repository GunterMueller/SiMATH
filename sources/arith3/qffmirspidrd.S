/*M
.SH NAME
qffmirspidrd - 
quadratic function field over modular integers, real case, 
sparse representation, reduction of a primitive ideal

.SH SYNOPSIS
.nf
#include <_arith3.h>

single qffmirspidrd(M, D, d, Q, P, pQ, pP)
int M;
pol D, d, Q, P;
pol *pQ, *pP;

f = qffmirspidrd(M, D, d, Q, P, pQ, pP)

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
.B d
is a polynomial in k[X] in sparse representation such that
d is the principal part of D^(1/2). (See upmisrpp)
.TP 4
.B Q, P
.RS
are polynomials in k[X] in sparse representation, such that
Q | ( D - P^2 ) and
.RS
 A := [ Q, P + Y ] = Q k[X] + (P + Y) k[X]
.RE
is a non-reduced, primitive ideal, i.e. 
.RS
deg(Q) >= deg(D)/2.
.RE
.RE
.TP 4
.B *pQ, *pP 
.RS
are polynomials in k[X] in sparse representation such that 
[ *pQ, *pP + Y ] is a reduced ideal. 
By using baby steps starting at A_1 = A,
the algorithm computes the reduced ideal
.RS
 A_{l+1} =  [ Q_l, P_l + Y ],
.RE
such that l is minimal with the property that deg(Q_l) < deg(D)/2.
Then, *pQ := Q_l and *pP := P_l .
.RE
.TP 4
.B f
= deg(*pQ) - deg(Q) + deg(a_1) + deg(a_2)+...+deg(a_l).

.SH LITERATURE
A. Stein, 
"Baby step-Giant step-Verfahren in 
reell-quadratischen Kongruenzfunktionenk"orpern
mit Charakteristik ungleich 2",
Diplomarbeit, Universit"at des Saarlandes, Saarbr"ucken (1992).

.SH SEE ALSO
.BR qffmirpidred()
.BR qffmsrspidrd()
M*/

/*H
        Version 1       13.06.1994	A. Stein	
	DATE qffmirspidrd: 210297
H*/

#include <_arith3.h>

single qffmirspidrd(M,D,d,Q,P,pQ,pP)
int M;
pol d,D,Q,P;
pol *pQ,*pP;
{        
	single rd;
	pol ai, Qim1, Qip1, Pip1, rim1, ri;
	bind(M,D,d,Q,P);
	init(ai,Qim1,Qip1,Pip1,rim1,ri);

	/* initialisations */ 
	rd = lfirst(Q); 
	ai = pmisum(1,M,P,d); 
	rim1 = pmirem(1,M,ai,Q);
	Qim1 = Q;
	P = pmidif(1,M,d,rim1); 	 
	Q = pmiprod(1,M,P,P);
	Q = pmidif(1,M,D,Q);
	Q = pmiquot(1,M,Q,Qim1); 
	ai = pmisum(1,M,P,d);
	ai = pmiqrem(1,M,ai,Q,&ri);

	rd = (ai) ? ( lfirst(ai) - rd) : (-rd) ;         
	
	/* reduction */
	while ( lfirst(Q) >= lfirst(d) ) {
		Pip1 = pmidif(1,M,d,ri);
		Qip1 = pmidif(1,M,ri,rim1);
		Qip1 = pmiprod(1,M,ai,Qip1);
		Qip1 = pmisum(1,M,Qim1,Qip1);
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
                ai = pmisum(1,M,P,d);
		ai = pmiqrem(1,M,ai,Q,&ri); 
                rd = rd + lfirst(ai);
	} 

	rd = rd + lfirst(Q);
	*pQ = Q;
	*pP = P;
	return(rd);        
}
