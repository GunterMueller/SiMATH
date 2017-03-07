/*M
.SH NAME
mailllred - matrix of integers, LLL reduction

.SH SYNOPSIS
.nf
#include<_arith2.h>

matrix mailllred(B)  
matrix B;
  
.SH DESCRIPTION
.TP 4
.B B
is an n x n matrix over Z with n > 0, such that the rows of B form n over Z linearly independent vectors in Z^n.
.PP
mailllred returns an LLL reduced matrix whose rows generate the same Z-module as the rows of B, or 0 in case of an error occurs. 

.SH SEE ALSO
Literature: B. de Weger: "Algorithms for Diophantine
            Equations", Dissertation, Centrum voor
            Wiskunde en Informatica, Amsterdam 1987.

M*/
                                      
/*H
	Version 1	08.08.1991	Josef Gebel
   DATE mailllred     : 941201
H*/

#include<_arith2.h>

matrix mailllred( B )
matrix B;
{
    matrix T;

    init( T );
    bind( B );
  
    T = mailllredtm( B );

    if( T )
    {
        return( maiprod( T, B ) );
    }
    return( 0 );
}
