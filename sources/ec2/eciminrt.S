/*M
.SH NAME
eciminrt - elliptic curve with integer coefficients, minimal model, reduction type

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eciminrt(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.    
.PP
eciminrt returns a list, say Ntr:
.IP
Ntr = ( p1 t1 ... pn tn ), where
.PP
 the pi's are all prime numbers for which E/Q has bad 
 reduction, and
 the ti's are the reduction types via Neron resp. Kodaira 
 with regard to the pi's (s. table of ecitatealg).
.PP
If the list E does not contain the list Ntr, eciminrt will compute it with help of ecrcond and add it to E.
 
.SH SEE ALSO
 ecrinit
 ecrcond
 ecitatealg

M*/

/*H
	Version 1	17.12.1992	Josef Gebel 
	Version 2	23.10.1995	ECIMINREDTYPE --> ECIMINRT  JG 
   DATE eciminrt      : 930531.951201
H*/	

#include <_ec2.h>

list eciminrt( E )
list E;
{
    int  N;

    bind( E );

    if( lsecond( lfourth( E ) ) == _0 )
    {
	/*   Die Liste Ntr ist noch nicht berechnet   */

        init( N );

	N = ecrcond( E );
    
        if( N == ERROR )
        {
	    return( ERROR );
        }
    }

    return( lfourth( lsecond( lfourth( E ) ) ) );
}   
