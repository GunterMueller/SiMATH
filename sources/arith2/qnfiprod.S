/*M
.SH NAME
qnfiprod - quadratic number field element, integer, product

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfiprod( D, a, b )  
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
qnfiprod returns an element of K, say c, where
.IP
c = a * b (as number field elements).

.SH SEE ALSO
fputnfel

M*/
                           
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfiprod      : 931130
H*/

#include <_arith2.h>

nfel qnfiprod( D, a, b )
int D, b;
nfel a;
{
    /*** 1.Fall: a = 0 oder b = 0  ***/
    
    if( !a || !b )
    {
        return( 0 );
    }

    /*** 2.Fall: a != 0 und b != 0 ***/
    
    else
    {
	int c1;
	init( c1 );
	
        bind( D, a, b );

	c1 = iprod( b, lthird( a ) );

	if( lsecond( a ) )
	{
	    /***   a = [a1 + a2 * D^(1/2)]/aN in Q(D^(1/2))\Q    ***/

	    int c2;
	    init( c2 );

	    c2 = iprod( b, lfourth( a ) );

	    return( qnfminrep( D, list4( lfirst( a ), 1, c1, c2 ) ) );
	}
	else
	{
	    /***   a = a1/aN in Q    ***/
	    
	    return( qnfminrep( D, list3( lfirst( a ), 0, c1 ) ) );
        }
    }
}
