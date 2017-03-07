/*M
.SH NAME 
eqisnfb2 - elliptic curve over quadratic number field with integral 
coefficients, short normal form, b2

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfb2(E)
list   E;

.SH DESCRIPTION
eqisnfb2() returns the Tate value b2 of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfb2() computes 
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
   DATE eqisnfb2     : 980815  
H*/

# include <_ec2.h>

nfel eqisnfb2( E )
list E;
{
    if( lthird(E)==_0 
	|| lsecond( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen b2, b4, b6, b8   */
	/*   sind noch nicht berechnet                */

        nfel a4, a6, b4, b6, b8;
        list L, M;
	int d;
        
        bind( E );

        init( a4, a6, b4, b6, b8 );
        init( L, M, d );

	a4 = eqisnfa4( E );
	a6 = eqisnfa6( E );

	d = ecqnfflddisc(E);

        /*   Berechnung von b2, b4, b6, b8 (b2 = 0 immer)   */
	b4 = qnfsum( d, a4, a4 );
	b6 = qnfiprod( d, a6, 4 );
	b8 = qnfprod(d,a4,a4);
	b8 = qnfneg(d,b8);

	M = list4( itonf(0), b4, b6, b8 );
    
	/*   Eintragen der Werte b2,  b4,  b6,  b8.   */
	L = lthird( E );
	leset( L, 2, M );
	leset( E, 3, L );
    }

    return( lfirst(lsecond(lthird(E))) );
}   
