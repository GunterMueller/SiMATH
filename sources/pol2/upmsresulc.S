/*M
.SH NAME
upmsresulc - univariate polynomial over modular singles resultant and cofactor of resultant equation

.SH SYNOPSIS
.nf
#include<_pol2.h>

single upmsresulc(p, P1, P2, pB) 
single p; 
pol P1, P2, *pB;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4                                                                           
.B P1, P2                                                                       
are univariate polynomials with positive degree over Z/pZ.                      
.PP                                                                             
Let r be the resultant of P1 and P2 (hence r is an element of Z/pZ), and let B be
an univariate polynomial over Z/pZ, such that there exists an                   
univariate polynomial A over Z/pZ with                                          
.IP                                                                             
P1 * A + P2 * B = r.                                                            
.PP                                                                             
upmsresulc returns r and writes B to *pB.                                        
M*/

/*H
	Version 1       08.05.1989      J.Schmitt
	Version 2	30.12.1989      J.Schmitt
					Sicherung von *pC;
   DATE upmsresulc    : 891101.900101
H*/


#include <_pol2.h>

single upmsresulc(m,P1,P2,pC)
single m;
pol P1, P2;
pol *pC;
{
	single a, as, eP1, eP2, eP3, i, s;
	pol P3, Q, v1, v2, v3;
	bind(P1,P2);
	init(P3,Q,v1,v2,v3);

	a = 1;
	eP1 = lfirst(P1);
	eP2 = lfirst(P2);
	s = 0;
	v1 = 0;
	v2 = list2(0,1);
	if ( eP1 < eP2 ) {
		if ( sodd(eP1)  &&  sodd(eP2) ) s = 1;
		P3 = P1;
		P1 = P2;
		P2 = P3;
		v1 = v2;
		v2 = 0;
	}

	do {
		Q = pmsqrem(1,m,P1,P2,&P3);
		v3 = pmsdif(1,m,v1,pmsprod(1,m,Q,v2));
		if (!P3) { a = 0; *pC = v3; break; }
		eP1 = lfirst(P1);
		eP2 = lfirst(P2);
		eP3 = lfirst(P3);
		if (sodd(eP1)  &&  sodd(eP2)) s = 1-s;
		as = lsecond(P2);
		for (i = eP1-eP3; i; i--) a = msprod(m,a,as);
		P1 = P2;
		P2 = P3;
		v1 = v2;
		v2 = v3;
	}
	while (eP3);
	if (a) {
		as = lsecond(P2);
		for (i = eP2; i != 1; i--) a = msprod(m,a,as);
		v1 = pmsmsprod(1,m,v2,a);
		a = msprod(m,a,as);
		if (s) a = m-a;
		*pC = v1;
	}

	return(a);
}
