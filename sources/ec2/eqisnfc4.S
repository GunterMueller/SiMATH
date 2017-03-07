/*M
.SH NAME 
eqisnfc4 - elliptic curve over quadratic number field with integral 
coefficients, short normal form, c4

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfc4(E)
list   E;

.SH DESCRIPTION
eqisnfc4() returns the Tate value c4 of the short Weierstrass normal form
of the curve E. If the sWnf of E is not yet computed, eqisnfc4() computes 
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
   DATE eqisnfc4     : 980815  
H*/

# include <_ec2.h>

nfel eqisnfc4( E )
list E;
{
    if( lthird(E)==_0 
	|| lthird( lthird( E ) ) == _0 )
    {
	/*   Die Tate'schen Groessen c4 und c6        */
	/*   sind noch nicht berechnet                */

        nfel a4, a6, c4, c6;
        list L, M;
	int d;
        
        bind( E );

        init( a4, a6, c4, c6 );
        init( L, M,d );

	a4 = eqisnfa4( E );
	a6 = eqisnfa6( E );

	d = ecqnfflddisc(E);

        /*   Berechnung von c4 und c6.   */

	c4 = qnfiprod(d,a4,48);
	c4 = qnfneg(d,c4);
	c6 = qnfiprod(d,a6,864);
	c6 = qnfneg(d,c6);

	M = list2( c4, c6 );
    
	/*   Eintragen der Werte c4, c6.   */
	L = lthird( E );
	leset( L, 3, M );
	leset( E, 3, L );
    }

    return( lfirst( lthird( lthird( E ) ) ) );
}   
