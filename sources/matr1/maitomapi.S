/*M
.SH NAME
maitomapi - matrix of integers to matrix of polynomials over integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maitomapi(r, M)
single r;
matrix M;

.SH DESCRIPTION
maitomapi() returns the matrix M with all entries converted to
polynomials in r variables over integers.

.PP
.TP
.B M
is a matrix of integers.
M*/
/*H
	Version 1       15.06.1988      Klaus Petry
   DATE maitomapi     : 890501
H*/


# include <_matr1.h>

matrix maitomapi( r, M )
single r;
matrix M;

{
	list ZM, ZL;
	int a;
	pol b;
	matrix L=0;

	if ( !M ) return( L );

	bind( M, L );
	init( ZM, ZL, a, b );

	L = _0;

	while( M != _0 ) {
		ZL = _0;
		ZM = lfirst( M );
		M = lred( M );
		while( ZM != _0 ) {
			a = lfirst( ZM );
			ZM = lred( ZM );
			b = pvinsert( 0, a, r );
			ZL = lcomp( b, ZL );
			}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		}
	L = linv( L );

/* Ausgabe */

	return( L );
}
