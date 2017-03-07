/*M
.SH NAME 
eqisnfa6 - elliptic curve over quadratic number field with integral 
coefficients, short normal form, a6

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfa6(E)
list   E;

.SH DESCRIPTION
eqisnfa6() returns the coefficient a6 of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfa6() computes 
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
   DATE eqisnfa6     : 980812  
H*/

# include <_ec2.h>

#include <_ec2.h>

nfel eqisnfa6( E )
list E;
{
    if( lthird(E)==_0 
	|| lfirst( lthird( E ) ) == _0 )
    {
	/*   Koeffizient A6 der kWNF noch nicht in E  */
    
	nfel a4;

	bind( E );
        init( a4 );

	a4 = eqisnfa4( E );
    }

    return( lsecond( lfirst( lthird( E ) ) ) );
}   
