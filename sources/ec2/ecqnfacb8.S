/*M
.SH NAME
ecqnfacb8 - elliptic curve over quadratic number field, actual model,
Tate value b8

.SH SYNOPSIS
.nf
#include<_ec2.h>

nfel ecqnfacb8(E)
list E;

.SH DESCRIPTION
ecqnfacb8() returns the Tate value b8 of the elliptic curve E. If b8 is
not yet computed, it will be computed together with b2, b4, and b6 and
stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
   DATE ecqnfacb8     : 931130
H*/

#include<_ec2.h>

nfel ecqnfacb8( E ) 
list E;
{
    if( lsecond( lfirst( E ) ) == _0 ) 
    {
	int b2;
        
	bind( E );
	init( b2 );

	b2 = ecqnfacb2( E );
    }

    return( lfourth( lsecond( lfirst( E ) ) ) );
}
