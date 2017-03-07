/*M
.SH NAME
manftomudpr - matrix of number field elements to matrix of univariate dense polynomials over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix manftomudpr(F, M)
pol F;
matrix M;

.SH DESCRIPTION
manftomudpr() returns the matrix M with all entries converted to
univariate dense polynomials over the rational numbers.

.PP
.TP
.B M
is a matrix of number field elements.

.SH SEE ALSO
nfeltoudpr
M*/


/*H
	Version 1       18.07.1990      Th. Weis
   DATE manftomudpr   : 910915
H*/

#include <_matr2.h>

matrix manftomudpr( F, M )
pol    F;
matrix M;

{
	list   ZM, ZL;
	matrix L;
	nfel   a;
	pol    b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M ueber einem Zahlkoerper in die Matrix L von */
/* Polynomen in einer Variablen ueber Q, in dense-Darstellung */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = nfeltoudpr( a );
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
