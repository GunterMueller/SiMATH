/*M
.SH NAME
vecmssprod - vector of modular singles, scalar product

.SH SYNOPSIS
.nf
#include<_matr1.h>

single vecmssprod(m, U, V)
single m;
vec U, V;

.SH DESCRIPTION
vecmssprod() returns the scalar product U*V.

.PP
.TP 4
.B U, V
are vectors over Z/mZ.
U and V must have equal length.
M*/




/*H
	Version 1       28.04.1988      R.Boeffgen
	Version 2       14.12.1988      Typ vec eingefuehrt und Darstellung
					des Nullvektors als Liste aus
					Nullen beruecksichtigt.  PS
	Version 3	24.03.1991	Modul nicht mehr unbedingt prim.  PS
   DATE vecmssprod    : 890501.920331
H*/


# include <_matr1.h>

single vecmssprod( p, V, W )
single p;
vec V,W;
{
	single  s=0, v, w;
	do {
	      v=lfirst(V), V=lred(V);
	      w=lfirst(W), W=lred(W);
	      s = mssum( p, msprod(p,v,w), s );
	}
	while (V != _0);
	return( s );
}
