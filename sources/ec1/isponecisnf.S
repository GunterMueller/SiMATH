/*M 
.SH NAME
isponecisnf - is point on elliptic curve with integer coefficients, model in short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

single isponecisnf(E1, P1)
list E1, P1(x, y, z);
int x, y, z;

.SH DESCRIPTION
isponecimin returns 1, if the point P lies on the model representing the
elliptic curve E/Q in short Weierstrass normal form, 
and 0 else.                                                                     
.TP 4                                                                           
.B P1                                                                           
defines for z != 0 the point P = (x/z^2, y/z^3 ),                               
    and for z = 0 the point  at infinity                                        
of the elliptic curve E/Q.                                                      
.TP 4                                                                           
.B E1                                                                           
defines the elliptic curve E, as descripted in the documentation of 'ecrinit'.  

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE isponecisnf   : 930531
H*/	

#include <_ec1.h>

single isponecisnf( E, P )
list E, P;
{
    if( !ispecrpai( P ) )
    {
        int x, y, z, h;

        bind( E, P );

        init( x, y, z, h );

        x = lfirst ( P ); 
        y = lsecond( P ); 
        z = lthird ( P );
    
        y = iprod( y, y );                /* y^2                 */
        h = iprod( x, x );
        h = iprod( h, x );                /* x^3                 */
        h = idif ( h, y );                /* x^3 - y^2           */
    
        y = iprod( z, z );                /* z^2                 */
        z = iprod( y, y );                /* z^4                 */
        y = iprod( y, ecisnfa6( E ) );    /* A6 z^2              */
        x = iprod( x, ecisnfa4( E ) );    /* A4 x                */
        y = isum ( y, x );                /* A4 x + A6 z^2       */
        y = iprod( y, z );                /* A4 x z^4 + A6 z^6   */
        h = isum ( h, y );  /* x^3 + A4 x z^4 + A6 z^6 - y^2     */
    
        if( h )
        {
            return( 0 );
        }
    }
    
    return( 1 );
}   
