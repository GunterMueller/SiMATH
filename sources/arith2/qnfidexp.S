/*M
.SH NAME
qnfidexp - quadratic number field ideal exponentiation

.SH SYNOPSIS
.nf
#include<_arith2.h>

list qnfidexp( D, A, e )  
int D; 
list A; 
single e;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)). 
.TP 4
.B A
is an ideal in the ring of integers O_K of the field K (for representation of ideals s. qnfidprod).
.PP
qnfidexp returns the ideal B (say), where
.IP
B = A * ... * A ( e times).

.SH SEE ALSO
qnfidprod

M*/
                           
/*H
        Version 1	14.10.1993      Josef Gebel
   DATE qnfidexp      : 931130
H*/

#include <_arith2.h>

list qnfidexp( D, A, e )
int    D; 
list   A;
single e;
{
    bind( D, A );

    if( !lfirst( A ) ||  isqnfidone( D, A )  ||  ( e == 1 ) )
    {
	/***   A ist das Nullideal, das Eins-Ideal oder   ***/
	/***   e = 1: In allen Faellen gilt: A^e = A.     ***/
	return( A );
    }
    else
    {
	single f;
	list   B, C;

	init( B, C );

	B = qnfidone( D );
	C = A;
	f = e;

	while( f )
	{
	    if( f & 01 )
	    {
		B = qnfidprod( D, B, C );
	    }
	    f >>= 1;
	    if( f )
	    {
	        C = qnfidsquare( D, C );
	    }
	}
	
	return( B );
    }
}
