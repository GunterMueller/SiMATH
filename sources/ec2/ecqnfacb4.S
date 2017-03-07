/*M
.SH NAME
ecqnfacb4 - elliptic curve over quadratic number field, actual model,
Tate value b4

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfacb4(E)
list E;

.SH DESCRIPTION
ecqnfacb4() returns the Tate value b4 of the elliptic curve E. If b4 is
not yet computed, it will be computed together with b2, b6, and b8 and
stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfacb4     : 931130
H*/

#include<_ec2.h>

nfel ecqnfacb4( E ) 
list E;
{
    if( lsecond( lfirst( E ) ) == _0 ) 
    {
	int b2;
        
	bind( E );
	init( b2 );

	b2 = ecqnfacb2( E );
    }

    return( lsecond( lsecond( lfirst( E ) ) ) );
}
