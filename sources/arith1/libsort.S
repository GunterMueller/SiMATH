/*M
.SH NAME
libsort - list of integers bubble sort

.SH SYNOPSIS
.nf
#include<_arith1.h>

single libsort(L)
list L;

.SH DESCRIPTION
libsort() sorts L ascendingly in place
using bubble-sort and returns 0.
M*/
/*H
	Version  1      23.01.1990      Christine Hollinger
   DATE libsort       : 900315.9311__
H*/

#include <_arith1.h>

single libsort( L )
list L;
{
	int a1,a2;
	list L1, L2, M, M1;
	init( a1,a2, L1, L2, M, M1 );
	bind( L );

	if ( L == _0 ) return(0);
	M = _0;
	do {
		L1 = L;
		a1 = lfirst( L1 );
		M1 = _0;
		while ( ( L2 = lred( L1 ) ) != M )
		{       a2 = lfirst( L2 );
			if( isign( idif( a1,a2 ) ) == 1 )
			{       lsfirst( L1,a2 );
				lsfirst( L2,a1 );
				M1 = L2;
			}
			else  a1 = a2;
			L1 = L2;
		}
	}
	while ( ( M = M1 ) != _0 );
	return( 0 );
}
