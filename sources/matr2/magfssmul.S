/*M
.SH NAME
magfssmul - matrix of Galois-field with single characteristic elements, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr2.h>

matrix magfssmul(p, AL, M, el)
single p;
list AL;
matrix M;
gfel el;

.SH DESCRIPTION
magfssmul() returns the matrix el*M.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix over GF(p^n).
.TP 4
.B el
is an element of GF(p^n).
M*/


/*H
	Version 1       11.04.1990      Th. Weis
   DATE magfssmul     : 910915
H*/

#include <_matr2.h>

matrix magfssmul( p, AL, M, el )
single p;
list   AL;
matrix M;
gfel   el;

{
	gfel   e;
	list   Z, ZM;
	matrix H, N;

	bind( AL, M, el );
	init( H, N, Z, ZM, e );

	/*** Elementweise Multiplikation. ***/

	H = macopy( M );
	N = _0;
	while( H != _0 )
	{
	   Z = lfirst( H );
	   H = lred( H );
	   ZM = _0;
	   while( Z != _0 )
	   {
	      e = lfirst( Z );
	      Z = lred( Z );
	      e = gfsprod( p, AL, e, el );
	      ZM = lcomp( e, ZM );
	   }
	   ZM = linv( ZM );
	   N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}
