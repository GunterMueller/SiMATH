/*M
.SH NAME
mpmstompgfs - matrix of polynomials over modular singles to matrix of polynomials over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mpmstompgfs(r, p, M)
single r,p;
matrix M;

.SH DESCRIPTION
mpmstompgfs() returns the matrix M with all entries converted
to polynomials in r variables over GF(p^n).
.PP
.TP 4
.B p
must be prime.

.SH SEE ALSO
pmstopgfs
M*/






/*H
	Version 1       19.07.1990      Th. Weis
   DATE mpmstompgfs   : 910915
H*/

#include <_matr3.h>

matrix mpmstompgfs( r, p, M )
single r, p;
matrix M;

{
	list   ZM, ZL;
	matrix L;
	pol    a, b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen ueber Z/pZ */
/* in die Matrix L von Polynomen in r Variablen ueber GF(p^n) */
/* (n aus [1,(BASIS-1)] beliebig) */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = pmstopgfs( r, p, a );
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


