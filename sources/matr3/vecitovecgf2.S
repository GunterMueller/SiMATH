/*M
.SH NAME
vecitovecgf2 - vector over integers to vector over Galois-field with characteristic 2  

.SH SYNOPSIS
.nf
#include<_matr3.h>

vec vecitovecgf2(V) 
vec V;

.SH DESCRIPTION
vecitovecgf2() returns the vector V represented as a vector over GF(2^n).
.PP
.TP 4
.B V
is a vector in Z^m.
M*/

/*H
	Version 1	29.02.96	S.Schmitt
   DATE vecitovecgf2  : 960501
H*/

#include <_matr3.h>

vec vecitovecgf2(V)
vec V;
{	vec W;
	obj k;
	init(W,k);
	bind(V);

	W=_0;
	while(V!=_0)
	{	k=lfirst(V);
		V=lred(V);
		k=mshom(2,k);
		if(k) 
		{	k=list2(0,k);
			k=udpm2tosb(k);
		}
		W=lcomp(k,W);
	}
	W=linv(W);
	return(W);
}


