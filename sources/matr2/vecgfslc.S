/*M
.SH NAME
vecgfslc - vector of Galois-field with single characteristic elements, linear combination

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecgfslc(p, AL, s1, s2, L1, L2)
single p;
list AL;
gfel s1,s2;
vec L1,L2;

.SH DESCRIPTION
vecgfslc() returns the linear combination (s1*V1)+(s2*V2).

.PP
.TP 4
.B p
must be prime.
.TP 4
.B AL
= (G,AL1) is the arithmetic list of GF(p^n), see gfsalgen().
.TP 4
.B s1,s2
are elements of GF(p^n).
.TP 4
.B V1,V2
are vectors over GF(p^n).
V1 and V2 must have equal length.
M*/

/*H
	Version 1       29.03.1988      J.Schmitt
	Version 2       14.12.1988      Typ vec eingefuehrt.  PS
   DATE vecgfslc      : 890501
H*/


# include <_matr2.h>

vec vecgfslc(p,AL,s1,s2,L1,L2)
single p;
list AL;
gfel s1,s2;
vec L1,L2;
{
  vec Z;
  gfel a1,a2;
  bind(AL,s1,s2,L1,L2);
  init(Z,a1,a2);
  Z=_0;
  while ( L1!=_0) {
		    a1=gfsprod(p,AL,s1,lfirst(L1));
		    a2=gfsprod(p,AL,s2,lfirst(L2));
		    a1=gfssum(p,Al,a1,a2);
		    L1=lred(L1);
		    L2=lred(L2);
		    Z=lcomp(a1,Z);
		  }
  Z=linv(Z);
  return(Z);
}
