/*M
.SH NAME
vecitovecmi - vector of integers to vector of modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecitovecmi(m, V)
int m;
vec V;

.SH DESCRIPTION
vecitovecmi() returns the vector V with all entries converted to
elements of Z/mZ.

.PP
.TP
.B V
is a vector of integers.
M*/




/*H
	Version 1       26.05.89        J.Schmitt
	Version 2	30.12.90	J.Schmitt
					Aufrufparameter vertauscht.
   DATE vecitovecmi   : 891101.900101
H*/
#include <_matr1.h>

vec vecitovecmi( M, V )
int M;
vec V;
{
	int el;
	vec W;
	init(W,el);
	bind(M,V);

	W = _0;
	while ( V != _0 ) {
		el = lfirst(V);
		V  = lred(V);
		el = mihom(M,el);
		W  = lcomp(el,W);
	}
	W = linv(W);
	return(W);
}
