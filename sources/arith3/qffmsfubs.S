/*M
.SH NAME
qffmsfubs - quadratic function field over modular singles fundamental unit, baby step version

.SH SYNOPSIS
.nf
#include<_arith3.h>

list qffmsfubs(m, D)  
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
qffmsfubs returns a list L = (E1, E2), where
.TP 4
E1, E2
are two polynomials in Z/mZ[X], such that            E1 + E2*D^(1/2) is a fundamental unit of the real quadratic function field Z/mZ(X,D^(1/2)).
.PP 
qffmsfubs uses an improved version of the baby-step algorithm.

.SH NOTES 
A slower version of the baby-step algorithm is given by qffmsfuobs.
 
.SH SEE ALSO
qffmsfuobs

M*/

/*H
	Version 1	03.05.1991	A.Stein
   DATE qffmsfubs     : 910715.9203__.9211__
H*/


#include <_arith3.h>

int qffmsfubs(m,D)
single m;
pol D;
{        
	single c,i;
	pol ai, d, Qim1, Qi, QQi, Pi, Qip1, QQip1, Pip1, rim1, ri; 
	pol pim2, pim1, pi, qim2, qim1, qi;
	bind(D);
	init(ai,Qim1,Qi,QQi,Pi,Qip1,QQip1,Pip1,rim1,ri,d); 
	init(pim2,pim1,pi,qim2,qim1,qi); 
	
	/* Hauptteil */
	d = upmssrpp(m,D); 

        /* Initialisierungen */ 
	D = ptodp(1,D);
	d = ptodp(1,d);
	ai = d; ri = 0; i = 0;  
	Pi = 0; Pip1 = d;
	Qi = list2(0,1);
	Qip1 = udpmsprod(m,d,d);
	Qip1 = udpmsdif(m,D,Qip1); 
	QQi = Qi; QQip1 = udpmsmonic(m,Qip1);       
        pim2 = 0; pim1 = Qi; pi = d;	
	qim2 = Qi; qim1 = 0; qi = Qi;

	while ( !oequal(Pi,Pip1)  && !oequal(QQi,QQip1) ) {
		++i;
		Pi = Pip1; Pip1 = _0;
		Qim1 = Qi; Qi = Qip1; Qip1 = _0;
		QQi = QQip1; QQip1 = _0;
		rim1 = ri; ri = _0;
		pim2 = pim1; pim1 = pi; 
		qim2 = qim1; qim1 = qi; 
		ai = udpmssum(m,Pi,d);
		ai = udpmsqrem(m,ai,Qi,&ri); 
                pi = udpmsprod(m,ai,pim1);
		pi = udpmssum(m,pi,pim2); 
                qi = udpmsprod(m,ai,qim1);
		qi = udpmssum(m,qi,qim2);
                Pip1 = udpmsdif(m,d,ri);
		Qip1 = udpmsdif(m,ri,rim1);
		Qip1 = udpmsprod(m,ai,Qip1);
		Qip1 = udpmssum(m,Qim1,Qip1); 
		QQip1 = udpmsmonic(m,Qip1);
	}  
	if( oequal(Pi,Pip1) ) {
                pi   = 	udpmsprod(m,pi,qim1);
		pim1 = 	udpmsprod(m,pim1,qim2);
		pim1 = 	udpmssum(m,pim1,pi);
		qi   = 	udpmssum(m,qi,qim2);
		qim1 = 	udpmsprod(m,qim1,qi); 
        }	
	else {  
		pi = udpmsprod(m,pi,qi);
		pim1 = udpmsprod(m,pim1,qim1);
		qi = udpmsprod(m,qi,qi);
		qim1 = udpmsprod(m,qim1,qim1);		
                if ( i%2 ) {
			c = lsecond(Qip1);
			c = msinv(m,c);
			c = msprod(m,c,lsecond(Qi));
			pi = udpmsmsprod(m,pi,c);
			pim1 = udpmssum(m,pi,pim1);
			qi = udpmsmsprod(m,qi,c);
			qim1 = udpmssum(m,qi,qim1);
		}
		else {                   	
			c = lsecond(Qi);
			c = msinv(m,c);
			c = msprod(m,c,lsecond(Qip1));
			pim1 = udpmsmsprod(m,pim1,c);
			pim1 = udpmssum(m,pi,pim1);
			qim1 = udpmsmsprod(m,qim1,c);
			qim1 = udpmssum(m,qi,qim1);
		}
        }                 
	pim1 = dptop(1,pim1);
	qim1 = dptop(1,qim1);
	ai = list2(pim1,qim1);
	return(ai);              
}
