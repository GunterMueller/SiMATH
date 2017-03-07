/*M
.SH NAME
vecmilc - vector of modular integers linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecmilc(m, s1, s2, V1, V2)
int m, s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecmilc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B s1,s2
are elements of Z/mZ.
.TP 4
.B V1,V2
are vectors over Z/mZ.
V1 and V2 must have equal length.
M*/
/*H
	Version 1       25.07.91	J.Schmitt
   DATE vecmilc       : 910915
H*/

# include <_matr1.h>

vec vecmilc(M,s1,s2,L1,L2)
int M,s1,s2;
vec L1,L2;
{
	int a1,a2;
	vec Z;
	bind(M,s1,s2,L1,L2);
	init(a1,a2,Z);

	Z=_0;
	while ( L1!=_0) {
		a1=miprod(M,s1,lfirst(L1));
		a2=miprod(M,s2,lfirst(L2));
		a1=misum(M,a1,a2);
		L1=lred(L1);
		L2=lred(L2);
		Z=lcomp(a1,Z);
	}
	Z=linv(Z);
	return(Z);
}
