/*M
.SH NAME
ecracgentor - elliptic curve over rational numbers, actual curve, generators of torsion group 

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecracgentor(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
If the torsion group of the actual model of the curve E/Q is cyclic, ecracgentor returns a list,
consisting of three integers, defining a point on the curve E, which is a generator of the torsion group.
.PP
If the torsion group is bicyclic, ecracgentor returns a list, consisting of two lists of integers, defining two points on E, which are generators of the torsion
group.
.PP
If the list E does not contain the torsion group of the curve E, ecracgentor will compute it with help of ecisnfgentor, and add it to E. E will be changed.

.SH SEE ALSO
 ecrinit 
 ecisnfgentor

M*/
                
/*H
	Version 1 	23.12.1992	Josef Gebel (neues Konzept,
					ecracgentor ersetzt ECISNFTGTOR)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE ecracgentor   : 930531.931130
H*/

#include <_ec2.h>

list ecracgentor( E )
list E;
{
    if( ( lfifth( lfirst( E ) ) == _0 )
    ||  ( lsecond( lfifth( lfirst( E ) ) ) == _0 ) )
    {
	/*   EZS der Torsionsgruppe noch nicht berechnet   */

        list            L1, L2, L3;
    
        bind( E );

        init( L1, L2, L3 );

        L1 = ecisnfgentor( E );
	L2 = ecisnfbtac ( E );
	L3 = ecrbtlistp( L1, L2, 0 );

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
