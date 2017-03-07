/*M
.SH NAME
vecmisprod - vector of modular integers, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

int vecmisprod(M, U, V)
int M;
vec U, V;

.SH DESCRIPTION
vecmisprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors over Z/mZ.
U and V must have equal length.
M*/




/*H
	Version 1       24.07.91	J.Schmitt
   DATE vecmisprod    : 910915
H*/


# include <_matr1.h>

int vecmisprod(M,V,W)
int M;
vec V,W;
{
	int s,v,w;
	bind(M,V,W);
        init(s,v,w);

	s=0;
	do {
		v = lfirst(V);
		V = lred(V);
		w = lfirst(W);
		W = lred(W);
	        s = misum(M,miprod(M,v,w),s);
	} while ( V != _0 );
	return(s);
}
