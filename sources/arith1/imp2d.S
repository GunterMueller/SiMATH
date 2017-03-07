/*M
.SH NAME
imp2d - integer maximal power of 2 divisibility

.SH SYNOPSIS
.nf
#include<_arith1.h>

single imp2d(A)
int A;

.SH DESCRIPTION
imp2d() returns the maximum exponent n with 2^n | A
or BASIS - 1 in case A equals 0.
M*/
/*H
	Version 1       30.12.86        M.A.Reichert & B.Weis
	Version 2       24.03.87        islist zu !isatom.  MAR.
   DATE imp2d         : 890501
H*/


# include <_arith1.h>

single imp2d( z )
int z;
{
	int n1;
	single zaehler=0;

	if ( !z ) return( BASIS-1 );

	init( n1 );
	bind( z );

	n1 = z;
	if ( !isatom(n1) ) {
		while ( lfirst(n1) == 0 ) {
			zaehler += 30;
			n1 = lred( n1 );
		}
		n1 = lfirst(n1);
	}
	n1 = sabs( n1 );
	if ( !(n1 & 1 ) ) {
		zaehler++;
		while ( !( (n1=n1>>1) & 1 ) ) zaehler++;
	}
	return( zaehler );
}
