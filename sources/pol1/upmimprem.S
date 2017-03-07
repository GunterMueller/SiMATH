/*M
.SH NAME
upmimprem - univariate polynomial over modular integers, monomial, polynomial, remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upmimprem(p, C, E, P)  
int p, C, E; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B p
 is a prime number.
.TP 4
.B C
 is an element of Z/pZ, C != 0.
.TP 4
.B E
 is an integer number, E > 0.
.TP 4
.B P
 is a polynomial in the variable x over Z/pZ, 
 deg(P) > 0.
.PP
upmimprem returns the polynomial R in the variable x, where
.IP
R(x) = ( C * x )^E mod P(x).

M*/

/*H
	Version 1	30.07.91	J.Schmitt
	Version 2	08.02.93	isprod -> ip2prod und
					isquot -> ip2quot       J.S.
   DATE upmimprem     : 910915.930531
H*/

# include <_pol1.h>

pol upmimprem(ip,K,E,P)
int ip,K,E;
pol P;
{
	single n;
	int r,z;
	pol B,X;
	bind(ip,K,E,P);
	init(r,z,B,X);

	n = lfirst(P);

	if ( icomp(E,n) < 0 ) {
		K = miexp(ip,K,E);
		E = list2(E,K);
		return(E);
	}
	if ( icomp(E,2) <= 0 ) {
		K = miexp(ip,K,E);
		B = list2(E,K);
		B = upmirem(ip,B,P);
		return(B);
	}

	z = 2;
	while ( icomp(z,E) <= 0 ) z = ip2prod(z,1);
	z = ip2quot(z,1);

	X = list2(1,K);
	B = list2(1,K);
	r = idif(E,z);
	do {
		B = pmiprod(1,ip,B,B);
		if ( pdegree(1,B) >= n ) B = upmirem(ip,B,P);
		z = ip2quot(z,1);
		if ( icomp(r,z) >= 0 ) {
			B = pmiprod(1,ip,X,B);
			if ( pdegree(1,B) >= n ) B = upmirem(ip,B,P);
			r = idif(r,z);
		}
	}
	while ( icomp(z,1) );
	return(B);
}
