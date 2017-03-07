/*M
.SH NAME
upmimpexp - univariate polynomial over modular integers modular polynomial exponentiation

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmimpexp(p,K,E,P)  
int p, E; 
pol K, P;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B E
is a positive integer number.
.TP 4
.B K, P
are univariate polynomials over Z/pZ of positive degree.
.PP
upmimpexp returns a polynomial R, where
.IP
R = K ^ E mod P.

M*/

/*H
	Version 1	28.09.91	J.Schmitt
   DATE upmimpexp     : 920331
H*/

# include <_pol2.h>

pol upmimpexp(ip,K,E,P)
int ip;
pol K;
int E;
pol P;
{
	int r,z;
	single n;
	pol B,X;
	bind(ip,K,E,P);
	init(r,z,B,X);

	n = lfirst(P);

	if ( icomp(E,2) <= 0 ) {
		B = pmiexp(1,ip,K,E);
		if ( pdegree(1,B) >= n ) B = upmirem(ip,B,P);
		return(B);
	}

	z = 2;
	while ( icomp(z,E) <= 0 ) z = isprod(z,2);

	z = isquot(z,2);

	X = K;
	B = K;

	r = idif(E,z);
	do {
		B = pmiprod(1,ip,B,B);
		if ( pdegree(1,B) >= n ) B = upmirem(ip,B,P);
		z = isquot(z,2);
		if ( icomp(r,z) >= 0 ) {
			B = pmiprod(1,ip,X,B);
			if ( pdegree(1,B) >= n ) B = upmirem(ip,B,P);
			r = idif(r,z);
		}
	}
	while ( icomp(z,1) );
	return(B);
}
