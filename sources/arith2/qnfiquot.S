/*M
.SH NAME
qnfiquot - quadratic number field element, integer, quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfiquot( D, a, b )  
int D, b; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an element of K (for representation of number field elements s. fputnfel).
.TP 4
.B b
is an integer number.
.PP                
qnfiquot returns ERROR for b = 0, else an element of K, say c, where
.IP
c = a / b (as number field elements).

.SH SEE ALSO
fputnfel

M*/
                                                               
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfiquot      : 931130
H*/

#include <_arith2.h>

nfel qnfiquot( D, a, b )
int D, b;
nfel a;
{
    bind( D, a, b );

    /*** 1. Fall: b = 0  ***/
    
    if( !b )
    {
        return( ERROR );
    }

    /*** 2. Fall: a = 0  ***/
    
    if( !a )
    {
        return( 0 );
    }

    /*** 3. Fall: a != 0 und b != 0 ***/
    
    else
    {
	int N;
	init( N );
	    
	N = iprod( lfirst( a ), b );

	if( lsecond( a ) )
	{
	    /***   a = [a1 + a2 * D^(1/2)]/aN in Q(D^(1/2))\Q    ***/

	    return( qnfminrep( D, list4( N, 1, lthird( a ), lfourth( a ) ) ) );
	}
	else
	{
	    /***   a = a1/aN in Q    ***/
	    
	    return( qnfminrep( D, list3( N, 0, lthird( a ) ) ) );
        }
    }
}
