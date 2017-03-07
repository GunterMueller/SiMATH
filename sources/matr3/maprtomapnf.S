/*M
.SH NAME
maprtomapnf - matrix of polynomials over the rational numbers to matrix of polynomials over number field

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix maprtomapnf(r, M)
single r;
matrix M;

.SH DESCRIPTION
maprtomapnf() returns the matrix M with all entries converted
to polynomials in r variables over a number field.

.SH SEE ALSO
prtopnf
M*/






/*H
	Version 1       30.04.1992      U.Schneiders
   DATE maprtomapnf   : 921130
H*/

#include <_matr3.h>

matrix maprtomapnf( r, M )
single r;
matrix M;

{
	list   ZM, ZL;
	matrix L;
	pol    a;

	bind( M );
	init( ZL, L, a );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen ueber Q */
/* in die Matrix L von Polynomen in r Variablen ueber einem Zahlkoerper */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      a = prtopnf( r, a );
	      ZL = lcomp( a, ZL );
	      ZM = lred( ZM );
	   }
	   ZL = linv( ZL );
	   L = lcomp( ZL, L );
	   M = lred( M );
	}
	L = linv( L );

	return( L );
}


