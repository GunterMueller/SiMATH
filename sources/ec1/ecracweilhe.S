/*M
.SH NAME
ecracweilhe - elliptic curve over the rational numbers, Weil height

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecracweilhe(E1, P1)  
list E1, P1;

.SH DESCRIPTION
.TP 4
.B E1 
is a list containing the data of the elliptic curve E/Q, as descripted in the  
documentation of 'ecrinit'.
.TP 4
.B P1
is a list of three integers, defining the point P on the minimal model ( as restricted typ, i.e. a1', a3' = 0 or 1, a2' = -1, 0, 1.) of the elliptic curve E.
.PP
ecracweilhe computes the Weil height of the point P.

.SH SEE ALSO
ecrinit

J.H. Silverman: Math. of Comp., 51, 1988, p.339-358.

M*/

/*H
        Version 1       19.03.1993      Josef Gebel
	Version 1.1	21.11.2000	S. Schmitt (Fehler: vor Berechnung
							kuerzen)
   DATE ecracweilhe   : 930531
H*/

#include <_ec1.h>

floating ecracweilhe( E, P )
list E, P;
{
    if( ispecrpai( P ) )
    {
	/*   P = unendlich ferner Punkt ==> h( P ) = 0   */
	return( 0 );
    }
    else
    {
        floating f, g;
	rat X;
        int x, z;
    
        bind( E, P );
        init( f, g );
        init( X, x, z );
    
        x = iabs( lfirst( P ) );
        z = lthird( P );
    
        if( x )
        {
	    z = iprod(z,z);
	    X = rcons(x,z);
	    x = lfirst(X);
	    z = lsecond(X);
            f = fllog( itofl( x ) );
            g = fllog( itofl( z ) );
            if( flcomp( f, g ) > 0 )
            {
	        return( f );
            }
            return( g );
        }

	/* Hier: x=0 */
        g = fllog( itofl( z ) );
        g = flsum( g, g );
        return( g );
    }
}
