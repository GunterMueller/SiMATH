/*M
.SH NAME
qnfpihom - quadratic number field prime ideal homomorphism

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfpihom(D, P, pi, z, b)  
int D; 
list P; 
nfel pi, b; 
single z;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
. B P
is a prime ideal in the ring of integers, say O_K, of K. P is the extension of a prime number p on K. (for the representation of ideals s. qnfidprod).
.TP 4
.B pi 
is a locally uniformizing parameter of P.
.TP 4
.B z
 = 0, for p inertial in K,
 = 1, for p ramified in K,
 = 2, for p split in K.
.TP 4
.B b
is an element of O_K (for the representation of number field elements s. fputnfel).
.PP
Let w be D^(1/2),      for D = 2 or 3 mod 4,
      or (1 + D^(1/2))/2,   for D = 1 mod 4.
.PP
Then {1, w} is an integral basis of O_K.
.PP
qnfidhom returns a representative of b mod P in the residual system R (say), where
.PP
R = {0, 1, ..., p-1}, for p split or ramified,
  = {x + y * w | x, y in {0, ..., p-1}, for p inertial.

.SH SEE ALSO
 qnfidprod
 fputnfel

M*/
                                    
/*H
        Version 1	22.06.1990      Josef Gebel und Claude Grasser
   DATE qnfpihom      : 931130
H*/

#include <_arith2.h>

