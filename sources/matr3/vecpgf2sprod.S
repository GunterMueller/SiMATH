/*M
.SH NAME
vecpgf2sprod - vector of polynomials over Galois-field of characteristic 2, scalar product 

.SH SYNOPSIS
.nf
#include<_matr3.h>

pol vecpgf2sprod(r, G, V, W)
single r;
obj G; 
vec V, W;

.SH DESCRIPTION
vecpgf2sprod() returns the scalar product of V and W.
.PP
.TP 4
.B r
is the number of variables used in the polynomials.
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z.
.TP 4
.B  V, W
are vectors in (GF(2^n)[x_1,...,x_r])^m.
M*/

/*H
	Version 1	02.06.1995 	E.Herrmann
   DATE vecpgf2sprod  : 951201.960501
H*/

#include <_matr3.h>

pol vecpgf2sprod( r, G, V, W )
single r;
obj G;
vec  V, W;
{
    pol s, v, w;

    bind( G, V, W );
    init( s, v, w );

    s = 0;
    while ( V != _0 )
    {
       v = lfirst( V ), V = lred( V );
       w = lfirst( W ), W = lred( W );
       s = pgf2sum( r, G, pgf2prod( r, G, v, w ), s );
    }
    return( s );
};



