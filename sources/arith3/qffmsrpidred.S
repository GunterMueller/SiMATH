/*M
.SH NAME
qffmsrpidred - quadratic function field over modular singles, real case, reduction of a primitive ideal

.SH SYNOPSIS
.nf
#include<_arith3.h>

single qffmsrpidred(m, D, d, Q, P, pQr, pPr)  

single m; 
pol D, d, Q, P, *pQr,*pPr;      

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS. Let k := Z/mZ.
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
Let a = ( P + D^(1/2) ) / Q. qffmsrpidred computes polynomials Qr and Pr, such that 
.IP
I(l+1) = [ Ql, Pl + D^(1/2) ],
.PP
is the first reduced ideal in the expansion of a into a continued fraction, equivalent to I. qffmsrpidred writes Ql to pQr, Pl to pPr and returns the reduction degree
.IP
deg(a_1) + deg(a_2) +...+ deg(a_l) + deg(Ql) - deg(Q0).
      
M*/
                  
/*H
        Version 1       10.05.1991	A.Stein
   DATE qffmsrpidred  : 910715.9203__.9211__
H*/


#include <_arith3.h>

single qffmsrpidred(m,D,d,Q,P,pQr,pPr)
single m;
pol D,d,Q,P;
pol *pQr,*pPr;
{        
	single rd;
	pol ai, Qim1, Qip1, Pip1, rim1, ri;
	bind(D,d,Q,P);
	init(ai,Qim1,Qip1,Pip1,rim1,ri);
	
	/* Initialisierungen */
	rd = lfirst(Q);
	Qim1 = Q;
	ai = udpmssum(m,P,d); 
	udpmsqrem(m,ai,Qim1,&rim1);
	P = udpmsdif(m,d,rim1);; 	 
	Q = udpmsprod(m,P,P);
	Q = udpmsdif(m,D,Q);
	Q = udpmsquot(m,Q,Qim1); 
	ai = udpmssum(m,P,d);
	ai = udpmsqrem(m,ai,Q,&ri);
	rd = (ai) ? ( lfirst(ai) - rd) : (-rd) ;         
	
	/* Reduktion */
	while ( lfirst(Q) >= lfirst(d) ) {
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
                ai = udpmssum(m,P,d);
		ai = udpmsqrem(m,ai,Q,&ri); 
		rd = rd + lfirst(ai);
                } 

	rd = rd + lfirst(Q);
	*pQr = Q;
	*pPr = P;
	return(rd);        
}
