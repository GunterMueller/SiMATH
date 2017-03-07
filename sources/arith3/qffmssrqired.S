/*M
.SH NAME
qffmssrqired - quadratic function field over modular singles, sparse representation, reduction of a real quadratic irrational

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmssrqired(m, D, Q, P, pPr)  
single m; 
pol D, Q, P, *pPr;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.. Let k := Z/mZ.
.TP 4
.B D
is a monic polynomial in k[X] of even degree
such that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is the principal part of D^(1/2). (See upmisrpp)
.TP 4
.B Q, P
are polynomials in k[X], such that
a = ( P + Y ) / Q is a non-reduced, real quadratic irrational,
i.e. Q | ( D - P^2 ) and deg(P - Y) >= deg(Q) or deg(P + Y) <= deg(Q).
.PP
By using the continued fraction algorithm starting at a_1 = a,
qffmssrqired computes the reduced, real quadratic irrational
a_l = ( Pl + Y) / Ql,
such that l > 0 is minimal with the property that deg(Ql) < deg(D)/2.
.PP  
qffmssrpired returns Ql and writes Pl to *pPr.

M*/
               
/*H
        Version 1       08.05.1991	A.Stein
   DATE qffmssrqired  : 910715.9203__.9211__
H*/

#include <_arith3.h>

pol qffmssrqired(m,D,Q,P,pPr)
single m;
pol D,Q,P;
pol *pPr;
{        
	pol ai, d, Qim1, Qip1, Pip1, rim1, ri;
	bind(D,Q,P);
	init(ai,d,Qim1,Qip1,Pip1,rim1,ri);
	 
	/* Hauptteil */
	d = upmssrpp(m,D);
	/* Initialisierungen */
	ai = pmssum(1,m,P,d); 
	ri = pmsrem(1,m,ai,Q);
	Pip1 = pmsdif(1,m,d,ri);; 	 
	Qip1 = pmsprod(1,m,Pip1,Pip1);
	Qip1 = pmsdif(1,m,D,Qip1);
	Qip1 = pmsquot(1,m,Qip1,Q); 
		
	/* Reduktion */
	while ( lfirst(Q) >= lfirst(d) ) {
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
		ai = pmssum(1,m,P,d);
		ai = pmsqrem(1,m,ai,Q,&ri);
                Pip1 = pmsdif(1,m,d,ri);
		Qip1 = pmsdif(1,m,ri,rim1);
		Qip1 = pmsprod(1,m,ai,Qip1);
		Qip1 = pmssum(1,m,Qim1,Qip1); 
		} 

	*pPr = Pip1;
	return(Qip1);        
}
