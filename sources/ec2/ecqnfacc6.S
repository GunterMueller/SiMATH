/*M
.SH NAME
ecqnfacc6 - elliptic curve over quadratic number field, actual model,
Tate value c6

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfacc6(E)
list E;

.SH DESCRIPTION
ecqnfacc6() returns the Tate value c6 of the elliptic curve E. If b4 is
not yet computed, it will be computed together with c4 and stored in E. 
The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfacc6     : 931130
H*/

#include<_ec2.h>

nfel ecqnfacc6( E ) 
list E;
{
    if( lthird( lfirst( E ) ) == _0 ) 
    {
	nfel c4;
        
	bind( E );
	init( c4 );

	c4 = ecqnfacc4( E );
    }

    return( lsecond( lthird( lfirst( E ) ) ) );
}
