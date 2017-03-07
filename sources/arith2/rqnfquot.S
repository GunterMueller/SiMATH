/*M
.SH NAME
rqnfquot - rational number, quadratic number field element, quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel rqnfquot( D, a, b )  
int D; 
rat a; 
nfel b;
     
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is a rational number.
.TP 4
.B b
is an element of K (for representation of number field elements s. fputnfel).
.PP
rqnfquot returns an element of K, say c, where
.IP
c = a/b, or
.PP
ERROR in case of b = 0.

.SH SEE ALSO
fputnfel 

M*/
             
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE rqnfquot      : 931130
H*/

#include <_arith2.h>

nfel rqnfquot( D, a, b )
int D; 
rat a; 
nfel b;
{
    bind( D, a, b );

    /*** 1.Fall: a = 0 oder b = 0  ***/
    
    if( !b )
    {
        return( ERROR );
    }
    if( !a )
    {
        return( 0 );
    }

    /*** 2.Fall: a != 0 und b != 0 ***/
    
    else
    {
	int cN, h;
	init( cN, h );

	h = rnum( a );
	h = iprod( lfirst( b ), h );

	if( lsecond( b ) )
	{
	    /***   a = a1/aN in Q und                            ***/
	    /***   b = [b1 + b2 * D^(1/2)]/bN in Q(D^(1/2))\Q    ***/

	    /***    a     a1 * b1 * bN - a1 * b2 * bN * D^(1/2)  ***/
	    /***   --- = --------------------------------------  ***/
	    /***    b         aN * (b1^2 - b2^2 * D)             ***/

	    int c1, c2;
	    init( c1, c2 );

	    c1 = lfourth( b );
	    c2 = lthird ( b );

	    cN = iprod( c2, c2 );
	    cN = iprod( cN, c2 );
	    cN = idif ( iprod( c1, c1 ), cN );

	    c1 = iprod( c1, h );
	    c2 = ineg( iprod( c2, h ) );
	    
	    return( qnfminrep( D, list4( cN, 1, c2, c1 ) ) );
	}
	else
	{
	    /***   a = a1/aN und b = b1/bN in Q        ***/
	    /***   ==>  a/b = (a1 * bN) / (aN * b1 )   ***/

	    cN = rden( a );
	    cN = iprod( cN, lthird( b ) );
	    
	    return( qnfminrep( D, list3( cN, 0, h ) ) );
        }
    }
}
