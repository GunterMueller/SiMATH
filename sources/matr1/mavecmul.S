/*M
.SH NAME
mavecmul - matrix vector multiplication

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec mavecmul(M, v, prodfunc, sumfunc, numargs, arg1, arg2)
matrix M;
vec v;
obj (*prodfunc)(), (*sumfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
mavecmul() returns the vector M*v.

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
.B arg1, arg2
are at most 2 optional arguments for prodfunc and sumfunc.
M*/
/*H
	Version 1       30.08.1988      Klaus Petry
	Version 2	24.07.1991	single arg1,arg2;
					 --> obj arg1,arg2;  Th. W.
   DATE mavecmul      : 890501.910915
H*/

#include <_matr1.h>

vec mavecmul(A,x,prod,sum,anzahlargs,arg1,arg2)
matrix A;
vec    x;
obj    (*prod)(),(*sum)();
single anzahlargs;
obj    arg1, arg2;
{
	list Z;
	vec xx, y;
	obj *p10, *p11, *p20, *p21, *p30, *p31, *p40, *p41, a, b, c, h;

	bind( A, x );
	bind( arg1,arg2 );
	init( c, h, y );

/** Vorbelegung **/

	p30 = p31 = p40 = p41 = &c;

	switch( anzahlargs ) {
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
		}
	y = _0;
	while( A != _0 ) {
		for ( Z=lfirst(A), c=0, xx=x; xx!=_0;
					    xx=lred( xx ), Z=lred( Z ) ) {
			a = lfirst( Z );
			b = lfirst( xx );
			h = ( *prod )( *p10, *p20, *p30, *p40 );
			c = ( *sum )( *p11, *p21, *p31, *p41 );
			}
		y = lcomp( c, y );
		A = lred( A );
		}
	return( linv( y ) );
}
