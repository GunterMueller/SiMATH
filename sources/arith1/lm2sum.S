/*M
.SH NAME
lm2sum - list of singles modulo 2 sum (exclusive or)

.SH SYNOPSIS
.nf
#include<_arith1.h>

list lm2sum(A,B)
list A,B;

.SH DESCRIPTION
lm2sum() returns A ^ B, i.e. the bitwise exclusive or
of the two lists A and B, which must have the equal length. 
M*/
/*H
	Version 1	20.10.1995	Marc Conrad
   DATE lm2sum        : 951201
H*/
#include <_arith1.h>

single lm2sum(X, Y)
        list X, Y;
        {
	list Z; 
	
	bind(X, Y); 
	init( Z ); 

	Z = _0; 

        while( X != _0 ) {
                Z = lcomp( lfirst(X) ^ lfirst(Y), Z); 
                X = lred(X);
                Y = lred( Y );
                }
        return( linv(Z) );
        }
