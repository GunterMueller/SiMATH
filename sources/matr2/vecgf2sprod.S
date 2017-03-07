/*M
.SH NAME
vecgf2sprod - vector over Galois-field of characteristic 2, scalar product

.SH SYNOPSIS
.nf
#include<_matr2.h>

vec vecgfsprod(G, U, V)
obj G; 
vec U, V;

.SH DESCRIPTION
vecgf2sprod() returns the scalar product U*V.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).
.TP 4
.B U,V
are vectors over GF(2^n).
M*/



/*H
	Version 1	02.06.1995 	E.Herrmann
   DATE vecgf2sprod   : 951201
H*/

# include <_matr2.h>

gf2el vecgf2sprod( G, V, W)
obj G;
vec V,W;
{
        gf2el s,v,w;
        bind(G,V,W);
        init(s,v,w);

        s=0;
        while ( V != _0 ) {
                v=lfirst(V), V=lred(V);
                w=lfirst(W), W=lred(W);
                s = gf2sum(G,gf2prod(G,v,w),s);
        }
        return( s );
}
