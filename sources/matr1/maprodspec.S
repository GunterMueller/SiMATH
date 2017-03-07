/*M
.SH NAME
maprodspec - matrix product, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maprodspec(M, N, prodfunc, sumfunc, numargs, arg1, ..., arg5)
matrix M, N;
obj (*prodfunc)(), (*sumfunc)();
single numargs;
obj arg1, ..., arg5;

.SH DESCRIPTION
maprodspec() returns the matrix M*N.

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
.B arg1, ..., arg5
are at most 5 optional arguments for prodfunc and sumfunc.
M*/
/*H
	Version 1       04.04.1990	Th. Weis
   DATE maprodspec    : 910915
H*/

#include <_matr1.h>

matrix maprodspec(M,N,prod,sum,anzahlargs,arg1,arg2,arg3,arg4,arg5)
matrix M,N;
obj    ( *prod )(),( *sum )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5;
{
	list ZL, ZM, ZMT, ZN;
	matrix L, NT;
	obj *p10, *p11, *p20, *p21, *p30, *p31, *p40, *p41;
	obj *p50, *p51, *p60, *p61, *p70, *p71, a, b, c, h;

	bind( M, N );
	bind( arg1,arg2,arg3,arg4,arg5 );
	init( L, NT, ZL, ZM, ZMT, ZN, a, b, c, h );

/*** Vorbelegung ***/

	p30 = p31 = p40 = p41 = p50 = p51 = p60 = p61 = p70 = p71 = &c;

	switch ( anzahlargs )
	{
	   case 0: p10 = &b;               /** Z, Q **/
		   p20 = &a;
		   p21 = &h;
		   p11 = &c;
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

/* berechnet wird M*N. N wird transponiert, damit auf die Spalten von N */
/* direkter Zugriff besteht. N wird von unten nach oben durchlaufen.    */

	L = _0;
	N = mactransp( N );
	NT = linv( N );
	while ( M != _0 )
	{
	   ZMT = lfirst( M );
	   N = NT;
	   ZL = _0;
	   while ( N != _0 )
	   {
	      ZM = ZMT;
	      ZN = lfirst( N );
	      c = 0;
	      while ( ZM != _0 )
	      {
		 a = lfirst( ZM );
		 ZM = lred( ZM );
		 b = lfirst( ZN );
		 ZN = lred( ZN );
		 h = ( *prod )( *p10, *p20, *p30, *p40, *p50, *p60, *p70 );
		 if ( h == ERROR ) return( ERROR );   /** bei Polynomen **/
		 c = ( *sum )( *p11, *p21, *p31, *p41, *p51, *p61, *p71 );
	      }
	      ZL = lcomp( c, ZL );
	      N = lred( N );
	   }
	   L = lcomp( ZL, L );
	   M = lred( M );
	}
	return( linv( L ) );
}
