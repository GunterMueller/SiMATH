/*M
.SH NAME
vpm2tovpgf2 - vector of polynomials modulo 2 to vector of polynomials over Galois-field with characteristic 2  

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vpm2tovpgf2(r, V) 
single r;
vec V;

.SH DESCRIPTION
vpm2tovpgf2() returns the vector V with the coefficients embedded to GF(2^n).
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B V
is a vector of polynomials in r variables with coefficients in Z/2Z.

.SH SEE ALSO
pm2topgf2
M*/
/*H
	Version 1       29.02.1996      S. Schmitt
   DATE vpm2tovpgf2   : 960501
H*/

#include <_matr3.h>

vec vpm2tovpgf2( r, V )
single r;
vec    V;

{
	vec L;
	pol a, b;

	bind( V );
	init( L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in r Variablen ueber Z/2Z */
/* in den Vektor L von Polynomen in r Variablen ueber GF(2^n) */
/* (n aus [1,(BASIS-1)] beliebig) */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   b = pm2topgf2( r, a );
	   L = lcomp( b, L );
	   V = lred( V );
	}
	L = linv( L );

/* Ausgabe */

	return( L );
}


