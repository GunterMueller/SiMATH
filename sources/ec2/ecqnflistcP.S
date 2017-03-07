/*M
.SH NAME
ecqnflistcP - elliptic curve over quadratic number field, list of all c_P-values

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnflistcP(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q(D^(1/2)), as descripted in the documentation of 'ecqnfinit'.  
.PP
ecqnflistcP returns a list, say F.
.PP
F = ( c c_1 ... c_n ) single c, c_1, ..., c_n;, where 
.TP 4
the c_i, 1 <= i <= n,
are the c_P values, arranged like the appropriate prime ideals in the factorization list of the conductor N (s. ecqnfpifcond and ecqnftatealg).
.TP 4
c
is the product over all c_i's.
.PP
If the list E does not contain the list F, F will be computed and added to E.
E will be changed.

.SH SEE ALSO
 ecqnfinit
 ecqnfpifcond
 ecqnftatealg

M*/
               
/*H
	Version 1       25.02.1994      Josef Gebel
	Version 2       23.11.1995      Wegen Aenderungen in ECQNFCOND 
                                        wurde LFIFTH durch LSIXTH 
                                        ersetzt. JG
   DATE ecqnflistcP   : 941201.951201
H*/

#include<_ec2.h>

list ecqnflistcP( E ) 
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

    return( lfifth( lsecond( lfourth( E ) ) ) );
}
