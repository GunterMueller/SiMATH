/*M
.SH NAME
qnfprod - quadratic number field element product

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfprod( D, a, b )  
int D; 
nfel a, b;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a, b
are elements of K (for representation of number field elements s. fputnfel).
.PP
qnfprod returns an element of K, say c, where
.IP
c = a * b.
  
.SH SEE ALSO
fputnfel

M*/
                               
/*H
	Version 1       24.05.1993      Josef Gebel
   DATE qnfprod       : 931130
H*/

#include <_arith2.h>

nfel qnfprod( D, a, b )
int D;
nfel a, b;
{
    bind( D, a, b );

    if( !a || !b ) 
    {
        return( 0 );
    }
    else
    {
        int a1, Nc;

        init( a1, Nc );
            
        Nc = lfirst( a );
        Nc = iprod( Nc, lfirst( b ) );

        if( lsecond( a ) )
        {   
	    int a2, c1, c2;
	    init( a2, c1, c2 );

	    a1 = lfourth( a );
	    a2 = lthird ( a );

	    /*** Im folgenden ist x = D^(1/2)  ***/

            if( lsecond( b ) )
            {
		/***   a in Q(x) \ Q   und b in Q(x) \ Q   ***/
		/***   a = a1/Na + a2/Na * x     und       ***/
		/***   b = b1/Nb + b2/Nb * x               ***/

		c1 = iprod( D, iprod( a2, lthird( b ) ) );
		c1 = isum( c1, iprod( a1, lfourth( b ) ) );
        
                c2 = iprod( a1, lthird( b ) );
		c2 = isum( c2, iprod( a2, lfourth( b ) ) );

	        return( qnfminrep( D, list4( Nc, 1, c2, c1 ) ) );
            }
            else
            {
		/***   a in Q(x) \ Q         und b in Q      ***/
		/***   a = a1/Na + a2/Na * x und b = b1/Nb   ***/
		
                c1 = iprod( a1, lthird( b ) );
		c2 = iprod( a2, lthird( b ) );
	        
	        return( qnfminrep( D, list4( Nc, 1, c2, c1 ) ) );
            }
        }
        else
        {   
	    a1 = lthird( a );

            if( lsecond( b ) )
            {
		/***   a in Q    und b in Q(x) \ Q          ***/
		/***   a = a1/Na und b = b1/Nb + b2/Nb * x  ***/

	        int c1, c2;
	        init( c1, c2 );

                c1 = iprod( a1, lfourth( b ) );
		c2 = iprod( a1, lthird ( b ) );
	        
	        return( qnfminrep( D, list4( Nc, 1, c2, c1 ) ) );
            }
            else
            {
		/***   a in Q    und b in Q      ***/
		/***   a = a1/Na und b = b1/Nb   ***/
		
	        return( qnfminrep( D, list3( Nc, 0, iprod( a1, lthird( b ) ) ) ) );
            }
        }
    }
}
