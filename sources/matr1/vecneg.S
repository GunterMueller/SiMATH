/*M
.SH NAME
vecneg - vector negation

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecneg(V, neg, numargs, arg1, arg2)
vec V;
obj (*neg)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
vecneg() returns the vector -V.

.PP
.TP 4
.B V
is a vector of objects.
.TP 4
.B negfunc
is a function to negate a single element of the vector.
This function is given the element and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by negfunc.
.TP 4
.B arg1, arg2
are at most 2 optional arguments for negfunc.
M*/
/*H
	Version 1       15.03.1989      U.Schneiders
	Version 2	24.07.1991	single arg1,arg2;
					 --> obj arg1,arg2;  Th. W.
   DATE vecneg        : 890601.910915
H*/

#include <_matr1.h>

vec vecneg(V,neg,anzahlargs,arg1,arg2)
vec    V;
obj    ( *neg )();
single anzahlargs;
obj    arg1, arg2;
{
	vec W;
	obj *p10, *p20, *p30, a;

	bind( V );
	bind( arg1,arg2 );
	init( W, a );

/*** Vorbelegung ***/

	p20 = p30 = &a;

	switch( anzahlargs ) {
		case 0: p10 = &a;               /** Z, Q **/
			break;
		case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr **/
			p20 = &a;
			break;
		case 2: p10 = &arg1;            /** Pms **/
			p20 = &arg2;
			p30 = &a;
			break;
		}

/*** Negation   ***/

	W = _0;
	while( V != _0 )
	{       a = lfirst( V );
		V = lred( V );
		a = (*neg)( *p10, *p20, *p30 );
		W = lcomp( a, W );
	}
	return( linv( W ) );
}
