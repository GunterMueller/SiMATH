/*M
.SH NAME
ecimintorgr - elliptic curve with integer coefficients, minimal model, torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimintorgr(E)  
list E;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
ecimintorgr returns a list
.IP
 (T1 T2 .... Tt) list T1, ...,Tt;
.PP
containing all points
.IP
Ti = (xi yi zi) int xi, yi, zi; (1 <= i <= t)
.PP
of the torsion group of the minimal model of restricted type of E/Q.
.PP
If necessary, the torsion group of the minimal model will be added to the list E.
The list E will be changed.

.SH SEE ALSO
ecrinit
                                          
M*/
                       
/*H
	Version 1 	18.12.1992	Josef Gebel (neues Konzept, 
					ecimintorgr ersetzt ECISNFTOR)
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
	Version 3	07.12.1994	Erzeuger der Torsionsgruppe werden
					ebenfalls in E eingetragen.  JG
   DATE ecimintorgr   : 930531.931130.951201
H*/

#include <_ec2.h>

list ecimintorgr( E )
list E;
{
    if( ( lfifth( lsecond( E ) ) == _0 )
    ||  ( lfirst( lfifth( lsecond( E ) ) ) == _0 ) )
    {
	/*  Torsionsgruppe des minmalen Modells noch nicht berechnet  */

        list L1, L2, L3, L4;
        
        bind(  E );

        init( L1, L2, L3, L4 );

	L1 = ecisnftorgr( E );
	L2 = ecisnfbtmin( E );
	L3 = ecrbtlistp( L1, L2, 0 );

	L1 = ecisnfgentor( E );
	L1 = ecrbtlistp( L1, L2, 0 );

	L2 = list2( L3, L1 );
        L1 = lsecond( E );
	
	leset( L1, 5, L2 );
	leset(  E, 2, L1 );

	return( L3 );
    }

    return( lfirst( lfifth( lsecond( E ) ) ) );
}
