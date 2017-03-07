/*M
.SH NAME
mpm2tompgf2 - matrix of polynomials modulo 2 to matrix of polynomials over Galois-field with characteristic 2  

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mpm2tompgf2(r, M) 
single r;
matrix M;

.SH DESCRIPTION
mpm2tompgf2() returns the matrix M represented as a matrix over 
polynomials in r variables over GF(2^n), that means that the
coefficients of the polynomials are embedded from Z/2Z to GF(2^n).
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B M
is a matrix in ((Z/2Z)[x_1,...,x_r])^(i,j).

.SH SEE ALSO
pm2topgf2
M*/

/*H
	Version 1       29.02.1996      S. Schmitt
   DATE mpm2tompgf2   : 960501
H*/

#include <_matr3.h>

matrix mpm2tompgf2( r, M )
single r;
matrix M;

{
	list   ZM, ZL;
	matrix L;
	pol    a, b;

	bind( M );
	init( ZL, L, a, b );

/* Initialisierung von L */

	L = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen ueber Z/2Z */
/* in die Matrix L von Polynomen in r Variablen ueber GF(2^n) */
/* (n aus [1,(BASIS-1)] beliebig) */

	while ( M != _0 )
	{
	   ZL = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      b = pm2topgf2( r, a );
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


