/*M
.SH NAME
ecqnfpifcond - elliptic curve over quadratic number field, 
prime ideal factorization of the conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfpifcond(E)
list E;

.SH DESCRIPTION
ecqnfpifcond() returns the factorization of the conductor of the elliptic 
curve E into prime ideals. If the discriminant is a unit in K, it returns
(1). Otherwise, it returns the list 
.PP
( P_1  f_1  pi_1  z_1  ...  P_k  f_k  pi_k  z_k )  \   \    list  P_i;  
single  f_i, z_i;  nfel  pi_i;
.PP
with prime ideals P_i (see 'qnfidprod'), the corresponding exponents f_i in 
the prime ideal decomposition of the conductor, prime elements pi_i, and 
z_i = 0, 1 or 2, if the prime ideal P_i divides an inert, ramified or split 
prime number in Q. The prime ideals are ordered with ascending norm.
.PP
If the prime ideal factorization of the discriminant is not yet computed, 
it will be computed and stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.01.1994      Josef Gebel
   DATE ecqnfpifcond  : 941201
H*/

#include<_ec2.h>

list ecqnfpifcond( E ) 
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

    return( lsecond( lsecond( lfourth( E ) ) ) );
}
