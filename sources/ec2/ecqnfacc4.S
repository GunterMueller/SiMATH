/*M
.SH NAME
ecqnfacc4 - elliptic curve over quadratic number field, actual model,
Tate value c4

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfacc4(E)
list E;

.SH DESCRIPTION
ecqnfacc4() returns the Tate value c4 of the elliptic curve E. If c4 is
not yet computed, it will be computed together with c6 and stored in E. 
The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfacc4     : 931130
H*/

#include<_ec2.h>

nfel ecqnfacc4( E ) 
list E;
{
    if( lthird( lfirst( E ) ) == _0 ) 
    {
	nfel b2, b4, b6, c4, c6, h, D;
	list L;
        
	bind( E );
	init( b2, b4, b6, c4, c6, h, D );
	init( L );

	b2 = ecqnfacb2( E );
	b4 = ecqnfacb4( E );
	b6 = ecqnfacb6( E );
	D  = ecqnfflddisc( E );

	c4 = qnfiprod( D, b4, 24 );
	h  = qnfsquare( D, b2 );
	c4 = qnfdif( D, h, c4 );
	
	c6 = qnfiprod( D, b4, 36 );
	h  = qnfsquare( D, b2 );
	c6 = qnfdif( D, c6, h );
	c6 = qnfprod( D, c6, b2 );
	h  = qnfiprod( D, b6, 216 );
	c6 = qnfdif( D, c6, h );

	L = lfirst( E );
	leset( L, 3, list2( c4, c6 ) );
	leset(  E, 1, L );

	return( c4 );
    }

    return( lfirst( lthird( lfirst( E ) ) ) );
}
