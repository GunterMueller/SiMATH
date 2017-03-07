/*M
.SH NAME
bpmisubcubeq - bivariate polynomial over modular integers substitution with respect to a cubic equation

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol bpmisubcubeq(p, P, R)  
int p; 
pol P, R;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4                          
.B P
is a polynomial in two variables, say x and y, y the main variable, over Z/pZ.
.TP 4
.B R
is a polynomial in the variable x over Z/pZ, R is in the shape of
.IP
X^3 + a*x + b; 	0 <= a,b <= p-1.
.PP
bpmisubcubeq returns the polynomial P1, which arises by the substitution of y^2 in P by R.
The degree of P1 with regard to y is smaller than 2.
  
M*/
                                      
/*H
	Version 1	26.10.91	J.Schmitt
   DATE bpmisubcubeq  : 920331
H*/

#include <_pol2.h>

pol bpmisubcubeq(p,P,R)
int p;
pol P;
pol R;
{                 
	single n, i;
	pol k, Rp, P2, P3;

	bind(p,P,R);
	init(k,Rp,P2,P3);
        
	n = pdegree(2,P);
	if ( n < 2 ) return(P);

	i  = n;
	if ( n%2 ) P3 = _0;
	else P3 = list1(0);
	for ( ; i >= 0; i--) {
		if (P == _0  ||  lfirst(P) < i) P2 = 0;
		else {
			P  = lred(P);
			P2 = lfirst(P);
			P  = lred(P);
		}
		P3 = lcomp(P2,P3);
	}

	n  = n / 2;
	Rp = list2(0,1);
	P  = lfirst(P3);
	P3 = lred(P3);
	P2 = lfirst(P3);
	P3 = lred(P3);	
	for ( i = 0; i < n; i++ ) {
		Rp = pmiprod(1,p,Rp,R);		
               	k  = lfirst(P3);
        	P3 = lred(P3);
		k  = pmiprod(1,p,k,Rp);		
		P  = pmisum(1,p,k,P);		
               	k  = lfirst(P3);
        	P3 = lred(P3);
		k  = pmiprod(1,p,k,Rp);		
		P2 = pmisum(1,p,k,P2);		
	}
	if (P)  {
		P  = list2(0,P);
		if ( P2 ) {
			P = lcomp(P2,P);
			P = lcomp(1,P);
		}
	}
	else if ( P2 ) P = list2(1,P2);
	return(P);
}
