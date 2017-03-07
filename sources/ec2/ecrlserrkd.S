/*M
.SH NAME
ecrlserrkd - elliptic curve over the rationals, L-series, 'rank'-th derivative

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecrlserrkd(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.PP
Let r be the rank of the elliptic curve E/Q.
ecrlser returns the value (say v) of the r-th derivative of the L-series of E/Q at s = 1. If the list E does not contain v, ecrlserrkd will compute v and add it to E. E will be changed.

.SH SEE ALSO
 ecrinit
 ecrlserhd

M*/
     
/*H
	Version 1	21.01.1993	Josef Gebel
	Version 2	18.10.1993	Warnung des Apollo-Compilers
					beseitigt.  PS
	Version 3	03.04.1994	Statt ECRRANK nun neue Funktion 
                                        ECRLSERRKDS.  JG
   DATE ecrlserrkd    : 930531.931130.951201
H*/

#include <_ec2.h>

floating ecrlserrkd( E )
list E;
{
	bind(E);
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lthird( lfourth( lfourth( E ) ) ) == 0 ) )
    {
	/*   Der Rang ist noch nicht berechnet   */

        single   *A;
        floating f;

        init( f );

        A = NULL;
        if( ( A = ( single * ) ecrclser( E, A, 0 ) ) == NULL )
        {
            return( ERROR );
        }
        
        if( ( A = ( single * ) ecrlserrkds( E, A, &f ) ) == NULL )
        {
            return( ERROR );
        }
        return( f );
    }
    return( lthird( lfourth( lfourth( E ) ) ) );
}   
