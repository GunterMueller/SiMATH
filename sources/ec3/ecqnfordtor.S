/*M
.SH NAME
ecqnfordtor - elliptic curve over quadratic number field, order of
torsion group

.SH SYNOPSIS
.nf
#include<_ec3.h>

single ecqnfordtor(E)
list E;

.SH DESCRIPTION
ecqnfordtor() returns the order of the torsion group of E(K). If the
torsion group is not yet computed, it will be computed and stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over a
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       19.08.1998      S. Schmitt
   DATE ecqnfordtor   : 980830
H*/


#include <_ec3.h>

ecqnfordtor( E )
list E;
{
    if( lthird( lfourth( E ) ) == _0 )
    {
	/*   Torsionsgruppe noch nicht berechnet   */
    
        list L;

        bind( E );
	init( L );

        L = ecqnftorgr( E );
    }

    return( lfirst( lthird( lfourth( E ) ) ) );
}
