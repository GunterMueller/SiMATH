/*M
.SH NAME
iegcd - integer extended greatest common divisor

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iegcd(A,B,pU,pV)
int A,B,*pU,*pV;

.SH DESCRIPTION
iegcd() returns the greatest common divisor C of A and B.
Simultaneously *pU and *pV with C = *pU * A + *pV * B
are calculated. If A and B are not 0, then the following holds:
.PP
        |*pU| <= |B|/2*C und |*pV| <= |A|/2*C,
.PP
Otherwise *pU is the sign of A and *pV is the sign of B.
M*/

/*H
	Version  1      23.06.1986      R.Boeffgen
   DATE iegcd         : 890501
H*/


# include <_arith1.h>

int iegcd ( A,B, pU,pV )               /* unsafe A,B,C,*pV */
int A,B, *pU,*pV;
{
	int  C, D;
	bind(A, B);
	init(C, D);
	C = ihegcd( A,B, &D );
	if ( A==0 )
	    *pU = 0;
	else
	    *pU = iquot( idif( C, iprod(B,D) ), A );
	*pV = D;
	return( C );
}

