/*M
.SH NAME 
eqisnfa4 - elliptic curve over quadratic number field with integral 
coefficients, short normal form, a4

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfa4(E)
list   E;

.SH DESCRIPTION
eqisnfa4() returns the coefficient a4 of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfa4() computes 
the transformation of E to the sWnf and stores the transformation in the
curve E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       12.08.1998      S. Schmitt
   DATE eqisnfa4     : 980812  
H*/

# include <_ec2.h>

nfel eqisnfa4( E )
list E;
{
    if( lthird(E)==_0 
	|| lfirst( lthird( E ) ) == _0 )
    {
	/*   Koeffizienten des Modells in kurzer Weierstrass-   */
	/*   Normalform noch nicht berechnet.                   */

        list L;
     
        bind( E );

        init( L );

	L = ecqnfbtsnf( E );
	
	/** die a4s und a6s sind in E eingetragen **/

	/*   Eintragen der Koeffizienten a4s und a6s in E   */
	L = lfirst(lthird( E ));

	return( lfirst( L ) );
    }
    
    return( lfirst( lfirst( lthird( E ) ) ) );
}   
