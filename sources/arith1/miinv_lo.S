/*M
.SH NAME
miinv_lo - modular integer inverse, lists only

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miinv_lo(M,A)
int M,A;

.SH DESCRIPTION
miinv_lo() returns A^(-1) for M>0 and A from Z/MZ in case gcd(A,M)=1,
and 0 otherwise.
The computation is completely performed within the SIMATH memory
management, i.e. using only lists.
M*/
/*H
	Version  1      14.02.1992	Marc Conrad (altes miinv)
   DATE miinv_lo      : 920331
H*/


# include <_arith1.h>

int miinv_lo( M, A)
int M, A;
{
	int y;

	init( y );
	bind( M , A );    

	if (ihegcd( M , A , &y ) != 1) return (0);
	while ( isign(y) == -1 ) {
		y = isum( y , M );
	}
	return( y );
}
