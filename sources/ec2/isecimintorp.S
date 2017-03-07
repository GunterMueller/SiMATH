/*M
.SH NAME
isecimintorp - is torsion point on elliptic curve with integer coefficients, minimal model

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isecimintorp(E, PL)  
list E, PL;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.
.TP 4
.B PL
= (x y z) is a list of three integers, defining the point P = (x/z^2, y/z^3) on E/Q.
.PP
isecimintorp returns
.IP
 1, if P is a torsion point on E/Q,
 0, else.

.SH SEE ALSO
 ecrinit
 Literature: J.H. Silverman: The arithmetic of elliptic 
                             curves.

M*/
     
/*H
        Version 1   	19.09.1992      Josef Gebel
   DATE isecimintorp  : 930531
H*/

#include <_ec2.h>

isecimintorp( E, P )
list E, P;
{
    bind(  E, P );

    if( lthird( lfourth( E ) ) == _0 )
    {
	floating flh;

	init( flh );

	flh = eciminnetahe( E, P );
	if( flh )
	{
	    /*    h( P ) > 0 ==> P kein Torsionspunkt   */
	    return( 0 );
	}

	/*   else: P Torsionspunkt    */
	return( 0 );
    }
    else
    {
        single t;
	list Q;

	init( Q );

	t = ecrexptor( E );

	Q = eciminmul( E, P, t );

        if( ispecrpai( Q ) )
        {
	    /*    t * P = ( 0 : 1 : 0 ) ==> P Torsionspunkt   */
	    return( 1 );
        }
	
        /*   P kein Torsionspunkt    */
        return( 0 );
    }
}
