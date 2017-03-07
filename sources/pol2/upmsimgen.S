/*M
.SH NAME
upmsimgen - univariate polynomial over modular singles, irreducible and monic, generator

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmsimgen(p, n)  
single p, n;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B n
is an integer number, 0 < n < BASIS.
.PP
upmsimgen returns a randomly generated univariate, monic and irreducible polynomial of degree n over Z/pZ.

.SH NOTES
For p = 2, please use upm2imgen or upm2imtgen.

.SH SEE ALSO
 upm2imgen
 upm2imtgen
 upmsimtgen

M*/

/*H
	Version 1 	12.08.1987   	Pascale Serf
	Version 2       07.12.1987    	Polynomaufbau geaendert  PS
   DATE upmsimgen     : 890501.9305__
H*/


# include <_pol2.h>

pol upmsimgen(p,n)
single p,n;
{
	single j,a;
	int Q,I,I1,Z;
	pol P;

	init5(P,Q,I,I1,Z);

	srand(time(&a)+p/2+n/2);
	Q = iexp(p,n);

	/*    1.Fall : p^n < BASIS    */
	if ( Q < BASIS ) {
		Z = rand() % Q;        /*    Zahl aus {0,...,(p^n)-1}    */
		for ( I=Z ; ; I=(I+1)%Q ) {
			/*    I wird p-adisch dargestellt. Vor diese Dar-
			      stellung wird noch n und 1 geschrieben.    */
			P = _0;
			I1 = I;
			for ( j=n-1 ; j>=0 ; j-- ) {
				a = I1 % p;
				I1 = I1 / p;
				P = lcomp(a,P);
			}
			P = lcomp(1,P);
			P = lcomp(n,P);
			P = dptop(1,P);
			if ( isimupms(p,P) ) return(P);
		}
	}

	/*    2.Fall : p^n >= BASIS    */
	else {
		Z = rand();
		if ( Z >= BASIS ) Z = list2(Z-BASIS,1);
		Z = irem(Z,Q);
		for ( I=Z ; ; I=mihom(Q,isum(I,1)) ) {
			P = _0;
			I1 = I;
			for ( j=n-1 ; j>=0 ; j-- ) {
				isqrem(I1,p,&I1,&a);
				P = lcomp(a,P);
			}
			P = lcomp(1,P);
			P = lcomp(n,P);
			P = dptop(1,P);
			if ( isimupms(p,P) ) return(P);
		}
	}

}
