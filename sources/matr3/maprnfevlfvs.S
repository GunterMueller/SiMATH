/*M
.SH NAME
maprnfevlfvs - matrix of polynomials over the rational numbers, number field element, evaluation first variable, special version

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix maprnfevlfvs(r, F, M)
single r;
pol F;
matrix M;

.SH DESCRIPTION
maprnfevlfvs() returns the matrix M with the first
variable of its variable list replaced by the
generating element of the number field determined by F.
The result is a matrix of polynomials in r-1
variables over this number field.
 
.PP
.TP 4
.B F
is an irreducible monic dense polynomial in one variable over Z.
.TP 4
.B M
is a matrix of polynomials in r variables over the rational numbers.
M*/





/*H
	Version 1       15.05.92        U.Schneiders
   DATE maprnfevlfvs  : 921130
H*/

#include <_matr3.h>

matrix maprnfevlfvs( r, F, M )
single r;
pol F;
matrix M;
{
	list   ZM, ZN;
	matrix N;
	pol    a;

	bind( F, M );
	init( ZN, N, a );

/* Initialisierung von N */

	N = _0;

/* elementweise Umwandlung der Matrix M von Polynomen in r Variablen ueber Z */
/* in die Matrix N von Polynomen in r-1 Variablen ueber einem Zahlkoerper */

	while ( M != _0 )
	{
	   ZN = _0;
	   ZM = lfirst( M );
	   while ( ZM != _0 )
	   {
	      a = lfirst( ZM );
	      a = prnfevalfvs( r, F, a );
	      ZN = lcomp( a, ZN );
	      ZM = lred( ZM );
	   }
	   ZN = linv( ZN );
	   N = lcomp( ZN, N );
	   M = lred( M );
	}
	N = linv( N );

	return( N );
}


