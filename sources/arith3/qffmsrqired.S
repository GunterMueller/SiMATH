/*M
.SH NAME
qffmsrqired - quadratic function field over modular singles reduction of a real quadratic irrational

.SH SYNOPSIS
.nf
#include<_arith3.h>

pol qffmsrqired(m, D, d, Q, P, pPr)  
single m; 
pol D, d, Q, P; 
pol *pPr;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.. Let k := Z/mZ.     
.TP 4
.B D
is a monic polynomial in k[X] of even degree
in dense representation. This means that
k(X,Y), where Y^2 = D, is a real quadratic congruence function field.
.TP 4
.B d                                                          
is the principal part of D^(1/2). (See upmisrpp) 
.TP 4
.B Q, P
are polynomials in k[X] in dense representation, such that
a = ( P + Y ) / Q is a non-reduced, real quadratic irrational,
i.e. Q | ( D - P^2 ) and deg(P - Y) >= deg(Q) or deg(P + Y) <= deg(Q).     
.PP
By using the continued fraction algorithm starting at a_1 = a,
qffmsrqired computes the reduced, real quadratic irrational
a_l = ( Pl + Y) / Ql,
such that l > 0 is minimal with the property that deg(Ql) < deg(D)/2.
.PP
qffmsrqired returns Ql and writes Pl to *pPr.
  
M*/
           
/*H
        Version 1       08.05.1991	A.Stein
   DATE qffmsrqired   : 910715.9203__.9211__
H*/


#include <_arith3.h>

pol qffmsrqired(m,D,d,Q,P,pPr)
single m;
pol D,d,Q,P;
pol *pPr;
{        
	pol ai,  Qim1, Qip1, Pip1, rim1, ri;
	bind(D,d,Q,P);
	init(ai,Qim1,Qip1,Pip1,rim1,ri);
	
	/* Initialisierungen */
	ai = udpmssum(m,P,d); 
	udpmsqrem(m,ai,Q,&ri);
	Pip1 = udpmsdif(m,d,ri);; 	 
	Qip1 = udpmsprod(m,Pip1,Pip1);
	Qip1 = udpmsdif(m,D,Qip1);
	Qip1 = udpmsquot(m,Qip1,Q); 
		
	/* Reduktion */
	while ( lfirst(Q) >= lfirst(d) ) {
		P = Pip1; Pip1 = _0;
		Qim1 = Q; Q = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
		ai = udpmssum(m,P,d);
		ai = udpmsqrem(m,ai,Q,&ri);
                Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1); 
		} 

	*pPr = Pip1;
	return(Qip1);        
}
