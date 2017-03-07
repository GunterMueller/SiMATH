/*M
.SH NAME
maitomams - matrix of integers to matrix of modular singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maitomams(m, M)
single m;
matrix M;

.SH DESCRIPTION
maitomams() returns the matrix M with all entries converted to
elements of Z/mZ.

.PP
.TP
.B M
is a matrix of integers.
M*/
/*H
	Version 1       20.06.1989      U. Schneiders, Th. Weis
   DATE maitomams     : 890801
H*/


# include <_matr1.h>

matrix maitomams( m, M )
single m;
matrix M;

{
	list ZM, ZL;
	int a;
	single b;
	matrix L;

	bind( M );
	init( L, ZM, ZL, a );

	L = _0;

	while( M != _0 ) {
		ZL = _0;
		ZM = lfirst( M );
		M = lred( M );
		while( ZM != _0 ) {
			a = lfirst( ZM );
			ZM = lred( ZM );
			b = mshom( m, a );
			ZL = lcomp( b, ZL );
			}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		}
	L = linv( L );

/* Ausgabe */

	return( L );
}
