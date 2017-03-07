/*M
.SH NAME
maptomaup - matrix of polynomials to matrix of univariate polynomials

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maptomaup(r, M)
single r;
matrix M;

.SH DESCRIPTION
maptomaup() returns the matrix M with all entries converted to
univariate polynomials.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables.

.SH SEE ALSO
ptoup
M*/








/*H
	Version 1       19.07.1990      Th. Weis
   DATE maptomaup     : 910915
H*/

#include <_matr1.h>

matrix maptomaup( r, M )
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

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen */
/* in die Matrix L von Polynomen in einer Variablen */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = ptoup( r, a );
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
