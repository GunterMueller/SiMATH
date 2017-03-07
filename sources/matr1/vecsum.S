/*M
.SH NAME
vecsum - vector sum

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecsum(U, V, sumfunc, numargs, arg1, arg2)
vec U, V;
obj (*sumfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
vecsum() returns the vector U+V.

.PP
.TP 4
.B U, V
are vectors over a certain ring R.
U and V must have equal length.
.TP 4
.B sumfunc
is an addition function for the ring R.
This function is given the two elements to add and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by sumfunc.
.TP 4
.B arg1, arg2
are at most 2 optional arguments for sumfunc.
M*/
/*H
	Version 1       25.08.1988      Klaus Petry
	Version 1.2     15.03.1989      U. Schneiders
	Version 2	24.07.1991	single arg1,arg2;
					 --> obj arg1,arg2;  Th. W.
   DATE vecsum        : 890601.910915
H*/

#include <_matr1.h>

vec vecsum(U,V,sum,anzahlargs,arg1,arg2)
vec    U,V;
obj    ( *sum )();
single anzahlargs;
obj    arg1, arg2;
{
	vec W;
	obj *p10, *p20, *p30, *p40, u, v, w;

	bind( U, V );
	bind( arg1,arg2 );
	init( W, u, v, w );

/** Vorbelegung **/

	p30 = p40 = &u;

	switch( anzahlargs ) {
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
		}

/*** Addition   ***/

	W = _0;
	while( U != _0 ) {
		u = lfirst( U );
		v = lfirst( V );
		w = ( *sum )(*p10, *p20, *p30, *p40);
		W = lcomp( w, W );
		U = lred( U );
		V = lred( V );
		}
	return( linv( W ) );
}
