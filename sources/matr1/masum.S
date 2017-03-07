/*M
.SH NAME
masum - matrix sum

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix masum(M, N, sumfunc, numargs, arg1, arg2)
matrix M, N;
obj (*sumfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
masum() returns the matrix M+N.

.PP
.TP 4
.B M, N
are matrices over a certain ring R.
M and N must have equal dimensions.
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
	Version 1       27.10.1988      Klaus Petry
	Version 2	24.07.1991	single arg1, arg2;
					 -->  obj arg1,arg2;  Th. W.
   DATE masum         : 890501.910915
H*/

#include <_matr1.h>

matrix masum(M,N,sum,anzahlargs,arg1,arg2)
matrix M,N;
obj    ( *sum )();
single anzahlargs;
obj    arg1,arg2;
{
	list ZM, ZN, ZL;
	obj *p10, *p20, *p30, *p40, c, a, b;
	matrix L;

	bind( M, N );
	bind( arg1,arg2 );
	init( L, ZL, c );

	/** Vorbelegung **/

	p30 = p40 = &c;

	switch( anzahlargs ) {
		case 0: p10 = &b;               /** Z, Q **/
			p20 = &a;
			break;
		case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr, nf(s) **/
			p20 = &a;
			p30 = &b;
			break;
		case 2: p10 = &arg1;            /** Pms, gfs **/
			p20 = &arg2;
			p30 = &a;
			p40 = &b;
			break;
		}
	L = _0;
	while( M != _0 ) {
		ZL = _0;
		ZM = lfirst( M );
		ZN = lfirst( N );

/* addiere zeilenweise */

		while( ZM != _0 ) {
			a = lfirst( ZM );
			ZM = lred( ZM );
			b = lfirst( ZN );
			ZN = lred( ZN );
			c = ( *sum )( *p10, *p20, *p30, *p40 );
			ZL = lcomp( c, ZL );
			}
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		M = lred( M );
		N = lred( N );
		}
	return( linv( L ) );
}
