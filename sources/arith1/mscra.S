/*M
.SH NAME
mscra - modular single Chinese remainder algorithm

.SH SYNOPSIS
.nf
#include<_arith1.h>

single mscra(m1,m2,n1,a1,a2)
single m1,m2,n1,a1,a2;

.SH DESCRIPTION
Let m1 >0, m2 >0, 
gcd(m1,m2) = 1; let n1 be the inverse of m1 modulo m2 in Z/m2*Z,
a1 in Z/m1*Z and a2 in Z/m2*Z.

mscra() returns the uniquely determined element a
in Z/(m1*m2)Z, which is congruent a1 modulo m1
and congruent a2 modulo m2.
M*/
/*H
	Version 1       16.2.1987               Pascale Serf
	Version 2       16.06.1987              Fehler berichtigt
						  P.Serf
   DATE mscra         : 890501
H*/


# include <_arith1.h>

single mscra(m1,m2,n1,a1,a2)
single m1,m2,n1,a1,a2;
{
	single b,c,d;

	c = a1 % m2;
	d = msdif(m2,a2,c);
	    /***    Spezialfall : Ergebnis a1    ***/
	if ( d == 0 ) return(a1);
	    /***    allgemeiner Fall    ***/
	b = msprod(m2,d,n1);
	return(m1 * b + a1 );
}
