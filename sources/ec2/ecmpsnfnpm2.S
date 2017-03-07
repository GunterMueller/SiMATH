/*M
.SH NAME
ecmpsnfnpm2 - elliptic curve over modular primes, short normal form, number of points modulo 2

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecmpsnfnpm2(p, a4, a6)  
int p, a4, a6;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p > 3.
.TP 4
.B a4, a6
are the coefficients of an elliptic curve, say E, in short Weierstrass normal form over Z/pZ.
.PP
Let n be the number of rational points on E, then ecmpsnfnpm2 returns the number m, where 
.IP
m = n modulo 2.

M*/
                          
/*H
	Version 1	30.09.91	J.Schmitt
   DATE ecmpsnfnpm2   : 920331
H*/

#include<_ec2.h>

single ecmpsnfnpm2(P,a4,a6)
int P,a4,a6;
{       
	pol R,R2;
	init(R,R2);
	bind(P,a4,a6);
	
	R  = list2(3,1);
	a4 = mihom(P,a4);
	if ( a4 ) R = lconc(R,list2(1,a4));
	a6 = mihom(P,a6);
	if ( a6 ) R = lconc(R,list2(0,a6));
	R2 = R;
	R  = upmimprem(P,1,P,R);
	R  = pmidif(1,P,R,list2(1,1));
	R  = upmigcd(P,R,R2);
	if ( pdegree(1,R) ) return(0);
	return(1);
}
	
