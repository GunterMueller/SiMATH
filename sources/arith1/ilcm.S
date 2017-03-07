/*M
.SH NAME
ilcm - integer least common multiple

.SH SYNOPSIS
.nf
#include<_arith1.h>

int ilcm(A,B)
int A,B;

.SH DESCRIPTION
ilcm() returns least common multiple of A and B.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE ilcm          : 890501
H*/


# include <_arith1.h>

int ilcm ( A, B )
int A,B;
{
	int C;
	if ( A==0 || B==0 )  C = 0;
	else  {
		bind( A ); bind( B );
		A = iabs(A), B = iabs(B);
		C = iprod( iquot(A,igcd(A,B)), B);
	}
	return( C );
}
