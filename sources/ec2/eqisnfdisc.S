/*M
.SH NAME 
eqisnfdisc - elliptic curve over quadratic number field with integral 
coefficients, short normal form, discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfdisc(E)
list   E;

.SH DESCRIPTION
eqisnfdisc() returns the discriminant of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfdisc() computes 
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
   DATE eqisnfdisc     : 980815  
H*/

# include <_ec2.h>

nfel eqisnfdisc( E )
list E;
{
    if( lthird(E)==_0
	|| lfourth( lthird( E ) ) == _0 )
    {
	/*   Die Diskriminante ist noch nicht berechnet   */

        nfel a4, a6, Dis;
        list L;
	int d;

        bind( E );

        init( L );
        init( a4, a6, Dis, d );

	a4 = eqisnfa4( E );
	a6 = eqisnfa6( E );

	d = ecqnfflddisc(E);

	Dis  = qnfprod(d, a4, a4);
	a4 = qnfprod(d, Dis, a4);
	a4 = qnfiprod(d, a4, 4); /*          4 * A4^3                */
	
	a6 = qnfprod(d, a6, a6);
	a6 = qnfiprod(d, a6, 27); /*                     27 * A6^2    */

	Dis  = qnfsum ( d, a4, a6 ); /*         4 * A4^3 + 27 * A6^2    */
	Dis  = qnfiprod( d, Dis, -16 ); /* -16 * ( 4 * A4^3 + 27 * A6^2 )  */
	
	L  = lthird( E );
	leset ( L, 4, list4( Dis, _0, 0, _0 ) );
	leset ( E, 3, L );

	return( Dis );
    }

    return( lfirst( lfourth( lthird( E ) ) ) );
}   
