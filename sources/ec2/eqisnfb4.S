/*M
.SH NAME 
eqisnfb4 - elliptic curve over quadratic number field with integral 
coefficients, short normal form, b4

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfb4(E)
list   E;

.SH DESCRIPTION
eqisnfb4() returns the Tate value b4 of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfb4() computes 
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
   DATE eqisnfb4     : 980815  
H*/

# include <_ec2.h>

nfel eqisnfb4( E )
list E;
{
    if( lthird(E)==_0
	|| lsecond( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        bind( E );

	eqisnfb2( E );
    }

    return( lsecond( lsecond( lthird( E ) ) ) );
}   