nfel qnfpihom( D, P, pi, z, a )
int    D;
list   P;
nfel   pi, a;
single z;
{
    if( !a )
    {
	return( 0 );
    }
    else
    {
        int n, x, y, p;

        init( n, x, y, p );
        bind( D, P, pi, a );
  
	if( z )
	{
	    /*   p verzweigt oder zerlegt: P = [ 1, p * s, x, s ]   */
            p = lsecond( P );
            p = isquot( p, lfourth( P ) );
        }
	else
	{
	    /*   p traege: P = [ p, s, x, s ]                       */
            p = lfirst( P );
        }
    
        n = lfirst( a );
        
        if( lsecond( a ) )
        {
	    x = lfourth( a );
	    y = lthird ( a );
        }
        else
        {
	    x = lthird( a );
	    y = 0;
        }

        if( m4hom( D ) == 1 )
        {
	    /***   GHB:	{1, w} mit w = [1+(D^(1/2)]/2.    ***/
	    /***   Berechne Koordinaten von a und pi in   ***/
	    /***   GHB-Darstellung                        ***/
	    if( ( p == 2 ) && m4hom( n ) 
	    || mihom( p, n ) || isqnfiel( D, a ) )
	    {
	        int u;
	        init( u );
	        x = idif( x, y );
    
	        if( mshom( 2, n ) )
	        {
		    y = isum( y, y );
	        }
	        else
	        {
	            x = iquot( x, 2 );
                    n /= 2;
	        }
	        /***   Ab jetzt: a = x + y * w   ***/

		x = mihom( p, x );
		y = mihom( p, y );
		u = miinv( p, n );
		x = miprod( p, x, u );
		y = miprod( p, y, u );

	        if( z )
	        {
	            /***   p zerlegt oder verzweigt     ***/
		    /***   Restsystem: {0, 1,..., p-1}  ***/

	            int v;
	            init( v );
	    
    	            if( lsecond( pi ) )
                    {
	                u = lfourth( pi );
	                v = lthird ( pi );
                    }
                    else
                    {
	                u = lthird( pi );
	                v = 0;
                    }
	            u = idif( u, v );
            
	            if( lfirst( pi ) == 2 )
	            {
	                u = iquot( u, 2 );
	            }
	            else
	            {
		        v = isum( v, v );
	            }
	            /***   Ab jetzt: pi = u + v * w   ***/

		    u = mihom( p, u );
		    v = mihom( p, v );

		    if( y )
		    {
		        y = miquot( p, y, v );
		        y = miprod( p, y, u );
		        x = midif ( p, x, y );
                    }

		    if( x ) 
		    {
			return( list3( 1, 0, x ) );
		    }
		    return( 0 );
	        }
	        else
	        {
		    /***   p traege. Restsystem:                 ***/
		    /***   {0, 1,..., p-1} x {0, 1,..., p-1} w   ***/
                 
		    x = isprod( x, 2 );
		    x = isum ( x, y );

                    if( x || y )
		    {
			return( qnfminrep( D, list4( 2, 1, y, x ) ) );
		    }
		    return( 0 );
	        }
	    }
	    else
	    {
		/***   p | n und p zerlegt    ***/

		x = idif( x, y );
		y = isum( y, y );

		y = iprod( y, y );
		y = iprod( y, D );
		y = idif( iprod( x, x ), y );

		x = isum ( x, x );
		n = iprod( x, n );

		x = igcd( n, y );

		n = iquot( n, x );
		y = iquot( y, x );
		n = miinv( p, n );
		x = miprod( y, n );
		if( x )
		{                
		    return( list3( 1, 0, x ) );
		}
                return( 0 );
	    }
        }
	else
	{
	    /***   GHB:	{1, w}  mit w = D^(1/2)  ***/

            if( mihom( p, n ) )
            {
	        /***    p traege, p verzweigt oder      ***/
	        /***    (p zerlegt und (p, n) = 1)      ***/
	        /***    Diese Faelle sind alle analog   ***/
	    
	        x = mihom( p, x );
		y = mihom( p, y );
    
                if( lsecond( a ) )
                {
                    /***   a in O_P \ Z   ***/
            
		    if( n != 1 )
                    {
                        /***   a = [a1 + a2*D^(1/2)]/2          ***/
                        /***   ==>  x = a1 * n^(-1) mod p       ***/
                        /***        y = a2 * n^(-1) mod p       ***/

		        n = miinv ( p, n );
                        x = miprod( p, x, n );
                        y = miprod( p, y, n );
                    }
                 
	            if( z )
	            {
		        /***   p verzweigt oder zerlegt:      ***/
		        /***   Restsystem {0, 1,..., p-1 }   ***/

		        /***    a mod P = x + y * D^(1/2)           ***/
		        /***    Um a mod P in Z zu erreichen,       ***/
		        /***    wird y * pi von a mod P abgezogen   ***/
		        /***    d.h.  mit pi = u + v*D^(1/2) wird   ***/
		        /***       y <-- 0 und  x <-- x - y * u     ***/

		        if( y )
		        {
		            y = iprod( y, lfourth( pi ) );
                        }

			if( isign( lthird( pi ) ) == 1 )
			{
		            x = mihom( p, idif( x, y ) );
			}
			else
			{
		            x = mihom( p, isum( x, y ) );
			}

		        if( x )
		        {
                            return( list3( 1, 0, x ) );
		        }
		        return( 0 );
		    }
		    else
		    {
		        /***   p traege. Restsystem:                 ***/
		        /***   {0, 1,..., p-1} x {0, 1,..., p-1} w   ***/

		        if( y )
		        {
			    return( list4( 1, 1, y, x ) );
		        }
		        if( x )
		        {
			    return( list3( 1, 0, x ) );
		        }
		        return( 0 );
	     	    }
                }
	        else
	        {
                    /***   a in Z <= Q(D^(1/2)) (insbes. n = 1)   ***/
	               
		    if( x )
	            {
		        return( list3( n, 0, x ) );
		    }
		    return( 0 );
	        }
            }
            else
            {
	        /***   p zerlegt und p | n            ***/
		/***   Restsystem {0, 1,..., p-1 }   ***/
        
	        y = iprod( y, y );
	        y = iprod( y, D );
	        y = idif( iprod( x, x ), y );
    
	        n = iprod( n, 2 );
                n = iprod( n, x );
        
	        x = igcd( y, n );
	        y = iquot( y, x );
	        n = iquot( n, x );
	        n = mihom( p, n );
	        n = miinv( p, n );
	        x = miprod( p, n, y );
	        
	        if( x )
	        {
	            return( list3( 1, 0, x ) );
	        }
	        return( 0 );
            }
        }
    }
}
