/*M
.SH NAME
maneg - matrix negation

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix maneg(M, negfunc, numargs, arg1, arg2)
matrix M;
obj (*negfunc)();
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
maneg() returns the matrix -M.

.PP
.TP 4
.B M
is a matrix of objects.
.TP 4
.B negfunc
is a function to negate a single element of the matrix.
This function is given the element and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by negfunc.
.TP 4
.B arg1, arg2
are at most 2 optional arguments for negfunc.
M*/



/*H
	Version 1       27.10.1988      Klaus Petry
	Version 2       11.11.1988      Klaus Petry
	Version 3	24.07.1991	single arg1,arg2;
					 -- >  obj arg1,arg2;  Th. W.
   DATE maneg         : 890501.910915
H*/

#include <_matr1.h>

matrix maneg(M,neg,anzahlargs,arg1,arg2)
matrix M;
obj    ( *neg )();
single anzahlargs;
obj    arg1,arg2;
{
	matrix N;
	list ZM, ZN, ZL;
	obj *p10, *p20, *p30, a;
	matrix L;

	bind( M );
	bind( arg1,arg2 );
	init( N, ZN );

/*** Vorbelegung ***/

	p20 = p30 = &a;

	switch( anzahlargs ) {
		case 0: p10 = &a;               /** Z, Q **/
			break;
		case 1: p10 = &arg1;            /** Z/mZ, Pi, Pr, nf(s) **/
			p20 = &a;
			break;
		case 2: p10 = &arg1;            /** Pms, gfs **/
			p20 = &arg2;
			p30 = &a;
			break;
		}

/*** Negation ***/

	N = _0;
	while( M != _0 ) {
		ZM = lfirst( M );
		ZN = _0;
		while( ZM != _0 ) {
			a = lfirst( ZM );
			ZM = lred( ZM );
			a = (*neg)( *p10, *p20, *p30 );
			ZN = lcomp( a, ZN );
			}
		ZN = linv( ZN );
		N = lcomp( ZN, N );
		M = lred( M );
		}
	return( linv( N ) );
}
