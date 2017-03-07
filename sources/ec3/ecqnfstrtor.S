/*M
.SH NAME
ecqnfstrtor - elliptic curve over quadratic number field, structure of
torsion group

.SH SYNOPSIS
.nf
#include<_ec3.h>

list ecqnfstrtor(E)
list E;

.SH DESCRIPTION
ecqnfstrtor() returns the list ST = (t) or ST = (t1 t2) if the torsion group
of E(K) is cyclic or bicyclic, respectively. The order of the torsion group
of E(K) is t or t1*t2. If the torsion group is not yet computed, it will be 
computed and stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over a
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       19.08.1998      S. Schmitt
   DATE ecqnfstrtor   : 980830
H*/

#include <_ec3.h>

list ecqnfstrtor( E )
list E;
{
    list T;
  
    bind(  E );

    if( ( lthird( lfourth( E ) ) == _0 )
    ||  ( lsecond( lthird( lfourth( E ) ) ) == _0 ) )
    {
	/*   Struktur der Torsionsgruppe noch nicht berechnet   */

        init( T );
	T = ecqnfgentor( E );
    }

    return( lsecond( lthird( lfourth( E ) ) ) );
}
