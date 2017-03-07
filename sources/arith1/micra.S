/*M
.SH NAME
micra - modular integer Chinese remainder algorithm

.SH SYNOPSIS
.nf
#include<_arith1.h>

int micra(M1,M2,N1,A1,A2)
int M1,M2,N1,A1,A2;

.SH DESCRIPTION
Let M1 >0, M2 >0, 
gcd(M1,M2) = 1, and let N1 be the inverse of M1 modulo M2 in Z/M2*Z,
A1 in Z/M1*Z and A2 in Z/M2*Z.

micra() returns the uniquely determined element A
in Z/(M1*M2)Z, which is congruent A1 modulo M1
and congruent A2 modulo M2.
M*/

/*H
	Version 1       19.2.1987               Pascale Serf
   DATE micra         : 890501
H*/


# include <_arith1.h>

int micra(M1,M2,N1,A1,A2)
int M1,M2,N1,A1,A2;
{
	int A,D,B;

	bind5(M1,M2,N1,A1,A2);
	init3(A,D,B);

	A = mihom(M2,A1);
	D = midif(M2,A2,A);
	    /***    Spezialfall : Ergebnis A1    ***/
	if ( D == 0 ) return(A1);
	    /***    allgemeiner Fall    ***/
	B = miprod(M2,D,N1);
	return(isum(iprod(M1,B),A1));
}
