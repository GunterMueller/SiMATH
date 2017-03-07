/*M
.SH NAME
miscra - modular integer single Chinese remainder algorithm

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miscra(M,m,m1,A,a)
int M,A;
single m,m1,a;

.SH DESCRIPTION
Let M >0, m >0 and odd, 
gcd(M,m) = 1, let m1 be the inverse of M modulo m,
A a unit in (Z/M*Z)* and a in Z/m*Z.

miscra() returns the uniquely determined unit B
in (Z/(M*m)Z)*, which is congruent A modulo M
and congruent a modulo m.
M*/

/*H
	Version 1       16.2.1987               Pascale Serf
	Version 2       30.3.1987               5 statt 4 Eingabeparameter
						  P. Serf
   DATE miscra        : 890501
H*/


# include <_arith1.h>

int miscra(M,m,m1,A,a)
int M,A;
single m,m1,a;
{
	single a1,d,b;

	bind2(M,A);

	a1 = mshom(m,A);
	d = msdif(m,a,a1);
	    /***    Spezialfall : Ergebnis A    ***/
	if ( d == 0 ) return(A);
	    /***    allgemeiner Fall    ***/
	b = msprod(m,d,m1);
	if ( b+b > m ) b = b-m;
	return(isum(isprod(M,b),A));
}
