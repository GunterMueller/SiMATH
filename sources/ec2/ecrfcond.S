/*M
.SH NAME
ecrfcond - elliptic curve over rational numbers, factorization of conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecrfcond(E)  
list E;
    
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.PP
ecrfcond returns the factorization of the conductor of the elliptic curve E/Q.
If the list E does not already contain the factorization of the conductor, it will be computed with help of ecrcond and added to E. E will be changed.

.SH SEE ALSO
 ecrinit 
 ecrcond

M*/

/*H
	Version 1	17.12.1992	Josef Gebel
   DATE ecrfcond      : 930531
H*/	

#include <_ec2.h>

list ecrfcond( E )
list E;
{
    if( lsecond( lfourth( E ) ) == _0 )
    {
	/*   Die Faktorisierung des Fuehrers ist noch nicht berechnet   */

        int N;

        bind( E );

        init( N );

	N = ecrcond( E );

        if( N == ERROR )
        {
	    return( ERROR );
        }
    }

    return( lsecond( lsecond( lfourth( E ) ) ) );
}   
