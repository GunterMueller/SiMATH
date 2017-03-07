/*M
.SH NAME
vecgfssprod - vector of Galois-field with single characteristic elements, scalar product

.SH SYNOPSIS
.nf
#include<_matr2.h>

gfel vecgfssprod(p, AL, U, V)
single p;
list AL;
vec U,V;

.SH DESCRIPTION
vecgfssprod() returns the scalar product U*V.

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B U,V
are vectors over GF(p^n).
U and V must have equal length.
M*/
/*H
	Version 1       01.07.1988      J.Schmitt
	Version 2       01.09.1988      Darstellung des Nullvektors als
					Liste aus Nullen beruecksichtigt.
					J.Schmitt
	Version 3       14.12.1988      Typ vec eingefuehrt.  PS
   DATE vecgfssprod   : 890501
H*/


# include <_matr2.h>

gfel vecgfssprod(p,AL,V,W)
single p;
list AL;
vec V,W;
{
	gfel s,v,w;
	bind(AL,V,W);
	init(s,v,w);

	s=0;
	while ( V != _0 ) {
		v=lfirst(V), V=lred(V);
		w=lfirst(W), W=lred(W);
		s = gfssum(p,AL,gfsprod(p,AL,v,w),s);
	}
	return( s );
}
