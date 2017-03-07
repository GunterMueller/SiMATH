/*M
.SH NAME
magf2trace - matrix over Galois field of characteristic 2, trace

.SH SYNOPSIS
.nf
#include<_matr2.h>

obj magf2trace(G, M)
obj G;
matrix M;

.SH DESCRIPTION
magf2trace() returns the trace of the matrix M.

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z,
generating the Galois-field GF(2^n).
.TP 4
.B M
is a square matrix over GF(2^n).
M*/



/*H
	Version 1	07.06.1995	E.Herrmann
   DATE magf2trace    : 951201
H*/

#include <_matr2.h>

obj magf2trace(G, M)
obj G;
matrix M;
{
        single i,j;
        list Z1;
        obj S;
        bind( G, M);
        init( S);
                
        S = 0;
        i = 0;
        while ( M != _0 ) {
                i++;
                Z1 = lfirst(M);
                M  = lred(M);
                for(j=1;j<i;j++) Z1=lred(Z1);
                S = gf2sum( G, S, lfirst(Z1));
        }
        return(S);
}
