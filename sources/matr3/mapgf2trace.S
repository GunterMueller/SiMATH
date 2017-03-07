/*M
.SH NAME
mapgf2trace - matrix of polynomials over Galois-field of characteristic 2, trace 

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol mapgf2trace(r, G, M)
single r;
obj G;
matrix M;

.SH DESCRIPTION
mapgf2trace() returns the trace of the matrix M.
.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B M
is a matrix in (GF(2^n)[x_1,...,x_r])^(i,j).
M*/
/*H
	Version 1	19.06.1995 	E.Herrmann
   DATE mapgf2trace   : 951201
H*/

#include <_matr3.h>

pol mapgf2trace( r, G, M)
single r;
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
                S = pgf2sum(r,G,S,lfirst(Z1));
        }
        return(S);
}



