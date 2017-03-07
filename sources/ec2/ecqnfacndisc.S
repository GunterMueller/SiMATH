/*M
.SH NAME
ecqnfacndisc - elliptic curve over quadratic number field, actual model,
norm of the discriminant

.SH SYNOPSIS
.nf
#include<_ec2.h>

rat ecqnfacndisc(E)
list E;

.SH DESCRIPTION
ecqnfacndisc() returns the norm of the discriminant of the elliptic curve E. 
If the norm of the discriminant is not yet computed, it will be computed 
and stored in E. The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
	Version 1       25.05.1993      Josef Gebel
	Version 1.1     21.04.1997      new: H (see leset) (Sus)
   DATE ecqnfacndisc  : 931130
H*/

#include<_ec2.h>

rat ecqnfacndisc( E ) 
list E;
{
    if( ( lfourth( lfirst( E ) ) == _0 )  
    ||  ( lthird( lfourth( lfirst( E ) ) ) == 0 ) )
    {
        /*   Die Norm der Diskriminanten ist noch nicht berechnet   */

        nfel DC;
	rat N;
	int DF;
        list L,H;
				 
        bind( E );

        init( L, H, N, DF, DC );

	DF = ecqnfflddisc( E );
	DC = ecqnfacdisc( E );
        N  = qnfnorm( DF, DC );

	L = lfirst( E );
	H = lfourth( L );
	leset( H, 3, N );
	leset( L, 4, H );
	leset( E, 1, L );

	return( N );
    }

    return( lthird( lfourth( lfirst( E ) ) ) );
}
