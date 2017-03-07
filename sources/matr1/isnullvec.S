/*M
.SH NAME
isnullvec - is null-vector

.SH SYNOPSIS
.nf
#include<_matr1.h>

single isnullvec(V)
vec V;

.SH DESCRIPTION
isnullvec() returns 1, if all entries of the vector V are zero
and 0 otherwise.
M*/
/*H
	Version 1       17.04.1989      U.Schneiders
   DATE isnullvec     : 890601
H*/

#include <_matr1.h>

single isnullvec( V )
vec V;

{
	obj v;
	init( v );
	bind( V );

	while( V != _0 )
	{       v = lfirst( V );
		if( !oequal( v, 0 ) ) return( 0 );
		V = lred( V );
	}
	return (1);
}
