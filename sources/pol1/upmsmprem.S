/*M
.SH NAME
upmsmprem - univariate polynomial over modular singles, monomial, polynomial, remainder
.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upmsmprem(m, c, E, P)
single m, c;
int E;
pol P;

.SH DESCRIPTION
.TP 4
.B m
 is a prime number, 0 < m < BASIS.
.TP 4
.B c
 is an element of Z/mZ, c != 0.
.TP 4
.B E
 is an integer number, E > 0.
.TP 4
.B P
 is an univariate polynomial in the variable x 
 over Z/mZ, deg(P) > 0.
.PP
upmsmprem returns the polynomial R in the variable x, where                     
.IP                                                                             
R(x) = ( c * x )^E mod P(x).   

M*/

/*H
	Version 1       07.02.88        J.Schmitt
	Version 2	30.07.91	J.S. lfirst -> pdegree
	Version 3	05.02.93	J.S. integer-Exp. zugelassen
   DATE upmsmprem     : 890501.9011__.910915.930531
H*/


# include <_pol1.h>

pol upmsmprem(m,k,T,P)
single m,k;
int T;
pol P;
{
	single n;
	int z,r;
	pol B,X;
	bind(T,P);
	init(z,r,B,X);
	
	n = lfirst(P);

	if ( icomp(T,n) < 0 ) {
		k = msexp(m,k,T);
		T = list2(T,k);
		return(T);
	}
	if ( icomp(T,2) <= 0 ) {
		k = msexp(m,k,T);
		B = list2(T,k);
		T = upmsrem(m,B,P);
		return(T);
	}

	z = 2;
	while ( icomp(z,T) <= 0 ) z = ip2prod(z,1);
	z = ip2quot(z,1);
	
	X = list2(1,k);
	B = list2(1,k);
	r = idif(T,z);
	do {
		B = pmsprod(1,m,B,B);
		if ( pdegree(1,B) >= n ) B = upmsrem(m,B,P);
		z = ip2quot(z,1);
		if ( icomp(r,z) >= 0 ) {
			B = pmsprod(1,m,X,B);
			if ( pdegree(1,B) >= n ) B = upmsrem(m,B,P);
			r = idif(r,z);
		}
	}
	while ( icomp(z,1) );
	return(B);
}
