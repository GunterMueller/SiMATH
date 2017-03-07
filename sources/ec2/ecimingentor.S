/*M
.SH NAME
ecimingentor - elliptic curve with integer coefficients, minimal model, generators of torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimingentor(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.PP
If the torsion group of the minimal model (of restricted typ, i.e. a1, a3 = 0 or 1, a2 = -1, 0, 1) of the curve E/Q is cyclic, ecimingentor returns a list, 
consisting of three integers, defining a point on the curve E, which is a generator of the torsion group.
.PP
If the torsion group is bicyclic, ecimingentor returns a list, consisting of two lists of integers, defining two points on E, which are generators of the torsion group.
.PP
If the list E does not contain the torsion group of the curve E, ecimingentor will compute it with help of ecisnfgentor, and add it to E. E will be changed.

.SH SEE ALSO
 ecrinit 
 ecisnfgentor

M*/
           
/*H
	Version 1 	20.12.1992      Josef Gebel (neues Konzept,
					ecimingentor ersetzt ecisnftorgf)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecimingentor  : 930531.931130
H*/

#include <_ec2.h>

list ecimingentor( E )
list E;
{
    if( ( lfifth( lsecond( E ) ) == _0 )
    ||  ( lsecond( lfifth( lsecond( E ) ) ) == _0 ) )
    {
	/*   EZS der Torsionsgruppe noch nicht berechnet   */

        list            L1, L2, L3;
    
        bind( E );

        init( L1, L2, L3 );

        L1 = ecisnfgentor( E );
	L2 = ecisnfbtmin ( E );
	L3 = ecrbtlistp( L1, L2, 0 );

	L1 = lsecond(  E );
	
        if( lfifth( L1 ) == _0 )
	{
	    L2 = list2( _0, L3 );
	}
	else
	{
	    L2 = list2( lfirst( lfifth( L1 ) ), L3 );
	}

	leset( L1, 5, L2 );
	leset(  E, 2, L1 );

	return( L3 );
    }

    return( lsecond( lfifth( lsecond( E ) ) ) );
}
