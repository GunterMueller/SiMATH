/*M
.SH NAME
martomapr - matrix of rational numbers to matrix of polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix martomapr(r, M)
single r;
matrix M;

.SH DESCRIPTION
martomapr() returns the matrix M with all entries converted to
polynomials over the rational numbers.

.PP
.TP
.B M
is a matrix of rational numbers.
M*/
/*H
	Version 1       15.06.1988      Klaus Petry
   DATE martomapr     : 890501
H*/


# include <_matr1.h>

matrix martomapr( r, M )
single r;
matrix M;

{
	list ZM, ZL;
	int a;
	pol b;
	matrix L=0;

	if ( !M ) return( L );

	bind( M, L );
	init( ZL, b );

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
