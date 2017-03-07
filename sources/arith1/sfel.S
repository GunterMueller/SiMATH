/*M
.SH NAME
sfel - single factor exponent list

.SH SYNOPSIS
.nf
#include<_arith1.h>

list sfel(n)
single n;

.SH DESCRIPTION
ifel() analyses the prime factorization of the single n
and returns a descendingly sorted list
L = ( p1, e1, ..., pk, ek ) of the prime factors
and their exponents.

.SH SEE ALSO
ifel
M*/
/*H
	Version 1       10.03.1989      Pascale Serf
   DATE sfel          : 890601.9203__
H*/



# include <_arith1.h>

list sfel(n)
single n;
{
	list L;
	single p,e;

	init(L);

	/***    Spezialfall : n = 1    ***/
	if ( n == 1 ) return(_0);

	/***    allgemeiner Fall : n >= 2    ***/
	L = _0;
	while ( issprime(n,&p) >=0 ) {
		e = 0;
		while ( n%p == 0 ) {
			e++;
			n = n/p;
		}
		L = lcomp2(p,e,L);
	}
	return(L);
}
