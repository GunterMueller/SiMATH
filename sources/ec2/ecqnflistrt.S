/*M
.SH NAME
ecqnflistrt - elliptic curve over quadratic number field, list of reduction types

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnflistrt(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q(D^(1/2)), as descripted in the documentation of 'ecqnfinit'.  
.PP
ecqnflistrt returns a list, say F.
.PP
 F = ( P_1 r_1 ... P_n r_n )
     list P_1, ..., P_n;
     single r_1, ..., r_n;, where
.TP 4
the P_i's, 1 <= i <= n,
are all prime ideals for which the curve E has bad reduction,
.TP 4
the r_i's, 1 <= i <= n, 
are the (Neron-)reduction types of the P_i's.
.PP
The P_i's are arranged by increasing norm,
.IP
norm(P_i) <= norm(P_i+1).
.PP
If the list E does not contain the list F, F will be computed and added to E.
E will be changed. 
 
.SH SEE ALSO
 ecqnfinit
 ecqnftatealg

M*/
        
/*H
	Version 1       25.02.1994      Josef Gebel
	Version 2       22.03.1996      Fehler beseitigt. JG.
   DATE ecqnflistrt   : 941201.960501
H*/

#include<_ec2.h>

list ecqnflistrt( E ) 
list E;
{
    bind( E );

    if( lsecond( lfourth( E ) ) == _0 )  
    {
        /*   Der Fuehrer von E/K ist noch nicht berechnet   */

        list L;
				 
        init( L );

	L = ecqnfcond( E );
    }

    return( lfourth( lsecond( lfourth( E ) ) ) );
}
