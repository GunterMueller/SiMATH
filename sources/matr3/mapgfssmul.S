/*M
.SH NAME
mapgfssmul - matrix of polynomials over Galois-field with single characteristic, scalar multiplication

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgfssmul(r, p, AL, M, el)
single r,p;
list AL;
matrix M;
pol el;

.SH DESCRIPTION
mapgfssmul() returns the matrix el*M.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B M
is a matrix of polynomials in r variables over GF(p^n).
.TP 4
.B el
is a polynomial in r variables over GF(p^n).
M*/









/*H
	Version 1       11.04.1990      Th. Weis
   DATE mapgfssmul    : 910915
H*/

#include <_matr3.h>

matrix mapgfssmul( r, p, AL, M, el )
single r, p;
list   AL;
matrix M;
pol    el;

{
	list   Z, ZM;
	matrix H, N;
	pol    e;

	bind( AL, M, el );
	init( H, N, Z, ZM, e );

/* Elementweise Multiplikation */

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
	      e = pgfsprod( r, p, AL, e, el );
	      ZM = lcomp( e, ZM );
	   }
	   ZM = linv( ZM );
	   N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}


