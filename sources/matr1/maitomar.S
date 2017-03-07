/*M
.SH NAME
maitomar - matrix of integers to matrix of rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maitomar(M)
matrix M;

.SH DESCRIPTION
maitomar() returns the matrix M with all entries converted to
rational numbers.

.PP
.TP
.B M
is a matrix of integers.
M*/
/*H
	Version 1       14.06.1988      Klaus Petry
   DATE maitomar      : 890501
H*/


# include <_matr1.h>

matrix maitomar( M )
matrix M;

{
	list ZM, ZL;
	int a;
	rat b;
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
			b = itor( a );
			ZL = lcomp( b, ZL );
			}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		}
	L = linv( L );

/* Ausgabe */

	return( L );
}
