/*M
.SH NAME 
ecrpnorm - elliptic curve over rational numbers, point normalization
                                                                     
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

list ecrpnorm(P1);  
list P1;
                                                                     
.SH DESCRIPTION
.TP 4 
.B P1
= ( x y z )
  int x, y, z;
  defines the point P on the elliptic curve E.
.PP
ecrpnorm computes the normalization P' = ( x' y' z' ) of the point P, where
.PP
 for z = 0 : P' = ( 0 : 1 : 0 ) , P point at infinity,
 for z != 0 : z' >= 0  , and
              z' minimal;  x', y', z' integer. 
.PP
ecrpnorm returns P' as list ( x' y' z' ).
                                                                
M*/      

/*H
	Version 1       17.12.1992	Josef Gebel
	Version 2       14.02.1994	'mshom' d. 'mihom' ersetzt. JG
   DATE ecrpnorm      : 930531.941201
H*/

#include <_ec1.h>

list ecrpnorm( P  )
list P;
{
    bind( P );
    
    if( ispecrpai( P ) )
    {
	/*   Test: z = 0 (2. Normierungsregel, 1. Fall).  */
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
	    /*   1. Normierungsregel ist verletzt */
	    z = ineg( z );
	    y = ineg( y );
        }
        
        if( z != 1 )
        {
	    /*   Vielleicht 2. Normierungsregel (2. Fall) verletzt  */

	    int h;
	    init( h );

	    h = igcd( x, z );
    
	    if( h != 1 )
	    {
	        h = igcd( y, h );
	        if( h != 1 )
	        {
	            /*   2. Normierungsregel (2. Fall) ist verletzt  */
		    single e;
		    int p, q, k;
		    list L;

		
		    init( p, q, k );
		    init( L );
   
		    L = ifact( h );
		    L = ifel ( L );

		    while( L != _0 )
		    {
		        p = lfirst ( L );
		        e = lsecond( L );
		        q = iexp( p, e );
		        while( e )
		        {
		            k = iprod( q, q );
		            h = iprod( k, q );
		            if( !mihom( k, x ) && !mihom( h, y ) )
		            {
			        /* x durch q^2, y durch q^3 teilbar */
		                x = iquot( x, k );
		                y = iquot( y, h );
		                z = iquot( z, q );
			        break;
		            }
			    e--;
			    q = iquot( q, p );
		        }
		        L = lred2( L );
		    }
	        }
            }
        }
        return( list3( x, y, z ) );
    }
}
