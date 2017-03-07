/*M
.SH NAME
machpol - matrix characteristic polynomial

.SH SYNOPSIS
.nf
#include<_matr1.h>

pol machpol(M, detfunc, minusone, numargs, arg1, arg2)
matrix M;
obj (*detfunc)(), minusone;
single numargs;
obj arg1, arg2;

.SH DESCRIPTION
machpol() returns the characteristic polynomial of the matrix M,
which is a polynomial in a new variable X.
It is calculated as Det(M-X*E).

.PP
.TP 4
.B M
is a matrix over a certain ring R.
.TP 4
.B detfunc
is a function to calculate the determinant of the matrix M-X*E.
This function is given M-X*E and the additional arguments.
.TP 4
.B minusone
is the element representing -1 in the ring R.
.TP 4
.B numargs
is the number of additional arguments actually used by detfunc.
.TP 4
.B arg1, arg2
are at most 2 optional arguments for detfunc.
M*/

/*H
	Version 1       31.10.1988      Klaus Petry
	Version 2	24.07.1991	single arg1,arg2;
					 -->  obj arg1,arg2;  Th. W.
   DATE machpol       : 890501.910915
H*/

#include <_matr1.h>

pol machpol(M,det,minusEins,anzahlargs,arg1,arg2)
matrix M;
obj    (*det)(), minusEins;
single anzahlargs;
obj    arg1,arg2;
{
	list ZM, ZL;
	obj a;
	pol b, D;
	matrix L = _0;
	single i=0, j=0;

	bind (M, L, minusEins);
	bind (arg1, arg2);
	init (ZL);

	while( M != _0 ) {
		ZL = _0;
		ZM = lfirst( M );
		while( ZM != _0 ) {
			a = lfirst( ZM );
			b = (i==j++)?((a)?list4(1,minusEins,0,a)
					 :list2(1,minusEins))
				    :((a)?list2(0,a)
					 :0);
			ZL = lcomp( b, ZL );
			ZM = lred( ZM );
			}
		i++; j=0;
		ZL = linv( ZL );
		L = lcomp( ZL, L );
		M = lred( M );
		}
	L = linv( L );
	switch (anzahlargs) {
		case 0: D = (*det) (1, L);          /* taucht nicht auf */
			break;
		case 1: D = (*det) (arg1, L);       /* Z, Q, MS, Pi, Pr, nf(s) */
			break;
		case 2: D = (*det) (arg1, arg2, L); /* Pms, gfs */
			break;
		}
	return( D );
}
