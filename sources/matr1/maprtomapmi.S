/*M
.SH NAME
maprtomapmi - matrix of polynomials over the rational numbers to matrix of polynomials over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprtomapmi(r, M, m)
single r;
matrix M;
int m;

.SH DESCRIPTION
maprtomapmi() returns the matrix M with all entries
reduced modulo P
or ERROR in case the gcd of the denominator of an entry and m is not 1.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over the rational numbers.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
M*/
/*H
	Version 1       25.10.1989      U.Schneiders/C.Hollinger
	Version 2	15.11.1989      Aufruf von miinv korrigiert.  US
   DATE maprtomapmi   : 891101.900315.9311__
H*/


# include <_matr1.h>

matrix maprtomapmi (r, M, m)
single r;
matrix M;
int m;

{
	int hn;
	list ZM, ZL;
	pol a;
	matrix L;

	bind ( M,m );
	init( hn, ZM, ZL, a, L );

	L = _0;

	/*** M = ( aij ), Modulorechnung fuer aij ***/

	while (M != _0)
	{       ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0)
		{       a = lfirst (ZM);
			if( a )
			{       a = prnumden( r, a, &hn );  
				if( igcd( hn,m ) != 1 ) return( ERROR );
				hn = miinv( m,hn);       
				a = piiprod( r, a, hn );
				a = pitopmi( r, a, m );
			}
			ZL = lcomp (a, ZL);
			ZM = lred (ZM);
		}
		ZL = linv (ZL);
		L = lcomp (ZL, L);
		M = lred (M);
	}
	L = linv (L);

/* Ausgabe */

	return (L);
}
