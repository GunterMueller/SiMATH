/*M
.SH NAME
vecpgfssmul - vector of polynomials over Galois-field with single characteristic, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpgfssmul(r, p, AL, V, el)
single r,p;
list AL;
vec V;
pol el;

.SH DESCRIPTION
vecpgfssmul() returns vector el*V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is a vector of polynomials in r variables over GF(p^n).
.TP 4
.B el
is a polynomial over GF(p^n).
M*/









/*H
	Version 1       11.04.1990      Th. Weis
   DATE vecpgfssmul   : 910915
H*/

#include <_matr3.h>

vec vecpgfssmul( r, p, AL, V, el )
single r, p;
list   AL;
vec    V;
pol    el;

{          
	pol    e;
	single n;
	vec    W;

	bind( AL, V, el );
	init( e, W );

/* el gleich 0 */

	if( !el )
	{
	   n = llength( V );
	   W = _0;
	   while( n-- ) W = lcomp( 0, W );
	}

/* allgemeiner Fall */

	else
	{
	   W = _0;
	   do
	   {
	      e = lfirst( V );
	      V = lred( V );
	      e = pgfsprod( r, p, AL, e, el );
	      W = lcomp( e, W );
	   }
	   while ( V != _0 );
	   W = linv( W );
	}
	return( W );
}


