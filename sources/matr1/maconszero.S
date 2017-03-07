/*M
.SH NAME
maconszero - matrix construction zero

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maconszero(m, n)
single m, n;

.SH DESCRIPTION
maconszero() returns a mxn matrix with all entries set to zero.

M*/
/*H
	Version 1       01.09.1988      Klaus Petry
   DATE maconszero    : 890501.9311__
H*/

#include <_matr1.h>

matrix maconszero(m,n)
single m,n;

{
	matrix N=_0;
	list Z;
	single i;
	bind( N );
	init(Z);

	while ( m-- ) {
		for ( i=n, Z=_0; i--; ) Z=lcomp(0,Z);
		N=lcomp(Z,N);
		}
	return( N );
}
