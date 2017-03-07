/*M
.SH NAME
fgetecrp - file get point on elliptic curve over rational numbers

.SH SYNOPSIS
.nf
#include<_ec1.h>

list fgetecrp(pf)  
FILE *pf;

.SH DESCRIPTION
fgetecrp reads the point P from the opened file *pf. Following representations of P can occur:
.PP
.B 1. ( X Y )  
( affine representation ) :
   rat X, Y;  or int X, Y;  ( as well as mixed )
.PP
    ( X Y ) will be transformed to 
    ( x y z )   int x, y, z;   where
    X = x/z^2 and Y = y/z^3. 
.PP
.B 2. ( x y z )
( SIMATH-specific representation ) :
   int x, y, z; where
.PP
   P = ( x/z^2, y/z^3 )                , for z != 0 
   P point at infinity: ( 0 : 1 : 0 )  , for z = 0. 
.PP
.B 3. [ x y z ] 
( projectiv representation ) :
   int x, y, z; where
.PP
   P = ( x/z, y/z )                     , for z != 0
   P point at infinity: ( 0 : 1 : 0 )   , for z = 0.
.PP
   [ x y z ] will be transformed to ( x*z  y*z^2  z ).
.PP
.PP
.B X Y 
resp. 
.B x y z 
can be separated by 
.I comma
, 
.I colon
,  
.I space 
or 
.I return
.PP
.PP
fgetecrp returns the normed ( s. 'ecrpnorm' ) list 
.PP
    ( x y z ),     or 
    ERROR          in case of an error occurs.

.SH SEE ALSO
ecrpnorm

M*/

/*H
	Version 1       17.12.1992	Josef Gebel (neues Konzept)
	Version 2       22.02.1995	Bestimmung von z im Fall
                                        xrat == 1 ... beschleunigt. JG
   DATE fgetecrp      : 930531.951201
H*/

#include <_ec1.h>

list fgetecrp( pf  )
FILE *pf;
{
    single c, xrat = 0, yrat = 0;
    list L, P;
    int x, y, z, h, k;
    rat X, Y;
    
    init( L );
    init( P );
    init( x, y, z, h, k );
    init( X, Y );

    if( ( c = fgetcs( pf ) ) == '(' )
    {
        /*   Eingabe startet mit oeffnender Klammer:  */
        /*   Eingegebener Punkt ist in affiner oder   */
        /*   in SIMATH-spezifischer Darstellung.      */
    
        if( ( X = fgetr( pf ) ) == ERROR )
        {
            return( ERROR );
        }
        if( X == 0 )
        {
	    x = 0;
	    h = 1;
        }
        else
        {
	    h = rden( X );
	    x = rnum( X );
	    if( h != 1 )
	    {
	        xrat = 1;
	    }
        }
        if( ( ( c = fgetcs( pf ) ) != ',' )  &&  ( c != ':' ) )
        {
	    ungetc( c, pf );
        }
        
        if( ( Y = fgetr( pf ) ) == ERROR )
        {
            return( ERROR );
        }
        if( Y == 0 )
        {
	    y = 0;
	    k = 1;
        }
        else
        {
	    k = rden( Y );
	    y = rnum( Y );
	    if( k != 1 )
	    {
	        yrat = 1;
	    }
        }
        
        if( ( c = fgetcs( pf ) ) != ')' )
        {
	    /*   Laenge der Eingabe > 2   */
	    if( xrat || yrat )
            {
	        /*   Mindestens eine Koordinate war vom Typ 'rat' ==>   */
	        /*   Laenge der Eingabe muss gleich 2 sein: Fehler!     */
	        return( ERROR );
            }
    
	    ungetc( c, pf );
        
            if( ( ( c = fgetcs( pf ) ) != ',' )  &&  ( c != ':' ) )
            {
	        ungetc( c, pf );
            }
            
	    if( ( z = fgeti( pf ) ) == ERROR )
            {
                return( ERROR );
            }
    
            if( ( c = fgetcs( pf ) ) != ')' )
            {
                return( ERROR );
            }
        }
        else
        {
	    if( xrat || yrat )
	    {
                int l;

                init( l );

                z = iquot( k, h );

                l = iprod( z, z );
    
                if( idif( l, h ) )
                {
                    z = 0;
                }
                else
                {
                    l = iprod( l, z );
                    if( idif( l, k ) )
                    {
                        z = 0;
                    }
                }
                if( !z )
                {
                    /*   Es gibt kein ganzes z mit h = z^2, k = z^3    */
                    /*   Konvertiere ( x/h  y/k ) nach                 */
                    /*       / x * h * k^2     y * h^3 * k^2 \         */
                    /*      | ------------- , --------------- |        */
                    /*       \ ( h * k )^2      ( h * k )^3  /         */
    
                    z = iprod( h, k );
                        
                    x = iprod( x, k );
                    x = iprod( x, z );
                        
                    y = iprod( y, h );
                    y = iprod( y, z );
                    y = iprod( y, z );
                }
            }
            else
            {
	        z = 1;
            }
        }
    }
    else if( c == '[' )
    {
	if( ( x = fgeti( pf ) ) == ERROR )
        {
            return( ERROR );
        }

        if( ( ( c = fgetcs( pf ) ) != ',' )  &&  ( c != ':' ) )
        {
	    ungetc( c, pf );
        }
    
	if( ( y = fgeti( pf ) ) == ERROR )
        {
            return( ERROR );
        }

        if( ( ( c = fgetcs( pf ) ) != ',' )  &&  ( c != ':' ) )
        {
	    ungetc( c, pf );
        }
            
	if( ( z = fgeti( pf ) ) == ERROR )
        {
            return( ERROR );
        }
        
	if( ( c = fgetcs( pf ) ) != ']' )
        {
            return( ERROR );
        }

	x = iprod( x, z );
	y = iprod( y, z );
	y = iprod( y, z );
    }
    else
    {
        return( ERROR );
    }
    
    /*   Ab hier sind x, y, z ganzzahlig mit X = x/z^2, Y = y/z^3   */
    /*   x, y, z werden gemaess den Normierungsregeln veraendert    */

    L = list3( x, y, z );

    P = ecrpnorm( L );

    return( P );
}
