/*M
.SH NAME
ecrexptor - elliptic curve over rational numbers, exponent of torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

single ecrexptor(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.         
.PP
ecrexptor returns the exponent of the torsion group of the elliptic curve E/Q, i.e. the smallest natural number n, for which n * T = (0 : 1 : 0) for all torsion points T on E/Q.
.PP
If the list E does not already contain the exponent, it will be computed with help of ecisnfgentor and added to E. E will be changed.
 
.SH SEE ALSO
 ecrinit 
 ecisnfgentor
 literature: J.H. Silverman, 
             The arithmetic of elliptic curves.
M*/
                  
/*H
        Version 1       18.12.1992      Josef Gebel
   DATE ecrexptor     : 930531
H*/

#include <_ec2.h>

ecrexptor( E )
list E;
{
    if( lsecond( lthird( lfourth( E ) ) ) == _0 )
    {
	/*   Exponent der Torsionsgruppe noch nicht berechnet   */

        list T;
  
        bind(  E );
        init( T );

	T = ecisnfgentor( E );
    }

    return( lfirst( lsecond( lthird( lfourth( E ) ) ) ) );
}
