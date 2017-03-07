/*M
.SH NAME
qffmsrspidrd - quadratic function field over modular singles, real case, sparse representation, reduction of a primitive ideal

.SH SYNOPSIS
.nf
#include<_arith3.h>

single qffmsrspidrd(m, D, d, Q, P, pQr, pPr)
single m; 
pol D, d, Q, P, *pQr,*pPr;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS. Let k := Z/mZ.
.TP 4
.B D
is a monic, squarefree polynomial in k[X] of even degree
so
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d
is a polynomial in k[X] such that
d is the principal part of D^(1/2). 
.TP 4
.B Q, P
.RS
are polynomials in k[X] such that
Q | ( D - P^2 ) and
.RS
 I := [ Q, P + Y ] = Q k[X] + (P + Y) k[X]
.RE
is a non-reduced, primitive ideal, i.e.
.RS
deg(Q) >= deg(D)/2.
.RE
.RE
.PP
Let a = ( P + D^(1/2) ) / Q. qffmsrspidrd computes polynomials Qr and Pr, such that
.IP
I(l+1) = [ Ql, Pl + D^(1/2) ],
.PP
is the first reduced ideal in the expansion of a into a continued fraction, equivalent to I. qffmsrspidrd writes Ql to pQr, Pl to pPr and returns the
reduction degree
.IP
deg(a_1) + deg(a_2) +...+ deg(a_l) + deg(Ql) - deg(Q0).

M*/  
           
/*H
        Version 1       10.05.1991	A.Stein
	Version 2	09.07.1992	Hauptteil d jetzt als 
					Uebergabe-Parameter. AS
	Version 3	11.11.1994	AS
   DATE qffmsrspidrd  : 910715.9203__.921130.941201
H*/

#include <_arith3.h>

single qffmsrspidrd(m,D,d,Q,P,pQr,pPr)
single m;
pol d,D,Q,P;
pol *pQr,*pPr;
{        
	single rd;
	pol ai, Qim1, Qip1, Pip1, rim1, ri;
	bind(D,d,Q,P);
	init(ai,Qim1,Qip1,Pip1,rim1,ri);

	/* Initialisierungen */ 
	rd = lfirst(Q); 
	ai = pmssum(1,m,P,d); 
	rim1 = pmsrem(1,m,ai,Q);
	Qim1 = Q;
	P = pmsdif(1,m,d,rim1); 	 
	Q = pmsprod(1,m,P,P);
	Q = pmsdif(1,m,D,Q);
	Q = pmsquot(1,m,Q,Qim1); 
	ai = pmssum(1,m,P,d);
	ai = pmsqrem(1,m,ai,Q,&ri);
	rd = (ai) ? ( lfirst(ai) - rd) : (-rd) ;         
	
	/* Reduktion */
	while ( lfirst(Q) >= lfirst(d) ) {
		Pip1 = pmsdif(1,m,d,ri);
		Qip1 = pmsdif(1,m,ri,rim1);
		Qip1 = pmsprod(1,m,ai,Qip1);
		Qip1 = pmssum(1,m,Qim1,Qip1);
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
                ai = pmssum(1,m,P,d);
		ai = pmsqrem(1,m,ai,Q,&ri); 
                rd = rd + lfirst(ai);
	} 

	rd = rd + lfirst(Q);
	*pQr = Q;
	*pPr = P;
	return(rd);        
}
