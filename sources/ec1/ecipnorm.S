/*M

.SH NAME
ecipnorm - elliptic curve with integer coefficients, point normalization

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecipnorm(P1)  
list P1;

.SH DESCRIPTION
ecipnorm returns the unique normalization of the point P as a list (x' y' z'),
where :
.P
1. z' >= 0
.P
2. gcd(x, z) = gcd(y, z) = 1.
.TP 4
.B P1 = (x, y, z) int x, y, z
defines the point P on the elliptic curve E/Q with integer coefficients. 

M*/

/*H 
	Version 1       17.12.1992 	Josef Gebel (neues Konzept)
   DATE ecipnorm      : 930531
H*/

#include <_ec1.h>

list ecipnorm( P  )
list P;
{
    bind( P );
    if( ispecrpai( P ) )
    {
	return( list3( 0, 1, 0 ) );
    }
    else
    {
        int x, y, z;

        init( x, y, z );

        x = lfirst ( P );
        y = lsecond( P );
        z = lthird ( P );
        
        if( isign( z ) < 0 )
        {
	    /*   1. Normierungsregel  */
	    z = ineg( z );
	    y = ineg( y );
        }
        
        if( z != 1 )
        {
	    /*   2. Normierungsregel (2. Fall) vielleicht verletzt */
    
            int h, k;
    
            init( h, k );
    	
	    if( x )
	    {
	        k = iprod( z, z );
	        h = igcd ( x, k );
	        
		if( h != 1)
	        {
		    k = isqrt( h );
	        
	            x = iquot( x, h );     /*   x <-- x/k^2   */
		    z = iquot( z, k );     /*   z <-- z/k     */
	            h = iprod( h, k );     /*   h <-- k^3     */
	            y = iquot( y, h );     /*   y <-- y/k^3   */
	        }
            }
	    else if( y )
	    {
	        k = iprod( z, z );
	        k = iprod( k, z );
	        h = igcd ( iabs( y ), k );
    
	        if( h != 1 )
	        {
                    single l;
		    k = iroot( h, 3, &l );
	        
		    z = iquot( z, k );     /*   z <-- z/k     */
	            y = iquot( y, h );     /*   y <-- y/k^3   */
	            k = iprod( k, k );     /*   k <-- k^2     */
	            x = iquot( x, k );     /*   x <-- x/k^2   */
                }
            }
	    else
	    {
	        /*   P = ( 0 , 0 ) ==>  P --> ( 0  0  1 )   */
	        return( list3( 0, 0, 1 ) );
	    }
        }

        return( list3( x, y, z ) );
    }
}
