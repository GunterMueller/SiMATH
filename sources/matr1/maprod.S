/*M
.SH NAME
maprod - matrix product

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprod(M, N, prodfunc, sumfunc, numargs, arg1, arg2)
matrix M, N;
obj (*prodfunc)(), (*sumfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
maprod() returns the matrix M*N.

.PP
.TP 4
.B M, N
are matrices over a certain ring R.
M and N must have compatible dimensions.
.TP 4
.B prodfunc, sumfunc
are multiplication and addition functions for the ring R.
These functions are given two elements and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by prodfunc and sumfunc.
.TP 4
.B arg1, arg2
are at most 2 optional arguments for prodfunc and sumfunc.
M*/

/*H
	Version 1       27.10.1988      Klaus Petry
	Version 2	24.07.1991	single arg1,arg2;
					 -->  obj arg1,arg2;  Th. W.
   DATE maprod        : 890501.910915
H*/

#include <_matr1.h>

matrix maprod(M,N,prod,sum,anzahlargs,arg1,arg2)
matrix M, N;
obj    ( *prod )(),( *sum )();
single anzahlargs;
obj    arg1,arg2;
{
	list ZM, ZMT, ZN, ZL;
	obj *p10, *p11, *p20, *p21, *p30, *p31, *p40, *p41, c, h, a, b;
	matrix L, NT;

	bind( M, N );
	bind( arg1,arg2 );
	init( L, ZL, NT, h, c );

/** Vorbelegung **/

	p30 = p31 = p40 = p41 = &c;

	switch( anzahlargs ) {
		case 0: p10 = &b;               /** Z, Q **/
			p20 = &a;
			p21 = &h;
			p11 = &c;
			break;
		case 1: p10 = p11 = &arg1;      /** Z/mZ, Pi, Pr, nf(s) **/
			p20 = &a;
			p30 = &b;
			p21 = &c;
			p31 = &h;
			break;
		case 2: p10 = p11 = &arg1;      /** Pms, gfs **/
			p20 = p21 = &arg2;
			p30 = &a;
			p40 = &b;
			p31 = &c;
			p41 = &h;
			break;
		}

/* berechnet wird M*N. N wird transponiert, damit auf die Spalten von N */
/* direkter Zugriff besteht. N wird von unten nach oben durchlaufen.    */

	L = _0;
	N = mactransp( N );
	NT = linv( N );
	while( M != _0 ) {
		ZMT = lfirst( M );
		N = NT;
		ZL = _0;
		while( N != _0 ) {
			ZM = ZMT;
			ZN = lfirst( N );
			c = 0;
			while( ZM != _0 ) {
				a = lfirst( ZM );
				ZM = lred( ZM );
				b = lfirst( ZN );
				ZN = lred( ZN );
				h = ( *prod )( *p10, *p20, *p30, *p40 );
				if ( h == ERROR ) /** bei Polynomen **/
					return( ERROR );
				c = ( *sum )( *p11, *p21, *p31, *p41 );
				}
			ZL = lcomp( c, ZL );
			N = lred( N );
			}
		L = lcomp( ZL, L );
		M = lred( M );
		}
	return( linv( L ) );
}
