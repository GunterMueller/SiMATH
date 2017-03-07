/*M
.SH NAME
vprnfevalfvs - vector of polynomials over the rational numbers, number field element, evaluation first variable, special version

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vprnfevalfvs(r, F, V)
single r;
pol F;
vec V;

.SH DESCRIPTION
vprnfevalfvs() returns the vector V with the first
variable of its variable list replaced by the
generating element of the number field determined by F.
The result is a vector of polynomials in r-1
variables over this number field.
 
.PP
.TP 4
.B F
is an irreducible monic dense polynomial in one variable over Z.
.TP 4
.B V
is a vector of polynomials in r variables over the rational numbers.
M*/





/*H
	Version 1       15.05.92        U.Schneiders
   DATE vprnfevalfvs  : 921130
H*/

#include <_matr3.h>

vec vprnfevalfvs( r, F, V )
single r;
pol F;
vec V;
{
	vec    L;
	pol    a;

	bind( F, V );
	init( L, a );

	L = _0;

/* elementweise Umwandlung des Vektors V von Polynomen in r Variablen ueber Q */
/* in den Vektor L von Polynomen in r-1 Variablen ueber einem Zahlkoerper */

	while ( V != _0 )
	{
	   a = lfirst( V );
	   a = prnfevalfvs( r, F, a );
	   L = lcomp( a, L );
	   V = lred( V );
	}
	L = linv( L );

	return( L );
}


