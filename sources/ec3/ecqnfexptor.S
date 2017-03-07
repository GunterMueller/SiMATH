/*M
.SH NAME
ecqnfexptor - elliptic curve over quadratic number field, exponent of
torsion group

.SH SYNOPSIS
.nf
#include<_ec3.h>

single ecqnfexptor(E)
list E;

.SH DESCRIPTION
ecqnfexptor() returns the exponent e of the torsion group of E(K), i.e.
e is the minimum of all natural numbers n, such that n*T = O for all
torsion points T in E(K). If the torsion group is not yet computed, it will 
be computed and stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over a
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       19.08.1998      S. Schmitt
   DATE ecqnfexptor   : 980830
H*/

#include <_ec3.h>

ecqnfexptor( E )
list E;
{
    if( lthird(lfourth(E))==_0 ||
	lsecond( lthird( lfourth( E ) ) ) == _0 )
    {
	/*   Exponent der Torsionsgruppe noch nicht berechnet   */

        list T;
  
        bind(  E );
        init( T );

	T = ecqnfgentor( E );
    }

    return( lfirst( lsecond( lthird( lfourth( E ) ) ) ) );
}
