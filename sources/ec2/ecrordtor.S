/*M
.SH NAME
ecrordtor - elliptic curve over rational numbers, order of torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrordtor(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.           
.PP
ecrordtor returns the order of the torsion group of the elliptic curve E/Q.
If the list E does not contain the order, ecrordtor will (with help of ecisnftorgr) compute the order and add it to E. E will be changed.

.SH SEE ALSO
 ecrinit 
 ecisnftorgr

M*/
             
/*H
	Version 1 	17.12.1992	Josef Gebel (neues Konzept,
					ecrordtor ersetzt ECISNFTOR)
   DATE ecrordtor     : 930531
H*/

#include <_ec2.h>

ecrordtor( E )
list E;
{
        bind( E );
    if( lthird( lfourth( E ) ) == _0 )
    {
	/*   Torsionsgruppe noch nicht berechnet   */
    
        list L;

        /**bind( E ); **/
	init( L );

        L = ecisnftorgr( E );
    }

    return( lfirst( lthird( lfourth( E ) ) ) );
}
