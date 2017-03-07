/*M
.SH NAME
vpmstovpgfs - vector of polynomials over modular singles to vector of polynomials over Galois-field with single characteristic

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpmstovpgfs(r, p, V)
single r,p;
vec V;

.SH DESCRIPTION
vpmstovpgfs() returns the vector V with all entries converted
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
   DATE vpmstovpgfs   : 910915
H*/

#include <_matr3.h>

vec vpmstovpgfs( r, p, V )
single r, p;
vec    V;

{
	vec L;
	pol a, b;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in r Variablen ueber Z/pZ */
/* in den Vektor L von Polynomen in r Variablen ueber GF(p^n) */
/* (n aus [1,(BASIS-1)] beliebig) */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = pmstopgfs( r, p, a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}


