/*M
.SH NAME
qffmsfuobs - quadratic function field over modular singles fundamental unit, original baby step version

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsfuobs(m, D)  
single m; 
pol D;    
   
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic, square-free polynomial in Z/mZ[X] of even degree.
.PP
qffmsfuobs returns a list L = (E1, E2), where
.TP 4
E1, E2                     
are two polynomials in Z/mZ[X], such that            E1 + E2*D^(1/2) is a fundamental unit of the real quadratic function field Z/mZ(X,D^(1/2)).
.PP
qffmsfuobs uses the original baby-step algorithm.

.SH NOTES
A faster version of the baby-step algorithm is given by qffmsfubs.

.SH SEE ALSO
qffmsfubs

M*/
                                                      
/*H
	Version 1	03.05.1991	A.Stein
   DATE qffmsfuobs    : 910715.9203__
H*/


#include <_arith3.h>

list qffmsfuobs(m,D)
single m;
pol D;
{
	pol pi, pim1, pim2, qi, qim1, qim2, ai, d, Qim1, Qi, Pi, Qip1, Pip1, rim1, ri;
	bind(D);
	init(pi,pim1,pim2,qi,qim1,qim2,ai,Qim1,Qi,Pi,Qip1,Pip1,rim1,ri,d);
	
	/* Hauptteil */
        d = upmssrpp(m,D);

	/* Initialisierungen */
	D = ptodp(1,D);
	d = ptodp(1,d);
	rim1 = 0;
	ai = d;
	Pi = d;
 	Qim1 = list2(0,1);  
	Qi = udpmsprod(m,d,d);
	Qi = udpmsdif(m,D,Qi);	
	pim2 = Qim1; 	pim1 = d;
	qim2 = 0; 	qim1 = pim2;  	 
		
	while ( lfirst(Qi) != 0 ) {
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri);
                Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
                Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0; 
		pi = udpmsprod(m,ai,pim1);
		pi = udpmssum(m,pi,pim2); 
		pim2 = pim1; pim1 = pi; pi = _0;
                qi = udpmsprod(m,ai,qim1);
		qi = udpmssum(m,qi,qim2);
                qim2 = qim1; qim1 = qi; qi = _0;
                                             		
	}
	
	pim1 = dptop(1,pim1);
	qim1 = dptop(1,qim1);
	ai = list2(pim1,qim1);
	return(ai); 
}
