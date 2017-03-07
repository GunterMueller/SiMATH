/*M
.SH NAME
qffmsregobs - quadratic function field over modular singles regulator, original baby step version

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsregobs(m,D)  
single m; 
pol D;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B D
is a monic and squarefree polynomial in Z/mZ[X] of even degree.
.PP
qffmsregobs computes and returns the regulator of the quadratic function field Z/mZ(X,D^(1/2)), using the original baby step algorithm (continued fraction algorithm). Thereby, the whole quasi-period must be passed through.

.SH NOTE
qffmsregbs is a faster version of the baby step algorithm, using symetries.
More complex versions of the baby step - giant step algorithm are given by qffmsregobg and qffmsregbg.

.SH SEE ALSO
.nf
qffmsregbs
qffmsregobg
qffmsregbg

M*/
                
/*H
        Version 1       24.04.1991	A.Stein  
   DATE qffmsregobs   : 910715.9203__
H*/


#include <_arith3.h>

int qffmsregobs(m,D)
single m;
pol D;
{
	int R;
	pol ai, d, Qim1, Qi, Pi, Qip1, Pip1, rim1, ri;
	bind(D);
	init(R,ai,Qim1,Qi,Pi,Qip1,Pip1,rim1,ri,d);
	
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
	R = lfirst(d);
	
	while ( lfirst(Qi) != 0 ) {
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri);
                R = isum(R,lfirst(ai));
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1);
		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		rim1 = ri; ri = _0;
	}
		return(R);
}
