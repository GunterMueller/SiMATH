/*M
.SH NAME
mapitomapnf - matrix of polynomials over integers to matrix of polynomials over number field

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapitomapnf(r, M)
single r;
matrix M;

.SH DESCRIPTION
mapitomapnf() returns the matrix M with all entries converted
to polynomials in r variables over a number field.

.SH SEE ALSO
pitopnf
M*/






/*H
	Version 1       19.07.1990      Th. Weis
   DATE mapitomapnf   : 910915
H*/

#include <_matr3.h>

matrix mapitomapnf( r, M )
single r;
matrix M;

{
	list   ZM, ZL;
	matrix L;
	pol    a, b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen ueber Z */
/* in die Matrix L von Polynomen in r Variablen ueber einem Zahlkoerper */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = pitopnf( r, a );
	      ZL = lcomp( b, ZL );
	      ZM = lred( ZM );
	   }
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M = lred( M );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}


