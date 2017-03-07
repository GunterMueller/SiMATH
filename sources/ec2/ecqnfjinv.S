/*M
.SH NAME
ecqnfjinv - elliptic curve over quadratic number field, j-invariant

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfjinv(E)
list E;

.SH DESCRIPTION
ecqnfjinv() returns the j-invariant of the elliptic curve E. If the
j-invariant is not yet computed, it will be computed and stored in E. 
The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfjinv     : 931130
H*/

#include<_ec2.h>

nfel ecqnfjinv( E ) 
list E;
{
    if( lfirst( lfourth( E ) ) == _0 ) 
    {
	list L;
	nfel j;

	init( j );
	init( L );
	bind( E );

	j = ecqnfacc4( E );

	if( j )
	{
	    nfel Dc;
	    int Df;

	    init( Dc );
	    init( Df );

	    Dc = ecqnfacdisc( E );
	    Df = ecqnfflddisc( E );

	    j = qnfexp ( Df, j,  3 );
	    j = qnfquot( Df, j, Dc );
	}
        
	L = lfourth( E );
	leset( L, 1, j );
	leset( E, 4, L );

	return( j );
    }

    return( lfirst( lfourth( E ) ) );
}
