/*M
.SH NAME
vecsumspec - vector sum, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecsumspec(U, V, sumfunc, numargs, arg1, ..., arg5)
vec U, V;
obj (*sumfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
vecsumspec() returns the vector U+V.

.PP
.TP 4
.B U, V
are vectors over a certain ring R.
U and V must have equal length.
.TP 4
.B sumfunc
is an addition function for a certain ring R.
This function is given the two elements to add and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by sumfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for sumfunc.
M*/
/*H
	Version 1       28.03.1990      Th. Weis
   DATE vecsumspec    : 910915
H*/

#include <_matr1.h>

vec vecsumspec(U,V,sum,anzahlargs,arg1,arg2,arg3,arg4,arg5)
vec    U,V;
obj    ( *sum )();
single anzahlargs;
obj    arg1, arg2, arg3, arg4, arg5;
{
	obj *p10, *p20, *p30, *p40, *p50, *p60, *p70, u, v, w;
	vec W;

	bind( U, V );
	bind( arg1,arg2,arg3,arg4,arg5 );
	init( W, u, v, w );

/*** Vorbelegung ***/

	p30 = p40 = p50 = p60 = p70 = &u;

	switch ( anzahlargs )
	{
	   case 0: p10 = &u;               /** Z, Q **/
	           p20 = &v;
	           break;
	   case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr **/
	           p20 = &u;
	           p30 = &v;
	           break;
	   case 2: p10 = &arg1;            /** Pms **/
	           p20 = &arg2;
	           p30 = &u;
	           p40 = &v;
	           break;
	   case 3: p10 = &arg1;            /** Pgfs **/
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &u;
	           p50 = &v;
	           break;
	   case 4: p10 = &arg1;
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &arg4;
	           p50 = &u;
	           p60 = &v;
	           break;
	   case 5: p10 = &arg1;
	           p20 = &arg2;
	           p30 = &arg3;
	           p40 = &arg4;
	           p50 = &arg5;
	           p60 = &u;
	           p70 = &v;
	           break;
	}

/*** Addition ***/

	W = _0;
	while ( U != _0 )
	{
	   u = lfirst( U );
	   v = lfirst( V );
	   w = ( *sum )( *p10, *p20, *p30, *p40, *p50, *p60, *p70 );
	   W = lcomp( w, W );
	   U = lred( U );
	   V = lred( V );
	}
	return( linv( W ) );
}
