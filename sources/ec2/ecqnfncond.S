/*M
.SH NAME
ecqnfncond - elliptic curve over quadratic number field, norm of 
conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfncond(E)
list E;

.SH DESCRIPTION
ecqnfncond() returns the norm of the conductor of the elliptic curve E. 
If the norm of the conductor is not yet computed, it will be computed 
and stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.11.1995      Josef Gebel
   DATE ecqnfncond    : 951201
H*/

#include<_ec2.h>

int ecqnfncond( E ) 
list E;
{
    bind( E );

    if( lsecond( lfourth( E ) ) == _0 )  
    {
        /*   Der Fuehrer von E/K ist noch nicht berechnet   */

        list L;
				 
        init( L );

	L = ecqnfcond( E );
    }

    return( lthird( lsecond( lfourth( E ) ) ) );
}
