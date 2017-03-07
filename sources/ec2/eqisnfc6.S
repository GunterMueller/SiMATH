/*M
.SH NAME 
eqisnfc6 - elliptic curve over quadratic number field with integral 
coefficients, short normal form, c6

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfc6(E)
list   E;

.SH DESCRIPTION
eqisnfc6() returns the Tate value c6 of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfc6() computes 
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
   DATE eqisnfc6     : 980815  
H*/

# include <_ec2.h>

nfel eqisnfc6( E )
list E;
{
    if( lthird(E)==_0
	|| lthird( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4, c6   */
	/*   sind noch nicht berechnet        */

        bind( E );

	eqisnfc4( E );
    }

    return( lsecond( lthird( lthird( E ) ) ) );
}   
