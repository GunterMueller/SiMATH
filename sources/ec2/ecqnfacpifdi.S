/*M
.SH NAME
ecqnfacpifdi - elliptic curve over quadratic number field, actual model,
prime ideal factorization of the discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfacpifdi(E)
list E;

.SH DESCRIPTION
ecqnfacpifdi() returns the factorization of the discriminant of the elliptic 
curve E into prime ideals. If the discriminant is a unit in K, it returns
(1). Otherwise, it returns the list 
.PP
( P_1  f_1  pi_1  z_1  ...  P_k  f_k  pi_k  z_k )  \   \    list  P_i;  
single  f_i, z_i;  nfel  pi_i;
.PP
with prime ideals P_i (see 'qnfidprod'), the corresponding exponents f_i in 
the prime ideal decomposition of the discriminant, prime elements pi_i, and 
z_i = 0, 1 or 2, if the prime ideal P_i divides an inert, ramified or split 
prime number in Q.
.PP
The prime ideals are ordered in the following way. At first there are 
the prime ideals which divide the numerator, ordered with ascending 
norms. Then there are the prime ideals which devide the denominator,
ordered with ascending norms, also.
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
	Version 1       25.05.1993      Josef Gebel
	Version 2       25.10.1995      QNFIELPIFACTS --> QNFIELPIFACT JG
	Version 2.1     21.04.1997      (1) falls Diskr. Einheit ist 
					Doku + Rueckgabe richtig 
					qnfpifact() aufgerufen (Sus)
   DATE ecqnfacpifdi  : 931130.951201
H*/

#include<_ec2.h>


list ecqnfacpifdi( E ) 
list E;
{
    if( ( lfourth( lfirst( E ) ) == _0 )  
    ||  ( lsecond( lfourth( lfirst( E ) ) ) == _0 ) )
    {
        /*   Die Faktorisieung der Diskriminanten    */
	/*   ist noch nicht berechnet                */

	nfel   DC;
        int    DF;
        list   L, M, H;
				 
        bind( E );

	init( DC );
        init( DF );
        init( L, M, H );

	DF = ecqnfflddisc( E );
	DC = ecqnfacdisc( E );
	L  = qnfpifact(DF,DC);
	
	M = lfirst ( E );
	H = lfourth( M );

   	leset( H, 2, L ); 
	leset( M, 4, H );
	leset( E, 1, M );

	return( L );
    }

    return( lsecond( lfourth( lfirst( E ) ) ) );
}




