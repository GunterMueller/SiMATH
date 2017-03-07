/*M
.SH NAME
qffmsreg - quadratic function field over modular singles regulator

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsreg(m, P)  
single m; 
pol P;
  
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B P
is a monic and squarefree polynomial in Z/mZ[X] of even degree.
.PP
qffmsreg returns the regulator of Z/mZ[X,P^(1/2)].

.SH NOTE
This version is the very origin. There exist more efficient versions, namely qffmsregbg, qffmsregbs, qffmsregobg and qffmsregobs. 

.SH SEE ALSO
.nf
qffmsregbg
qffmsregbs
qffmsregobg
qffmsregobs

M*/
         
/*H
	Version 1       18.08.1988      B. Weis
	Version 2	17.03.1992	Alter Name QFFREG.  AS
   DATE qffmsreg      : 890501.8909__.920331
H*/


#include <_arith3.h>

int qffmsreg(m,P)
single m;
pol P;
{
	int A;
	pol ai, ht, qim1, qi, qip1, mi, mip1;
	bind(P);
	init(A,qim1,qi,qip1,ai,mi,mip1,ht);
	ht = upmssrpp(m,P);
	P = ptodp(1,P);
	ht = ptodp(1,ht);
	mi = ht;
	qim1 = list2(0,1);
	qi = udpmsprod(m,ht,ht);
	qi = udpmsdif(m,P,qi);
	ai = ht;
	A = 0;
	do {
		A = isum(A,lfirst(ai));
		ai = udpmssum(m,mi,ht);
		ai = udpmsqrem(m,ai,qi,&P);
		mip1 = udpmsprod(m,ai,qi);
		mip1 = udpmsdif(m,mip1,mi);
		qip1 = udpmsdif(m,mi,mip1);
		qip1 = udpmsprod(m,ai,qip1);
		qip1 = udpmssum(m,qim1,qip1);
		mi = mip1; mip1 = _0;
		qim1 = qi; qi = qip1; qip1 = _0;
		}
	while (lfirst(qim1) != 0);
	return(A);
}
