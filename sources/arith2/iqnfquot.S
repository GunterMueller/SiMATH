/*M
.SH NAME
iqnfquot - integer, quadratic number field element, quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel iqnfquot(D, a, b)  
int D, a; 
nfel b;
  
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an integer number.
.TP 4
.B b
is an element of K (for representation of number field elements s. fputnfel).
.PP 
iqnfquot returns ERROR, if b = 0, and an element of K, say c, where
.IP
c = a / b, else.

.SH SEE ALSO
fputnfel

M*/
                                              
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE iqnfquot      : 931130
H*/

#include <_arith2.h>

nfel iqnfquot( D, a, b )
int D, a;
nfel b;
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
	int h;
	init( h );

	h = iprod( a, lfirst( b ) );         /***   h = a * bN   ***/

	if( lsecond( b ) )
	{
	    /***   b = [b1 + b2 * D^(1/2)]/bN in Q(D^(1/2))\Q    ***/

	    /***    a     b1 * bN * a - b2 * bN * a * D^(1/2)    ***/
	    /***   --- = -------------------------------------   ***/
	    /***    b             b1^2 - b2^2 * D                ***/

	    int cN, c1, c2;
	    init( cN, c1, c2 );

	    c1 = lfourth( b );
	    c2 = lthird ( b );
       
	    cN = iprod(  D, c2  );
	    cN = iprod( cN, c2  );
	    cN = idif ( iprod( c1, c1 ), cN ); /* cN = b1^2 - b2^2 * D */
	    
	    c2 = ineg( iprod( c2, h ) );
	    c1 = iprod( c1, h );

	    return( qnfminrep( list4( cN, 1, c2, c1 ) ) );
	}
	else
	{
	    /***   b = b1/bN in Q  ==>  a/b = (a * bN) / b1   ***/
	    
	    return( qnfminrep( list3( lthird( b ), 0, h ) ) );
        }
    }
}
