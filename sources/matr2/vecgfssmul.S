/*M
.SH NAME
vecgfssmul - vector of Galois-field with single characteristic elements, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecgfssmul(p, AL, V, el)
single p;
list AL;
vec V;
gfel el;

.SH DESCRIPTION
vecgfssmul() returns the vector el*V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is a vector over GF(p^n).
.TP 4
.B el
is an element of GF(p^n).
M*/
/*H
	Version 1       11.04.1990      Th. Weis
   DATE vecgfssmul    : 910915
H*/

#include <_matr2.h>

vec vecgfssmul( p, AL, V, el )
single p;
list   AL;
vec    V;
gfel   el;

{          
	gfel   e;
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
	      e = gfsprod( p, AL, e, el );
	      W = lcomp( e, W );
	   }
	   while ( V != _0 );
	   W = linv( W );
	}
	return( W );
}
