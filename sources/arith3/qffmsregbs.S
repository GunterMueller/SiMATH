/*M
.SH NAME
qffmsregbs - quadratic function field over modular singles regulator, baby step version

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsregbs(m, D)  
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
qffmsregbs computes and returns the regulator of the quadratic function field Z/mZ(X,D^(1/2)), with help of the baby step algorithm (continued fraction algorithm), using symetries.
Thereby, the algorithm must pass throug the half quasi period.

.SH NOTE
A slower version is given by qffmsregobs. Two faster versions are given by qffmsregobg and qffmsregbg.
 
.SH SEE ALSO
.nf
qffmsregobs
qffmsregobg
qffmsregbg

M*/
               
/*H
        Version 1       03.05.1991	A.Stein
   DATE qffmsregbs    : 910715.9203__
H*/


#include <_arith3.h>

int qffmsregbs(m,D)
single m;
pol D;
{        
	int A,R;
	pol ai, d, Qim1, Qi, QQi, Pi, Qip1, QQip1, Pip1, rim1, ri;
	bind(D);
	init(A,R,ai,Qim1,Qi,QQi,Pi,Qip1,QQip1,Pip1,rim1,ri,d);
	
	/* Hauptteil */ 
	d = upmssrpp(m,D);
	
	/* Initialisierungen */
	D = ptodp(1,D);
	d = ptodp(1,d);
	ai = d; ri = 0;  
	Pi = 0; Pip1 = d;
	Qi = list2(0,1); 	 
	Qip1 = udpmsprod(m,d,d);
	Qip1 = udpmsdif(m,D,Qip1); 
	QQi = Qi; QQip1 = udpmsmonic(m,Qip1);
	A = 0;		
	while ( !oequal(Pi,Pip1)  && !oequal(QQi,QQip1) ) {
		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		QQi = QQip1; QQip1 = _0;
		rim1 = ri; ri = _0;
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri);
                A = isum(A,lfirst(ai));
		Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1); 
		QQip1 = udpmsmonic(m,Qip1);
	}         
	A = isum(A,A);    
	if( oequal(Pi,Pip1) )	R = isum(A,lfirst(Qi));
	else R = isum(A,lfirst(d));
        return(R);
}
