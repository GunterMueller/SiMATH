/*M
.SH NAME 
eqisnfbtac - elliptic curve over quadratic number field with integral
coefficients, short normal form, birational transformation to actual
model

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eqisnfbtac(E)
list   E;

.SH DESCRIPTION
eqisnfbtac() returns the birational transformation BT=(r, s, t, u) with
number field elements r,s,t,u. The transformation BT transforms the 
short normal form (with integral coefficients) of the curve E to a model in 
short normal form. If the transformation is not yet computed, it will be 
stored in E.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
M*/
/*H
        Version 1       23.03.1998      S. Schmitt
   DATE eqisnfbtac     :  980323
H*/

#include <_ec2.h>

list eqisnfbtac( E )
list E;
{
    if( ( lthird(E) == _0)
    ||  ( lsixth( lthird( E ) ) == _0 )
    ||  ( lfirst( lsixth( lthird( E ) ) ) == _0 ) )
    {
	/*   Birationale Transformation BT noch nicht berechnet   */
   
	int d; 
	list L1, L2, BT;

        bind( E );
	init(d);
        init( L1, L2, BT );

	d = ecqnfflddisc(E);
	
        BT = ecqnfbtsnf( E );
	BT = ecqnfbtinv( d, BT );
	
	L1 = lthird( E ); 
	if(lsixth(L1)!=_0)
	{
		L2 = lsixth( L1 );  /*   BTsm ist bereits in E vorhanden   */
		L2 = lsecond(L2);
	}
	else L2=_0;	
	L2 = list2( BT, L2 );

	leset( L1, 6, L2 );
	leset(  E, 3, L1 );
	
	return( BT );
    }
    
    return( lfirst( lsixth( lthird( E ) ) ) );
}   
