/*M
.SH NAME
lm2sprod - list modulo 2 scalar product

.SH SYNOPSIS
.nf
#include<_arith1.h>

single lm2sprod(A)
list A;

.SH DESCRIPTION
lm2sprod() returns bitwise scalar product
of all singles in the list A, i.e. A is
interpreted as a vector over Z/2Z with length 30 * llength(A).
M*/
/*H
	Version 1	20.10.1995	Marc Conrad
   DATE lm2sprod      : 951201
H*/
#include <_arith1.h>

single lm2sprod(X, Y)
        list X, Y;
        {
        single s, z;
        s = 0;
        while( X != _0 ) {
                z = lfirst(X) & lfirst(Y);
                X = lred(X);
                Y = lred( Y );

                while( z ) {
                        if( 1 & z ) s ^= 1;
                        z = z >> 1;
                        }
                }
        return( s );
        }
