/*M
.SH NAME
vecmslc - vector of modular singles, linear combination

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec vecmslc(m, s1, s2, V1, V2)
single m, s1, s2;
vec V1, V2;

.SH DESCRIPTION
vecmslc() returns the linear combination (s1*V1)+(s2*V2).

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
	Version 1       23.12.1987      J.Schmitt
	Version 2       10.02.1988      neu: msprod    J.Schmitt
	Version 3       14.12.1988      Typ vec eingefuehrt.
					lcinv durch linv ersetzt. PS
   DATE vecmslc       : 890501.9203__
H*/


# include <_matr1.h>

vec vecmslc(m,s1,s2,L1,L2)
single s1,s2,m;
vec L1,L2;
{
  vec Z;
  single a1,a2;
  bind(L1,L2);
  init(Z);
  Z=_0;
  while ( L1!=_0) {
		    a1=msprod(m,s1,lfirst(L1));
		    a2=msprod(m,s2,lfirst(L2));
		    a1=mssum(m,a1,a2);
		    L1=lred(L1);
		    L2=lred(L2);
		    Z=lcomp(a1,Z);
		  }
  Z=linv(Z);
  return(Z);
}
