/*M
.SH NAME
vecprtovpmi - vector of polynomials over the rational numbers to vector of polynomials over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecprtovpmi(r, V, m)
single r;
vec V;
int m;

.SH DESCRIPTION
vecprtovpmi() returns the vector V with all entries
reduced modulo P
or ERROR in case the gcd of the denominator of an entry and m is not 1.

.PP
.TP 4
.B V
is a vector of polynomials in r variables over the rational numbers.
.TP 4
.B P
is a polynomial in r variables over Z/mZ.
M*/



/*H
	Version  1      25.10.1989      U.Schneiders/C.Hollinger
   DATE vecprtovpmi   : 891101.9011__.9311__
H*/

#include <_matr1.h>

vec vecprtovpmi( r, V, m )
single r;
vec V;
int m;

{
	int hn;
	pol el;
	vec H;
	init( hn, H, el );
	bind( V,m );

	/*** v = ( vi ), Modulorechnung fuer vi ***/

	H = V;
	V = _0;
	while( H != _0 )
	{       el = lfirst( H );
		H = lred( H );
		if( el )
		{       el = prnumden( r, el, &hn );
			if( igcd( hn,m ) != 1 ) return( ERROR );
			hn = miinv( m,hn );
			el = piiprod( r, el ,hn );
			el = pitopmi( r, el, m );
		}
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
