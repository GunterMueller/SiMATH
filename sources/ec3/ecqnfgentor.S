/*M
.SH NAME
ecqnfgentor - elliptic curve over quadratic number field, generators of
torsion group

.SH SYNOPSIS
.nf
#include<_ec3.h>

list ecqnfgentor(E)
list E;

.SH DESCRIPTION
ecqnfgentor() returns a list (P) or (P Q) with the generators of the torsion
group of E(K) as projective points, if the torsion group is cyclic or 
bicyclic, respectively. If the torsion group is not yet computed, it will be 
computed and stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over a
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       19.08.1998      S. Schmitt
   DATE ecqnfgentor   : 980830
H*/

#include <_ec3.h>

list ecqnfgentor( E )
list E;
{
    if( ( lfifth( lfirst( E ) ) == _0 )
    ||  ( lsecond( lfifth( lfirst( E ) ) ) == _0 ) )
    {
	/*   EZS der Torsionsgruppe noch nicht berechnet   */

        list            L1, L2, L3;
	int d;
    
        bind( E );

        init( L1, L2, L3,d );

        L1 = eqisnfgentor( E );
	L2 = eqisnfbtac ( E );
	L3 = ecqnfbtlp( d, L1, L2, 0 );

	L1 = lfirst(  E );
	
        if( lfifth( L1 ) == _0 )
	{
	    L2 = list2( _0, L3 );
	}
	else
	{
	    L2 = list2( lfirst( lfifth( L1 ) ), L3 );
	}

	leset( L1, 5, L2 );
	leset(  E, 1, L1 );

	return( L3 );
    }

    return( lsecond( lfifth( lfirst( E ) ) ) );
}
