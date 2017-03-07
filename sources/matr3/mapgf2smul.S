/*M
.SH NAME
mapgf2smul - matrix of polynomials over Galois-field with characteristic 2, scalar multiplication 

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapgf2smul(r, G, M, po) 
single r;
pol G, po;
matrix M;

.SH DESCRIPTION
mapgf2smul() returns the matrix po*M.

.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
.TP 4
.B po
is an element of GF(2^n)[x_1,...,x_r].
M*/
/*H
	Version 1       08.03.1996      S. Schmitt
   DATE mapgf2smul    : 960501
H*/

#include <_matr3.h>

matrix mapgf2smul( r, G, M, po )
single r;
pol    G,po;
matrix M;

{
	list   Z, ZM;
	matrix H, N;
	pol    e;

	bind( G, M, po );
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
	      e = pgf2prod( r, G, e, po );
	      ZM = lcomp( e, ZM );
	   }
	   ZM = linv( ZM );
	   N = lcomp( ZM, N );
	}
	N = linv( N );
	return( N );
}


