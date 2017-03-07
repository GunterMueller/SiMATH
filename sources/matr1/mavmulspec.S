/*M
.SH NAME
mavmulspec - matrix vector multiplication, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mavmulspec(M, v, prodfunc, sumfunc, numargs, arg1, ..., arg5)
matrix M;
vec v;
obj (*prodfunc)(), (*sumfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
mavmulspec() returns the vector M*v.

.PP
.TP 4
.B M
is a matrix over a certain ring R.
.TP 4
.B v
is a vector over the ring R.
M and v must have compatible dimensions.
.TP 4
.B prodfunc, sumfunc
are multiplication and addition functions for the ring R.
These functions are given the two elements to add and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by prodfunc and sumfunc.
.TP 4
.B arg1, ..., arg5
are at most 5 optional arguments for prodfunc and sumfunc.
M*/
/*H
	Version 1       05.04.1990      Th. Weis
   DATE mavmulspec    : 910915
H*/

#include <_matr1.h>

vec mavmulspec(A,x,prod,sum,anzahlargs,arg1,arg2,arg3,arg4,arg5)
matrix A;
vec    x;
obj    ( *prod )(),( *sum )();
single anzahlargs;
obj    arg1, arg2, arg3, arg4, arg5;
{
	list Z;
	obj *p10, *p11, *p20, *p21, *p30, *p31, *p40, *p41;
	obj *p50, *p51, *p60, *p61, *p70, *p71, a, b, c, h;
	vec xx, y;

	bind( A, x );
	bind( arg1,arg2,arg3,arg4,arg5 );
	init( Z, a, b, c, h, xx, y );

/*** Vorbelegung ***/

	p30 = p31 = p40 = p41 = p50 = p51 = p60 = p61 = p70 = p71 = &c;

	switch ( anzahlargs )
	{
	   case 0: p10 = &a;               /** Z, Q **/
	           p20 = &b;
	           p11 = &c;
	           p21 = &h;
	           break;
	   case 1: p10 = p11 = &arg1;      /** Z/mZ, Pi, Pr **/
	           p20 = &a;
	           p30 = &b;
	           p21 = &c;
	           p31 = &h;
	           break;
	   case 2: p10 = p11 = &arg1;      /** Pms **/
	           p20 = p21 = &arg2;
	           p30 = &a;
	           p40 = &b;
	           p31 = &c;
	           p41 = &h;
	           break;
	   case 3: p10 = p11 = &arg1;      /** Pgfs **/
	           p20 = p21 = &arg2;
	           p30 = p31 = &arg3;
	           p40 = &a;
	           p50 = &b;
	           p41 = &c;
	           p51 = &h;
	           break;
	   case 4: p10 = p11 = &arg1;
	           p20 = p21 = &arg2;
	           p30 = p31 = &arg3;
	           p40 = p41 = &arg4;
	           p50 = &a;
	           p60 = &b;
	           p51 = &c;
	           p61 = &h;
	           break;
	   case 5: p10 = p11 = &arg1;
	           p20 = p21 = &arg2;
	           p30 = p31 = &arg3;
	           p40 = p41 = &arg4;
	           p50 = p51 = &arg5;
	           p60 = &a;
	           p70 = &b;
	           p61 = &c;
	           p71 = &h;
	           break;
	}

/*** Matrix * Vektor ***/

	y = _0;
	while ( A != _0 )
	{
	   for ( Z = lfirst( A ), c=0, xx=x; xx!=_0; xx=lred( xx ), Z=lred( Z ) )
	   {
	      a = lfirst( Z );
	      b = lfirst( xx );
	      h = ( *prod )( *p10, *p20, *p30, *p40, *p50, *p60, *p70 );
	      c = ( *sum )( *p11, *p21, *p31, *p41, *p51, *p61, *p71 );
	   }
	   y = lcomp( c, y );
	   A = lred( A );
	}
	return( linv( y ) );
}
