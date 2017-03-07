/*M
.SH NAME
qnfsum - quadratic number field element sum

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfsum( D, a, b )  
int D; 
nfel a, b;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a, b
are elements of K ( for representation of number field elements s. fputnfel ).
.PP 
qnfsum returns an element of K, say c, where
.IP
c = a + b.

.SH SEE ALSO
fputnfel            

M*/
                     
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfsum        : 931130
H*/

#include <_arith2.h>

nfel qnfsum( D, a, b )
int D;
nfel a, b;
{
    bind( D, a, b );

    /*** 1.Fall: a = 0 oder b = 0  ***/
    
    if( !a )
    {
        return( b );
    }
    if( !b )
    {
        return( a );
    }

    /*** 2.Fall: a != 0 und b != 0 ***/
    
    else
    {
	int c1, aN, bN;
	
	init( c1, aN, bN );

        aN = lfirst( a );
        bN = lfirst( b );

	if( lsecond( a ) )
	{
	    /***   a = [a1 + a2 * D^(1/2)]/aN in Q(D^(1/2))\Q    ***/

	    int c2;
	    init( c2 );

	    c1 = iprod( bN, lfourth( a ) );
	    c2 = iprod( bN, lthird ( a ) );

	    if( lsecond( b ) )
	    {
	        /***   b = [b1 + b2 * D^(1/2)]/bN in Q(D^(1/2))\Q   ***/

	        c1 = isum( c1, iprod( aN, lfourth( b ) ) );
	        c2 = isum( c2, iprod( aN, lthird ( b ) ) );
          	
	        return( qnfminrep( D, list4( iprod( aN, bN ), 1, c2, c1 ) ) );
	    }
	    else
	    {
	        /***   b = b1/bN in Q    ***/
	        
	        c1 = isum( c1, iprod( aN, lthird( b ) ) );
	        
	        return( qnfminrep( D, list4( iprod( aN, bN ), 1, c2, c1 ) ) );
            }
	}
	else
	{
	    /***   a = a1/aN in Q    ***/
	    
	    c1 = iprod( bN, lthird( a ) );

	    if( lsecond( b ) )
	    {
	        /***   b = [b1 + b2 * D^(1/2)]/bN in Q(D^(1/2))\Q   ***/

	        int c2;
	        init( c2 );

	        c1 = isum ( c1, iprod( aN, lfourth( b ) ) );
	        c2 = iprod( aN, lthird( b ) );
	
	        return( qnfminrep( D, list4( iprod( aN, bN ), 1, c2, c1 ) ) );
	    }
	    else
	    {
	        /***   b = b1/bN in Q    ***/
	        
	        c1 = isum( c1, iprod( aN, lthird( b ) ) );
          	
	        return( qnfminrep( D, list3( iprod( aN, bN ), 0, c1 ) ) );
	    }
        }
    }
}
