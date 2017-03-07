/*M
.SH NAME
vecrtovecmi - vector of rational numbers to vector of modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecrtovecmi(m, V)
int m;
vec V;

.SH DESCRIPTION
vecrtovecmi() returns the vector V with all entries
reduced modulo m
or ERROR in case the gcd of the denominator of an entry and m is not 1.

.PP
.TP
.B V
is a vector of rational numbers.
M*/





/*H
	Version  1      25.10.1989      U.Schneiders/C.Hollinger
   DATE vecrtovecmi   : 891101.9311__
H*/

#include <_matr1.h>

vec vecrtovecmi( m, V )
int m;
vec V;

{
	int b;
	obj el;
	vec H;
	init( b, H, el );
	bind( m,V );

	/*** v = ( vi ), Modulorechnung fuer jedes vi ***/

	H = V;
	V = _0;
	while( H != _0 )
	{       el = lfirst( H );
		H = lred( H );
		if( el )
		{       b = lsecond( el );
			if( igcd( b,m ) != 1 )  return( ERROR );
			b = miinv( m,b );
			el = lfirst( el );
			el = iprod( el,b );
			el = mihom( m,el );
		}
		V = lcomp( el, V );
	}
	V = linv( V );
	return( V );
}
