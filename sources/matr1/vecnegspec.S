/*M
.SH NAME
vecnegspec - vector negation, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecnegspec(V, negfunc, numargs, arg1, ..., arg5)
vec V;
obj (*negfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
vecnegspec() returns the vector -V.

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
.B arg1, ..., arg5
are at most 5 optional arguments for negfunc.
M*/
/*H
	Version 1       21.03.1990      Th. Weis
   DATE vecnegspec    : 910915
H*/

#include <_matr1.h>

vec vecnegspec(V,neg,anzahlargs,arg1,arg2,arg3,arg4,arg5)
vec    V;
obj    ( *neg )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5;
{
	obj *p10, *p20, *p30, *p40, *p50, *p60, a;
	vec W;

	bind( V );
	bind( arg1,arg2,arg3,arg4,arg5 );
	init( W, a );

/*** Vorbelegung ***/

	p20 = p30 = p40 = p50 = p60 = &a;

	switch ( anzahlargs )
	{
	   case 0: p10 = &a;               /** Z, Q **/
	           break;
	   case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr **/
	           p20 = &a;
	           break;
	   case 2: p10 = &arg1;            /** Pms **/
	           p20 = &arg2;
	           p30 = &a;
	           break;
	   case 3: p10 = &arg1;            /** Pgfs **/
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &a;
	           break;
	   case 4: p10 = &arg1;
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &arg4;
	           p50 = &a;
	           break;
	   case 5: p10 = &arg1;
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &arg4;
	           p50 = &arg5;
	           p60 = &a;
	           break;
	}

/*** Negation ***/

	W = _0;
	while ( V != _0 )
	{
	   a = lfirst( V );
	   V = lred( V );
	   a = ( *neg )( *p10, *p20, *p30, *p40, *p50, *p60 );
	   W = lcomp( a, W );
	}
	return( linv( W ) );
}
