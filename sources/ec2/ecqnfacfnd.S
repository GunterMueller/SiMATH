/*M
.SH NAME
ecqnfacfnd - elliptic curve over quadratic number field, actual model,
factorization of the norm of the discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnfacfnd(E)
list E;

.SH DESCRIPTION
ecqnfacfnd() returns the factorization of the norm of the discriminant of 
the elliptic curve E. If the norm of the discriminant is 1, it returns
(1). Otherwise, it returns the list (p1 e1 ... pn en), where the 
pi are integer primes and ei are single precision numbers. This list
represents the factorization of the absolute value of the norm of the
discriminant. The primes are ordered in the following way. 
p1 > p2 > ... > pr are the primes which divide the numerator of the
norm of the discriminant, so that e1,...,er are positive,
p(r+1) > ... > pn are the primes which divide the denominator of
the norm of the discriminant, so that e(r+1),...,en are negative.
.PP
If the factorization of the norm of the discriminant is not yet computed, 
it will be computed and stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 2       23.10.1995      ECQNFACFNDISC --> ECQNFACFND  JG
	Version 2.1     21.04.1997      (1) falls NDisc Einheit (Sus)
   DATE ecqnfacfnd : 931130.951201
H*/

#include<_ec2.h>

list ecqnfacfnd( E ) 
list E;
{
    if( ( lfourth( lfirst( E ) ) == _0 )  
    ||  ( lfourth( lfourth( lfirst( E ) ) ) == 0 ) )
    {
        /*   Die Norm der Diskriminanten ist noch nicht berechnet   */

	rat N;
        int DF, num, den;
        list L, H, F;
				 
        bind( E );

        init( H, L, F );
	init( N, DF );

	DF = ecqnfflddisc( E );
	N  = ecqnfacndisc( E );

	num = iabs( rnum( N ) );
	den = rden( N );

	if( den != 1 )
	{
	    L = ifact( den );
	    L = ifel (  L  );
	    H = ifact( num );
	    H = ifel (  H  );
	    
	    F = _0;

	    while( L != _0 )
	    {
	        F = lcomp( (-1) * lsecond( L ), F );
	        F= lcomp( lfirst( L ), F );
	        L  = lred2( L );
	    }
	    
	    while( H != _0 )
	    {
	        F = lcomp( lsecond( H ), F );
	        F = lcomp( lfirst( H ), F );
	        H  = lred2( H );
	    }
	}
	else if(num != 1)
	{
	    F = ifact( ( num ) );
	    F = linv ( F );
	    F = ifel ( F );
	}
	else F = list1( 1 );

	L = lfirst ( E );
	H = lfourth( L );

	leset( H, 4, F );
	leset( L, 4, H );
	leset( E, 1, L );

	return( F );
    }

    return( lfourth( lfourth( lfirst( E ) ) ) );
}
    
