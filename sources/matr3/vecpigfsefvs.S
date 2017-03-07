/*M
.SH NAME
vecpigfsefvs - vector of polynomials over integers, Galois-field with single characteristic element, evaluation first variable, special version

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecpigfsefvs(r, p, AL, V)
single r,p;
list AL;
vec V;

.SH DESCRIPTION
vecpigfsefvs() returns the vector V with the first
variable of its variable list replaced by the
generating element of the finite field GF(p^n) determined by AL.
The result is a vector of polynomials in r-1
variables over this finite field.
 
.PP
.TP 4
.B p
>2, must be prime.
.TP 4
.B AL
is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B V
is a vector of polynomials in r variables over integers.
M*/



/*H
	Version 1	03.06.93	S.Schmitt
   DATE vecpigfsefvs  : 931130
H*/


#include <_matr3.h>

vec vecpigfsefvs(r,p,AL,V)
single r,p;
list AL;
vec V;
{	vec W;
	obj k;
	init( W, k );
	bind( AL, V );

	W=_0;
	while(V!=_0)
	{	k=lfirst(V);
		V=lred(V);
		k=pigfsevalfvs(r,p,AL,k);
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


