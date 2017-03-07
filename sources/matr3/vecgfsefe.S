/*M
.SH NAME
vecgfsefe - vector over Galois-field with single characteristic, embedding in field extension

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecgfsefe(p, ALm, V, g)
single p;
list ALm;
vec V;
gfel g;

.SH DESCRIPTION
vecgfsefe() returns the vector V over GF(p^n)
embedded in the field extension GF(p^m) where
n is a proper divisor of m.

.PP
.TP 4
.B p
>2, must be prime.
.TP 4
.B ALm
is the arithmetic list of GF(p^m), see gfsalgen().
.TP 4
.B g
is a sparse polynomial in one variable over Z/pZ.
Using the isomorphic embedding of GF(p^n) in GF(p^m)
found by gfsalgenies(), g corresponds to the image
of the separable generator of GF(p^n) over GF(p).

.SH SEE ALSO
gfsalgen, gfsalgenies
M*/






/*H
	Version  1      18.05.1993      S.Schmitt
   DATE vecgfsefe     : 931130
H*/
 
#include <_matr3.h>

vec vecgfsefe( p,ALm,V,g )
single p;
list ALm;
vec V;
gfel g;
{ 	vec W;
	obj a;
	init(W, a);
	bind(ALm,V,g);

	W=_0;
	while(V!=_0)
	{	a=lfirst(V);
		a=gfsefe(p,ALm,a,g);
		W=lcomp(a,W);
		V=lred(V);
	}
	W=linv(W);	
	return(W);
}


