/*M
.SH NAME
maitomami - matrix of integers to matrix of modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maitomami(m, M)
int m;
matrix M;

.SH DESCRIPTION
maitomami() returns the matrix M with all entries converted to
elements of Z/mZ.

.PP
.TP
.B M
is a matrix of integers.
M*/
/*H
	Version 1       25.10.1989      U. Schneiders/C.Hollinger
   DATE maitomami     : 891101.9311__
H*/


# include <_matr1.h>

matrix maitomami( m, M )
int m;
matrix M;

{
	list ZM, ZL;
	int a;
	single b;
	matrix L;

	bind( m,M );
	init( L, ZM, ZL, a );

	L = _0;

	while( M != _0 ) {
		ZL = _0;
		ZM = lfirst( M );
		M = lred( M );
		while( ZM != _0 ) {
			a = lfirst( ZM );
			ZM = lred( ZM );
			b = mihom( m, a );
			ZL = lcomp( b, ZL );
			}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		}
	L = linv( L );

/* Ausgabe */

	return( L );
}
