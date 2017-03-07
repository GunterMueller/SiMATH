/*M
.SH NAME
ecqnfacdisc - elliptic curve over quadratic number field, actual model,
discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfacdisc(E)
list E;

.SH DESCRIPTION
ecqnfacdisc() returns the discriminant of the elliptic curve E. If the
discriminant is not yet computed, it will be computed and stored in E. 
The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfacdisc   : 931130
H*/

#include<_ec2.h>

nfel ecqnfacdisc( E ) 
list E;
{
    if( lfourth( lfirst( E ) ) == _0 ) 
    {
        /*   Die Diskriminante ist noch nicht berechnet   */

        nfel b2, b4, b6, b8, DC, h;
	int DF;
        list L;
				 
        bind( E );

        init( L );
	init( DF );
        init( b2, b4, b6, b8, DC, h );

        b2 = ecqnfacb2( E );
        b4 = ecqnfacb4( E );
        b6 = ecqnfacb6( E );
        b8 = ecqnfacb8( E );
	DF = ecqnfflddisc( E );

	DC = qnfiprod( DF, b4,  9 );
        DC = qnfprod ( DF, b6, DC );
        h  = qnfprod ( DF, b2, b8 );
        DC = qnfdif  ( DF, DC,  h );
        DC = qnfprod ( DF, DC, b2 );	/** -b2^2b8 + 9b2b4b6 **/

        h  = qnfsquare( DF, b6 );
        h  = qnfiprod( DF,  h, 27 );
        DC = qnfdif  ( DF, DC,  h );

        h  = qnfexp  ( DF, b4,  3 );
        h  = qnfiprod( DF,  h,  8 );
        DC = qnfdif  ( DF, DC,  h );

	L = lfirst( E );
	leset( L, 4, list4( DC, _0, 0, _0 ) );
	leset( E, 1, L );

	return( DC );
    }

    return( lfirst( lfourth( lfirst( E ) ) ) );
}
