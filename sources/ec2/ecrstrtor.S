/*M
.SH NAME
ecrstrtor - elliptic curve over rational numbers, structure of torsion group

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecrstrtor(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.  
.PP
Let T be the torsion group of the elliptic curve E/Q.
ecrstrtor returns a list, say L, where
.PP
 L = (t) single t;      if T is cyclic,
 L = (t/2 2) single t;  if T is bicyclic.
.PP
If the list E does not contain the list L, ecrstrtor will compute it with help of ecisnfgentor and add it to E. E will be changed.
 
.SH SEE ALSO
 ecrinit
 ecisnfgentor
 Literature: J.H. Silverman: 
             The arithmetic of elliptic curves.

M*/
                      
/*H
        Version 1       21.12.1992      Josef Gebel (neues Konzept,
					ecrstrtor ersetzt ECISNFTGTOR)
   DATE ecrstrtor     : 930531
H*/

#include <_ec2.h>

list ecrstrtor( E )
list E;
{
    list T;
  
    bind(  E );

    if( ( lthird( lfourth( E ) ) == _0 )
    ||  ( lsecond( lthird( lfourth( E ) ) ) == _0 ) )
    {
	/*   Struktur der Torsionsgruppe noch nicht berechnet   */

        init( T );
	T = ecisnfgentor( E );
    }

    return( lsecond( lthird( lfourth( E ) ) ) );
}
