/*M
.SH NAME
igcdcf - integer greatest common divisor and cofactors

.SH SYNOPSIS
.nf
#include<_arith1.h>

int igcdcf(A,B,pU,pV)
int A,B,*pU,*pV;

.SH DESCRIPTION
igcdcf() returns the greatest common divisor C
of A and B. Simultaneously *pU = A / C and *pV = B / C
are calculated.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE igcdcf        : 890501
H*/


# include <_arith1.h>

int igcdcf ( A,B, pU,pV )               /* unsafe A,B,C, *pU */
int A,B, *pU,*pV;
{
	int C;
	bind( A ); bind( B );
	C = igcd( A,B );
	if ( C==0 || C==1 )  *pU=A, *pV=B;
	else {
		bind( C );
		*pU = iquot( A,C );
		bind( *pU );
		*pV = iquot( B,C );
	}
	return( C );
}
