/*M
.SH NAME
martomami - matrix of rational numbers to matrix of modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix martomami(m, M)
int m;
matrix M;

.SH DESCRIPTION
martomami() returns the matrix M with all entries
reduced modulo m
or ERROR in case the gcd of the denominator of an entry and m is not 1.

.PP
.TP
.B M
is a matrix of rational numbers.
M*/
/*H
	Version 1       25.10.1989      U. Schneiders/C.Hollinger
   DATE martomami     : 891101.9011__.9311__
H*/


# include <_matr1.h>

matrix martomami( m, M )
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

	/*** M = ( aij ), Modulorechnung fuer jedes aij ***/

	while( M != _0 )
	{       ZL = _0;
		ZM = lfirst( M );
		M = lred( M );
		while( ZM != _0 )
		{       a = lfirst( ZM );
			ZM = lred( ZM );
			if( a )
			{       b = lsecond( a );
				if( igcd( b,m ) != 1 )  return( ERROR );
				b = miinv( m,b );
				a = lfirst( a );
				a = iprod( a,b );
				a = mihom( m,a );
			}
			ZL = lcomp( a, ZL );
		}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}
