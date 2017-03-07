/*M
.SH NAME
rfmsp1inv - rational function over modular single primes, transcendence degree 1, inverse

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfmsp1inv(p, R1)  
single p; 
rfunc R1;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B R1
is an element in the rational function field in one variable over Z/pZ, R1 != 0.
.PP
rfmsp1inv returns a rational function, say R, where
.IP            
R = R1^(-1).

M*/
      
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfmsp1inv     : 890501.9203__
H*/


#include <_arith3.h>

rfunc rfmsp1inv(p,R)
single p;
rfunc R;
{
	single a;
	pol R1;
	bind(R);
	init(R1);

	R1 = lfirst(R);
	R = lsecond(R);
	a = lsecond(R1);
	if (a != 1) a = msinv(p,a), R1 = pmsmsprod(1,p,R1,a), R = pmsmsprod(1,p,R,a);
	R1 = list2(R,R1);

/* Ausgabe */

	return(R1);
}
