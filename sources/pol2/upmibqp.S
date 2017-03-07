/*M
.SH NAME
upmibqp - univariate polynomial over modular integers, Berlekamp Q polynomials construction

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmibqp(p, P)  
int p; 
pol P;

.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B P
is an polynomial in one variable (say x) over Z/pZ of degree >= 2.
.PP
upmibqp returns a list of univariate polynomials, say Qi (0 <= i <= deg(P)-1), over Z/pZ, where  
.IP
Qi is the remainder on dividing x^(p*i) by P.
  
M*/

/*H
	Version 1       24.07.91	J.Schmitt
   DATE upmibqp       : 910915
H*/

# include <_pol2.h>

list upmibqp(ip,P)
int ip;
pol P;
{
	single n,i;
	int k,m;
	pol A,B,C,X;
	list Q;

        bind(ip,P);
	init(k,m,A,B,C,X,Q);

	k = 2;
	while ( icomp(k,ip) <= 0 ) k = isum(k,k);
	k = isquot(k,2);

	n = lfirst(P);
	A = ptodp(1,P);
	C = list2(0,1);                 /*    C = 1 als dense-Polynom   */
	Q = list1(C);
	X = list3(1,1,0);               /*    X = x als dense-Polynom   */
	B = X;
	m = idif(ip,k);
	do {
		B = dpmiprod(1,ip,B,B);
		if ( lfirst(B) >= n ) B = udpmirem(ip,B,A);
		k = isquot(k,2);
		if ( icomp(m,k) >= 0 ) {
			B = dpmiprod(1,ip,X,B);
			if ( lfirst(B) >= n ) B = udpmirem(ip,B,A);
			m = idif(m,k);
		}
	} while ( icomp(k,1) );
	Q = lcomp(dptop(1,B),Q);

	C=B;
	for (i=2; i<=n-1; i++) {
		C = dpmiprod(1,ip,B,C);
		if ( lfirst(C) >= n ) C = udpmirem(ip,C,A);
		Q = lcomp(dptop(1,C),Q);
	}

	Q=linv(Q);
	return(Q);
}
