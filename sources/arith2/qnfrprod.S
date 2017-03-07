/*M
.SH NAME
qnfrprod - quadratic number field element, rational number, product

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfrprod( D, a, b )  
int D; 
nfel a; 
rat b;
 
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
is a rational number.
.PP
qnfrprod returns an element of K, say c, where
.IP
c = a * b  ( as number field elements).

.SH SEE ALSO
fputnfel

M*/
                       
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfrprod      : 931130
H*/

#include <_arith2.h>

nfel qnfrprod( D, a, b )
int D;
nfel a; 
rat b;
{
    bind( D, a, b );

    /*** 1.Fall: a = 0 oder b = 0  ***/
    
    if( !a || !b )
    {
        return( 0 );
    }

    /*** 2.Fall: a != 0 und b != 0 ***/
    
    else
    {
	int a1, aN;
	
	init( a1, aN );

        aN = lfirst ( a );
	aN = iprod( aN, rden( b ) );
		
	if( lsecond( a ) )
	{
	    /***   a = [a1 + a2 * D^(1/2)]/aN in Q(D^(1/2))\Q    ***/

	    int a2;
	    init( a2 );

	    a1 = lfourth( a );
	    a2 = lthird ( a );

	    a1 = iprod( a1, rnum( b ) );
	    a1 = iprod( a2, rnum( b ) );

	    return( qnfminrep( list4( aN, 1, a2, a1 ) ) );
	}
	else
	{
	    /***   a = a1/aN in Q    ***/
	    
	    a1 = lthird ( a );
	    a1 = iprod( a1, rnum( b ) );
	    
	    return( qnfminrep( list3( aN, 0, a1 ) ) );
        }
    }
}
